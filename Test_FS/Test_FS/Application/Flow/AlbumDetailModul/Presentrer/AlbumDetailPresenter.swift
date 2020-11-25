// ----------------------------------------------------------------------------
//
//  AlbumDetailPresenter.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 22.11.2020.
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

// MARK: - Protocols

protocol AlbumDetailControllerProtocol: AnyObject {
    func succes()
    func failure(error: Error)
    func setupAlbumDetail(albumName: String, artistName: String, artWork: String, musicStyle: String, trackCount: String, reliseDate: String)
}

protocol AlbumDetailPresenterProtocol: AnyObject {
    init(view: AlbumDetailControllerProtocol, networkService: ITunesDetailSearchService, id: Int, albumName: String, artistName: String, artWork: String, musicStyle: String, trackCount: Int, reliseDate: String)

    func getAlbumDetail()
    func sendAlbumDetail()
}

// ----------------------------------------------------------------------------

class AlbumDetailPresenter: AlbumDetailPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: AlbumDetailControllerProtocol?
    let networkService: ITunesDetailSearchService
    var albumDetail: [AlbumDetailModel]?
    let id: String
    let albumName: String
    let artistName: String
    let artWork: String
    let musicStyle: String
    let trackCount: String
    let reliseDate: String

    // MARK: - Init

    required init(view: AlbumDetailControllerProtocol, networkService: ITunesDetailSearchService, id: Int, albumName: String, artistName: String, artWork: String, musicStyle: String, trackCount: Int, reliseDate: String) {

        self.view = view
        self.networkService = networkService
        self.id = String(id)
        self.albumName = albumName
        self.artistName = artistName
        self.artWork = artWork
        self.musicStyle = musicStyle
        self.trackCount =  String(trackCount)
        self.reliseDate = reliseDate
    }

    //MARK: - Public Methods

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

    func sendAlbumDetail() {
        self.view?.setupAlbumDetail(albumName: albumName,
                                    artistName: artistName,
                                    artWork: artWork,
                                    musicStyle: musicStyle,
                                    trackCount: trackCount,
                                    reliseDate: reliseDate)
    }
}
