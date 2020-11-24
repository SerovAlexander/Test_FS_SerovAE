// ----------------------------------------------------------------------------
//
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

    func albumsRequest(with query: String, then completion: @escaping CompletionAlbums) {

        CancelAllRequest.cancel()

        let parameters = createParameters(with: query)
        let request = WebRequest(method: .get, url: Inner.searchUrl, parameters: parameters)
        
        AF.request(request.url, method: request.method, parameters: request.parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try Inner.decoder.decode(ITunesSearchResult<AlbumSearchModel>.self, from: data)
                    let albums = result.results
                    completion(.success(albums))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func createParameters(with query: String) -> Parameters {
        var parameters: Parameters = [:]
        parameters[Inner.Parameter.query] = query
        parameters[Inner.Parameter.regionCode] = Inner.defaultRegionCode
        parameters[Inner.Parameter.mediaType] = Inner.mediaType
        parameters[Inner.Parameter.entity] = Inner.albumEntity

        return parameters
    }

    // MARK: - Inner Types

    public typealias CompletionAlbums = (Result<[AlbumSearchModel], Error>) -> Void

    // MARK: - Constants

    private struct Inner {
        static let decoder = JSONDecoder()
        static let searchUrl = "https://itunes.apple.com/search?"
        static let defaultRegionCode = "RU"
        static let mediaType = "music"
        static let albumEntity = "album"
        static let songEntity = "song"

        struct Parameter {
            static let query = "term"
            static let id = "id"
            static let regionCode = "country"
            static let mediaType = "media"
            static let entity = "entity"
        }
    }
}
