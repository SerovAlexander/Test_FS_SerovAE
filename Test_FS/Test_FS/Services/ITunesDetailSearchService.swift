//
//  ITunesDetailSearchService.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 24.11.2020.
//

import Alamofire
import Foundation

final class ITunesDetailSearchService {
    
    public typealias CompletionDetails = (Result<[AlbumDetailModel], Error>) -> Void
    
    private let decoder = JSONDecoder()
    
    private let lookupUrl = "https://itunes.apple.com/lookup?"
    
    private let defaultRegionCode = "RU"
    private let songEntity = "song"

    private struct Parameter {
        static let id = "id"
        static let regionCode = "country"
        static let entity = "entity"
    }

    func albumDetailRequest(with id: String, then completion: @escaping CompletionDetails) {

        let parameters = createParameters(with: id)
        let request = WebRequest(method: .get, url: lookupUrl, parameters: parameters)

        AF.request(request.url, method: request.method, parameters: request.parameters).responseData { [weak self] response in
            guard let self = self else {
                completion(.success([]))

                return
            }
            switch response.result {
            case let .success(data):
                do {
                        let result = try self.decoder.decode(ITunesSearchResult<AlbumDetailModel>.self, from: data)
                        var albumsDetail = result.results
                        //Json is returned where the album details and the list of songs are at the same nesting level. And if the first element is of the collection wrapperType, I delete it so that it does not appear in the table with the list of songs
                        if !albumsDetail.isEmpty && albumsDetail[0].wrapperType == "collection" {
                        albumsDetail.remove(at: 0)
                        }
                        completion(.success(albumsDetail))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func createParameters(with id: String?) -> Parameters {
        var parameters: Parameters = [:]
        
            parameters[Parameter.regionCode] = defaultRegionCode
            parameters[Parameter.id] = id
            parameters[Parameter.entity] = songEntity

        return parameters
    }

}
