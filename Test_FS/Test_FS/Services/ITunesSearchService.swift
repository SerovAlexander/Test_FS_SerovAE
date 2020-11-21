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

    public typealias CompletionAlbums = (Result<[AlbumModel], Error>) -> Void

    private let decoder = JSONDecoder()

     enum BaseUrl: String {
        case searchUrl = "https://itunes.apple.com/search?"
        case lookupUrl = "https://itunes.apple.com/lookup?"
    }
    
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


    public func itunesRequest(with url: BaseUrl, forQuery query: String?, id: String?, then completion: @escaping CompletionAlbums) {

        let parameters = createParameters(url: url, query: query, id: id)

        let request = WebRequest(method: .get, url: url.rawValue, parameters: parameters)

        AF.request(request.url, method: request.method, parameters: request.parameters).responseData { [weak self] response in
            guard let self = self else {
                completion(.success([]))

                return
            }
            switch response.result {
            case let .success(data):
                do {
                    let result = try self.decoder.decode(ITunesSearchResult<AlbumModel>.self, from: data)
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
    
    private func createParameters(url: BaseUrl, query: String?, id: String?) -> Parameters {
        var parameters: Parameters = [:]
        switch url {
        case .searchUrl:
            parameters[Parameter.query] = query
            parameters[Parameter.regionCode] = defaultRegionCode
            parameters[Parameter.mediaType] = mediaType
            parameters[Parameter.entity] = albumEntity
        case .lookupUrl:
            parameters[Parameter.regionCode] = defaultRegionCode
            parameters[Parameter.id] = id
            parameters[Parameter.entity] = songEntity
        }

        return parameters
    }

}
