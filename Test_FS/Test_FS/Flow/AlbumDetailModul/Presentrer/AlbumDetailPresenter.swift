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
    init(view: AlbumDetailControllerProtocol, networkService: ITunesSearchService, id: Int )
    
    func getAlbumDetail()
}

class AlbumDetailPresenter: AlbumDetailPresenterProtocol {
    

    weak var view: AlbumDetailControllerProtocol?
    let networkService: ITunesSearchService
    let id: String
    var albumDetail: [AlbumDetailModel]?

    required init(view: AlbumDetailControllerProtocol, networkService: ITunesSearchService, id: Int) {
        self.view = view
        self.networkService = networkService
        self.id = String(id)
    }

     func getAlbumDetail() {
        networkService.itunesRequest(with: .lookupUrl, forQuery: nil, id: id, modelType: .albumDetailModel) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(album):
                self.albumDetail = album as? [AlbumDetailModel]
                DispatchQueue.main.async {
                    self.view?.succes()
                }
                
            case let .failure(error):
                self.view?.failure(error: error)
            }

        }
    }

}
