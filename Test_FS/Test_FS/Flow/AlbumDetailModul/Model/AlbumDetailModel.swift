//
//  AlbumDetailModel.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 21.11.2020.
//

import Foundation

public struct AlbumDetailModel: Codable {

    public var artistName: String
    public var collectionName: String
    public var artwork: String
    public var trackName: String?
    public var trackNumber: Int?
    public var musicStyle: String?
    public var trackCount: Int?
    public var releaseDate: String?
    public var wrapperType: String
    

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case artistName, collectionName,trackName, trackNumber, releaseDate, trackCount, wrapperType
        case artwork = "artworkUrl100"
        case musicStyle = "primaryGenreName"
    }
}
