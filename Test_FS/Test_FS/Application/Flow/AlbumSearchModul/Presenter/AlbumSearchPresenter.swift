// ----------------------------------------------------------------------------

//  AlbumSearchPresenter.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 22.11.2020.
// ----------------------------------------------------------------------------

import Alamofire
import Foundation

// ----------------------------------------------------------------------------

    // MARK: - Protocols

protocol AlbumSearchControllerProtocol: AnyObject {
    func refreshData()
    func failure(error: Error)
    func showBackground()
    func hideBackground()
    func showNoResultBackground()
    func showIndicator()
    func stopIndicator()
}

protocol AlbumSearchPresenterProtocol: AnyObject  {
    init(view: AlbumSearchControllerProtocol, networkService: ITunesAlbumSearchService)

    func searchAlbum(with query: String)
    var albums: [AlbumSearchModel]? { get set }

}


// ----------------------------------------------------------------------------

class AlbumSearchPresenter: AlbumSearchPresenterProtocol {

    // MARK: - Properties

    weak var view: AlbumSearchControllerProtocol?
    let networkService: ITunesAlbumSearchService
    var albums: [AlbumSearchModel]?
    private var searchTask: DispatchWorkItem?

    // MARK: - Init

    required init(view: AlbumSearchControllerProtocol, networkService: ITunesAlbumSearchService) {
        self.view = view
        self.networkService = networkService
    }

    // MARK: - Public Methods

    func searchAlbum(with query: String) {
        searchTask?.cancel()
        if checkIsQueryEmpty(query: query) {
            return
        }
        // Create DispatchWorkItem Task
        self.searchTask = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.view?.showIndicator()
            self.reqest(with: query)
        }
        // send request with delay using DispatchWorkItem Task
        if let task = searchTask {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: task)
        }
    }
    // MARK: - Private Methods

    private func checkIsAlbumsEmpty() {
        if albums?.isEmpty ?? true {
            self.view?.showNoResultBackground()
        } else {
            self.view?.hideBackground()
        }
    }

    private func checkIsQueryEmpty(query: String) -> Bool {
        var isEmpty = false
        if query.isEmpty {
            albums = []
            self.view?.refreshData()
            self.view?.showBackground()
            isEmpty = true
        }
        return isEmpty
    }

    private func reqest(with query: String) {
        self.networkService.albumsRequest(with: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let albums):
                self.albums = albums
                DispatchQueue.main.async {
                    self.view?.stopIndicator()
                    self.view?.refreshData()
                    self.checkIsAlbumsEmpty()
                }
            case .failure(let error):
                self.view?.stopIndicator()
                self.view?.failure(error: error)
            }
        }
    }

}
