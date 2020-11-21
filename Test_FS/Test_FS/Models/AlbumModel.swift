// ----------------------------------------------------------------------------

//  AlbumModel.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public struct AlbumModel: Codable {

    public var artistName: String
    public var collectionName: String
    public var artwork: String
    public var collectionId: Int?
    public var trackName: String?
    public var trackNumber: Int?

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case artistName, collectionName, collectionId,trackName, trackNumber
        case artwork = "artworkUrl100"
    }
}