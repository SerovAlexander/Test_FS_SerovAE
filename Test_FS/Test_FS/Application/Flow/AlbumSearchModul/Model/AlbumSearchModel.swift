// ----------------------------------------------------------------------------

//  AlbumModel.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public struct AlbumSearchModel: Codable {

    // MARK: - Properties

    public var artistName: String
    public var collectionName: String
    public var artwork: String
    public var collectionId: Int
    public var collectionExplicitness: String
    public var musicStyle: String
    public var trackCount: Int
    public var releaseDate: String
    

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case artistName, collectionName, collectionId, collectionExplicitness, trackCount, releaseDate
        case artwork = "artworkUrl100"
        case musicStyle = "primaryGenreName"
    }
}
