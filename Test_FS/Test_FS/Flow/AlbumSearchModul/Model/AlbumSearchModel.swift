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

    public var artistName: String
    public var collectionName: String
    public var artwork: String
    public var collectionId: Int
    public var collectionExplicitness: String
    
    

    

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case artistName, collectionName, collectionId, collectionExplicitness
        case artwork = "artworkUrl100"
    }
}
