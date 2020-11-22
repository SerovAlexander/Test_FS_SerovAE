//
//  AlbumSearchPresenter.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 22.11.2020.
//

import Foundation

protocol AlbumSearchControllerProtocol: AnyObject {
    func succes()
    func failure(error: Error)

}

protocol AlbumSearchPresenterProtocol: AnyObject  {
    init(view: AlbumSearchControllerProtocol, networkService: ITunesSearchService)
    func searchAlbum(with query: String)
    var albums: [AlbumSearchModel]? { get set }

}

class AlbumSearchPresenter: AlbumSearchPresenterProtocol {

    weak var view: AlbumSearchControllerProtocol?
    let networkService: ITunesSearchService
    var albums: [AlbumSearchModel]?

    required init(view: AlbumSearchControllerProtocol, networkService: ITunesSearchService) {
        self.view = view
        self.networkService = networkService
    }

    func searchAlbum(with query: String) {
        networkService.itunesRequest(with: .searchUrl, forQuery: query, id: nil, modelType: .albumSearchModel) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let albums):
                self.albums = albums as? [AlbumSearchModel] 
                DispatchQueue.main.async {
                    self.view?.succes()
                }
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }

}
