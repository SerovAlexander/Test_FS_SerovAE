// ----------------------------------------------------------------------------

//  AlbumListViewModel.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

class AlbumListViewModel {

    let artistName: String
    let collectionName: String
    let artwork: String

    init(albumModel: ITunesAlbumModel) {
        self.artistName = albumModel.artistName
        self.collectionName = albumModel.collectionName
        self.artwork = albumModel.artwork
    }
}
