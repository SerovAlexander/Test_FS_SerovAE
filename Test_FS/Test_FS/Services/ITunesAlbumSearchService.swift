// ----------------------------------------------------------------------------

//  ITunesAlbumSearchService.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//
// ----------------------------------------------------------------------------

import Alamofire
import Foundation

// ----------------------------------------------------------------------------

final class ITunesAlbumSearchService {

    public typealias CompletionAlbums = (Result<[AlbumSearchModel], Error>) -> Void

    private let decoder = JSONDecoder()


    private var searchUrl = "https://itunes.apple.com/search?"

    private let defaultRegionCode = "RU"
    private let mediaType = "music"
    private let albumEntity = "album"
    private let songEntity = "song"

    private struct Parameter {
        static let query = "term"
        static let id = "id"
        static let regionCode = "country"
        static let mediaType = "media"
        static let entity = "entity"
    }
    
    func albumsRequest(with query: String, then completion: @escaping CompletionAlbums) {

        CancelAllRequest.cancel()

        let parameters = createParameters(with: query)
        let request = WebRequest(method: .get, url: searchUrl, parameters: parameters)
        
        AF.request(request.url, method: request.method, parameters: request.parameters).responseData { [weak self] response in
            guard let self = self else {
                completion(.success([]))

                return
            }
            switch response.result {
            case let .success(data):
                do {
                    let result = try self.decoder.decode(ITunesSearchResult<AlbumSearchModel>.self, from: data)
                    let albums = result.results
                    print(albums)
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

    private func createParameters(with query: String) -> Parameters {
        var parameters: Parameters = [:]
        parameters[Parameter.query] = query
        parameters[Parameter.regionCode] = defaultRegionCode
        parameters[Parameter.mediaType] = mediaType
        parameters[Parameter.entity] = albumEntity

        return parameters
    }

}
