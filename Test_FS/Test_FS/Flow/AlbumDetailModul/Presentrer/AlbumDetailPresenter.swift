//
//  AlbumDetailPresenter.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 22.11.2020.
//

import Foundation

protocol AlbumDetailControllerProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol AlbumDetailPresenterProtocol: AnyObject {
    init(view: AlbumDetailControllerProtocol, networkService: ITunesDetailSearchService, id: Int )
    
    func getAlbumDetail()
}

class AlbumDetailPresenter: AlbumDetailPresenterProtocol {
    

    weak var view: AlbumDetailControllerProtocol?
    let networkService: ITunesDetailSearchService
    let id: String
    var albumDetail: [AlbumDetailModel]?

    required init(view: AlbumDetailControllerProtocol, networkService: ITunesDetailSearchService, id: Int) {
        self.view = view
        self.networkService = networkService
        self.id = String(id)
    }

     func getAlbumDetail() {
        networkService.albumDetailRequest(with: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(album):
                self.albumDetail = album
                DispatchQueue.main.async {
                    self.view?.succes()
                }
            case let .failure(error):
                self.view?.failure(error: error)
            }
        }
    }

}
