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
    

    var collectionId: String?
    var albumImage: String = ""
    private let networkService = ITunesSearchService()
    private var album: [AlbumModel] = []
    
    //MARK: - UI
    private let albumImageView = UIImageView()
    private let tableView = UITableView()

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        requestAlbumDetail()
        setupAlbumImageView(with: albumImage)
        setupTableView()
        setupConstreints()
    }
    
    

    //MARK: - Configure UI

    private func setupAlbumImageView(with artwork: String) {
        self.view.addSubview(albumImageView)
        albumImageView.contentMode = .scaleAspectFit
        let url = URL(string: artwork)
        albumImageView.kf.setImage(with: url)
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        tableView.register(AlbumDetailCell.self, forCellReuseIdentifier: "cellId")
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
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
    }

    //MARK: - Private Methods

    private func requestAlbumDetail() {
        networkService.itunesRequest(with: .lookupUrl, forQuery: nil, id: collectionId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(album):
                self.album = album
                self.album.remove(at: 0)
                DispatchQueue.main.async {
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
