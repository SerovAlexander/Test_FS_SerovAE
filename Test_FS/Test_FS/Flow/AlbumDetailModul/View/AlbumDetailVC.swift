//
//  AlbumDetailVC.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 21.11.2020.
//

import Kingfisher
import SnapKit
import UIKit

class AlbumDetailVC: UIViewController {
    

    var id: String = ""
    private let networkService = ITunesSearchService()
    private var album: [AlbumSearchModel] = []
    
    //MARK: - UI
    private let albumImageView = UIImageView()
    private let tableView = UITableView()
    private let artistNameLabel = UILabel()
    private let collectionNameLabel = UILabel()
    

    //MARK: - Life Cycle

    override func loadView() {
        super.loadView()
        requestAlbumDetail()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupTableView()
        setupAlbumImageView()
        setupArtistNameLable()
        setupCollectionNameLabel()
        setupConstreints()
    }
    
    

    //MARK: - Configure UI

    private func setupAlbumImageView() {
        self.view.addSubview(albumImageView)
        albumImageView.contentMode = .scaleAspectFit
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        tableView.register(AlbumDetailCell.self, forCellReuseIdentifier: "cellId")
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func setupArtistNameLable() {
        self.view.addSubview(artistNameLabel)
        artistNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func setupCollectionNameLabel() {
        self.view.addSubview(collectionNameLabel)
        collectionNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    private func configure(with image: String) {
        let url = URL(string: image)
        albumImageView.kf.setImage(with: url)
        
        artistNameLabel.text = album[0].artistName
        collectionNameLabel.text = album[0].collectionName
    }

    //Setup constreints with SnapKit
    private func setupConstreints() {
        albumImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().inset(10)
            make.height.width.equalTo(100)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(10)
            make.right.left.bottom.equalToSuperview()
        }

        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.equalTo(albumImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
        }

        collectionNameLabel.snp.makeConstraints { make in
            make.top.equalTo(artistNameLabel.snp.bottom).offset(5)
            make.left.equalTo(albumImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
        }
    }

    //MARK: - Private Methods

    private func requestAlbumDetail() {
        networkService.itunesRequest(with: .lookupUrl, forQuery: nil, id: id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(album):
                self.album = album
                self.album.remove(at: 0)
                DispatchQueue.main.async {
                    self.configure(with: album[0].artwork)
                    self.tableView.reloadData()
                }
                
            case let .failure(error):
                print(error)
            }

        }
    }

}

extension AlbumDetailVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        album.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? AlbumDetailCell else { return UITableViewCell() }
        let track = album[indexPath.row]
        cell.cellConfigure(with: track)

        return cell
    }

}

