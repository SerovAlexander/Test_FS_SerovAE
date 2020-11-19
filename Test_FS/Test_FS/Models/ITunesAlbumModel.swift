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

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case artistName, collectionName
        case artwork = "artworkUrl100"
    }

    //MARK: - Init

    init(artistName: String, collectionName: String, artwork: String) {
        self.artistName = artistName
        self.collectionName = collectionName
        self.artwork = artwork
    }

}
