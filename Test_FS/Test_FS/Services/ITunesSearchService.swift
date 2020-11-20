// ----------------------------------------------------------------------------

//  ITunesSearchService.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//
// ----------------------------------------------------------------------------

import Alamofire
import Foundation

// ----------------------------------------------------------------------------

final class ITunesSearchService {

    public typealias CompletionAlbums = (Result<[ITunesAlbumModel], Error>) -> Void

    private let decoder = JSONDecoder()

    private let baseUrl = "https://itunes.apple.com/search?"
    private let defaultRegionCode = "ru"
    private let mediaType = "music"
    private let entity = "album"

    private struct Parameter {
        static let query = "term"
        static let regionCode = "country"
        static let mediaType = "media"
        static let entity = "entity"
    }


    public func getAlbums(forQuery query: String, then completion: @escaping CompletionAlbums) {
        var parameters: Parameters = [:]
        parameters[Parameter.query] = query
        parameters[Parameter.regionCode] = defaultRegionCode
        parameters[Parameter.mediaType] = mediaType
        parameters[Parameter.entity] = entity

        let request = WebRequest(method: .get, url: baseUrl, parameters: parameters)

        AF.request(request.url, method: request.method, parameters: request.parameters).responseData { [weak self] response in
            guard let self = self else {
                completion(.success([]))
                return
            }
            switch response.result {
            case let .success(data):
                do {
                    let result = try self.decoder.decode(ITunesSearchResult<ITunesAlbumModel>.self, from: data)
                    let albums = result.results
                    completion(.success(albums))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
