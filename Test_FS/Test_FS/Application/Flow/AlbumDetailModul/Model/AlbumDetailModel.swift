// ----------------------------------------------------------------------------
//
//  AlbumDetailModel.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 21.11.2020.
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

public struct AlbumDetailModel: Codable {

    // MARK: - Properties

    public var trackName: String?
    public var trackNumber: Int?
    public var wrapperType: String

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case trackName, trackNumber, wrapperType
    }
}
