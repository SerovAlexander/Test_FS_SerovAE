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
    public var trackName: String
    public var trackNumber: Int

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case artistName, collectionName, trackName, trackNumber
        case artwork = "artworkUrl100"
    }
}
