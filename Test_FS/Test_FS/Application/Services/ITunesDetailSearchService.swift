// ----------------------------------------------------------------------------
//
//  ITunesDetailSearchService.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 24.11.2020.
//
// ----------------------------------------------------------------------------

import Alamofire
import Foundation

// ----------------------------------------------------------------------------

final class ITunesDetailSearchService {
    // MARK: - Methods

    func albumDetailRequest(with id: String, then completion: @escaping CompletionDetails) {
        let parameters = createParameters(with: id)
        let request = WebRequest(method: .get, url: Inner.lookupUrl, parameters: parameters)

        AF.request(request.url, method: request.method, parameters: request.parameters).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let result = try Inner.decoder.decode(ITunesSearchResult<AlbumDetailModel>.self, from: data)
                    var albumDetail = result.results
                    self.checkFirstElement(albumDetail: &albumDetail)
                    completion(.success(albumDetail))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    // MARK: - Private Methods

    private func createParameters(with id: String?) -> Parameters {
        var parameters: Parameters = [:]

        parameters[Inner.Parameter.regionCode] = Inner.defaultRegionCode
        parameters[Inner.Parameter.id] = id
        parameters[Inner.Parameter.entity] = Inner.songEntity

        return parameters
    }

    // In the returned JSON, the album information and the song list are at the same nesting level. If the wrapperType of the first element is == collection - I remove it.
    private func checkFirstElement(albumDetail: inout [AlbumDetailModel]) {
        if !albumDetail.isEmpty && albumDetail[0].wrapperType == "collection" {
        albumDetail.remove(at: 0)
        }
    }

    // MARK: - Inner Types

    public typealias CompletionDetails = (Result<[AlbumDetailModel], Error>) -> Void

    // MARK: - Constants

    private struct Inner {
        static let decoder = JSONDecoder()
        static let lookupUrl = "https://itunes.apple.com/lookup?"
        static let defaultRegionCode = "RU"
        static let songEntity = "song"

        struct Parameter {
            static let id = "id"
            static let regionCode = "country"
            static let entity = "entity"
        }
    }
}
