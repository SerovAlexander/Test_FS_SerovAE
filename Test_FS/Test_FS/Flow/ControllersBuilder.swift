//
//  ControllersBuilder.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 22.11.2020.
//

import UIKit
protocol BuilderModulProtocol {
    static func createAlbumSerachController() -> UICollectionViewController
    static func createAlbumDetailController(id: Int) -> UIViewController
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

    static func createAlbumDetailController(id: Int) -> UIViewController {
        let view = AlbumDetailController()
        let networkService = ITunesDetailSearchService()
        let presenter = AlbumDetailPresenter(view: view, networkService: networkService, id: id)
        view.presenter = presenter

        return view
    }

}
