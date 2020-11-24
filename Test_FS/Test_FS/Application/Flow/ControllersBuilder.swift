// ----------------------------------------------------------------------------
//
//  ControllersBuilder.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 22.11.2020.
//
// ----------------------------------------------------------------------------

import UIKit

// ----------------------------------------------------------------------------

//Builder class for initialisation controllers

protocol BuilderModulProtocol {
    static func createAlbumSerachController() -> UICollectionViewController
    static func createAlbumDetailController(id: Int, albumName: String, artistName: String, artWork: String, musicStyle: String, trackCount: Int, reliseDate: String) -> UIViewController
}

class ControllersBuilder: BuilderModulProtocol {

    static func createAlbumSerachController() -> UICollectionViewController {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        let view = AlbumSearchController(collectionViewLayout: flowLayout)
        let networkService = ITunesAlbumSearchService()
        let presenter = AlbumSearchPresenter(view: view, networkService: networkService)
        view.presenter = presenter

        return view
    }

    static func createAlbumDetailController(id: Int, albumName: String, artistName: String, artWork: String, musicStyle: String, trackCount: Int, reliseDate: String) -> UIViewController {
        let view = AlbumDetailController()
        let networkService = ITunesDetailSearchService()
        let presenter = AlbumDetailPresenter(view: view,
                                             networkService: networkService,
                                             id: id,
                                             albumName: albumName,
                                             artistName: artistName,
                                             artWork: artWork,
                                             musicStyle: musicStyle,
                                             trackCount: trackCount,
                                             reliseDate: reliseDate)
        view.presenter = presenter

        return view
    }

}
