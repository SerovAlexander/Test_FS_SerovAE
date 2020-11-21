// ----------------------------------------------------------------------------

//  ITunesAlbumModel.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public struct ITunesAlbumModel: Codable {

    public var artistName: String
    public var collectionName: String
    public var artwork: String
    public var collectionId: Int

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case artistName, collectionName, collectionId
        case artwork = "artworkUrl100"
    }
}
