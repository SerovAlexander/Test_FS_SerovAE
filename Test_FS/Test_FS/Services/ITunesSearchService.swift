// ----------------------------------------------------------------------------

//  ITunesSearchService.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//
// ----------------------------------------------------------------------------

import Alamofire

// ----------------------------------------------------------------------------

final class ITunesSearchService {

    private let decoder = JSONDecoder()

    private let baseUrl = "https://itunes.apple.com/search"
    private let defaultRegionCode = "RU"
    private let mediaType = "music"
    private let entity = "album"

    private struct Parameter {
        static let query = "term"
        static let regionCode = "country"
        static let mediaType = "media"
        static let entity = "entyti"
    }


    public func getAlbums(forQuery query: String, then commpletion: @escaping (AFResult<[String: Any]?>) -> Void) {
        var parameters: Parameters = [:]
        parameters[Parameter.query] = query
        parameters[Parameter.regionCode] = defaultRegionCode
        parameters[Parameter.mediaType] = mediaType
        parameters[Parameter.entity] = entity

        let request = WebRequest(method: .get, url: baseUrl, parameters: parameters)

        AF.request(request.url, method: request.method, parameters: request.parameters).responseJSON { response in
            switch response.result {
            case let .success(json):
                commpletion(.success(json as? [String: Any]))
            case let .failure(error):
                commpletion(.failure(error))
            }
        }
    }


}
