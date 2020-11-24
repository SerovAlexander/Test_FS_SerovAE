//
//  AlbumSearchPresenter.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 22.11.2020.
//

import Alamofire
import Foundation

protocol AlbumSearchControllerProtocol: AnyObject {
    func refreshData()
    func failure(error: Error)
    func showBackground()
    func hideBackground()
    func showNoResultBackground()
    
}

protocol AlbumSearchPresenterProtocol: AnyObject  {
    init(view: AlbumSearchControllerProtocol, networkService: ITunesAlbumSearchService)
    
    func searchAlbum(with query: String)
    func checkIsEmpty()
    var albums: [AlbumSearchModel]? { get set }
    
}

class AlbumSearchPresenter: AlbumSearchPresenterProtocol {
    
    

    weak var view: AlbumSearchControllerProtocol?
    let networkService: ITunesAlbumSearchService
    var albums: [AlbumSearchModel]?
    var searchTask: DispatchWorkItem?
    
    required init(view: AlbumSearchControllerProtocol, networkService: ITunesAlbumSearchService) {
        self.view = view
        self.networkService = networkService
    }
    
    func searchAlbum(with query: String) {
        searchTask?.cancel()
        if query.isEmpty {
            albums = []
            self.view?.refreshData()
            self.view?.showBackground()
            return
        }
        self.searchTask = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.networkService.albumsRequest(with: query) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let albums):
                    self.albums = albums
                    DispatchQueue.main.async {
                        self.view?.refreshData()
                        self.checkIsEmpty()
                    }
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
        if let task = searchTask {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: task)
        }
    }

    func checkIsEmpty() {
        if albums?.isEmpty ?? true {
            self.view?.showNoResultBackground()
        } else {
            self.view?.hideBackground()
        }
    }
}
