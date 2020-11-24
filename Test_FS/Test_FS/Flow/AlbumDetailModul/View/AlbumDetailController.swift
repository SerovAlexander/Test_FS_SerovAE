//
//  AlbumDetailVC.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 21.11.2020.
//

import Kingfisher
import SnapKit
import UIKit

class AlbumDetailController: UIViewController {

    var presenter: AlbumDetailPresenter!

    //MARK: - UI
    private let albumImageView = UIImageView()
    private let tableView = UITableView()
    private let artistNameLabel = UILabel()
    private let collectionNameLabel = UILabel()
    private let musicStyleLabel = UILabel()
    private let trackCountLabel = UILabel()
    private let releaseDateLabel = UILabel()

    //MARK: - Life Cycle

    override func loadView() {
        super.loadView()
        presenter.getAlbumDetail()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupAlbumImageView()
        setupArtistNameLable()
        setupCollectionNameLabel()
        setupMusicStyleLabel()
        setupTrackCountLabel()
        setupReleaseDateLabel()
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
        artistNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
    }

    private func setupCollectionNameLabel() {
        self.view.addSubview(collectionNameLabel)
        collectionNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    private func setupMusicStyleLabel() {
        self.view.addSubview(musicStyleLabel)
        musicStyleLabel.font = UIFont.systemFont(ofSize: 12)
        musicStyleLabel.textColor = .systemGray3
    }
    
    private func setupTrackCountLabel() {
        self.view.addSubview(trackCountLabel)
        trackCountLabel.font = UIFont.systemFont(ofSize: 12)
        trackCountLabel.textColor = .systemGray3
    }
    
    private func setupReleaseDateLabel() {
        self.view.addSubview(releaseDateLabel)
        releaseDateLabel.font = UIFont.systemFont(ofSize: 12)
        releaseDateLabel.textColor = .systemGray3
    }

    //Setup constreints with SnapKit
    private func setupConstreints() {
        albumImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().inset(10)
            make.height.width.equalTo(130)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(10)
            make.right.left.bottom.equalToSuperview()
        }

        collectionNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.left.equalTo(albumImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
        }

        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionNameLabel.snp.bottom).offset(5)
            make.left.equalTo(albumImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        musicStyleLabel.snp.makeConstraints { make in
            make.top.equalTo(artistNameLabel.snp.bottom).offset(10)
            make.left.equalTo(albumImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        trackCountLabel.snp.makeConstraints { make in
            make.top.equalTo(musicStyleLabel.snp.bottom).offset(1)
            make.left.equalTo(musicStyleLabel.snp.left)
            make.right.equalTo(musicStyleLabel.snp.right)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(trackCountLabel.snp.bottom).offset(1)
            make.left.equalTo(musicStyleLabel.snp.left)
            make.right.equalTo(musicStyleLabel.snp.right)
        }
    }

}

extension AlbumDetailController: AlbumDetailControllerProtocol {
    func succes() {
        guard let albumDetail  = presenter.albumDetail else { return }
        let url = URL(string: albumDetail[0].artwork)
        self.albumImageView.kf.setImage(with: url)
        self.artistNameLabel.text = albumDetail[0].artistName
        self.collectionNameLabel.text = albumDetail[0].collectionName
        self.musicStyleLabel.text = albumDetail[0].musicStyle
        self.trackCountLabel.text = "Объектов:" + " " + String(albumDetail[0].trackCount ?? 0)
        
        self.releaseDateLabel.text = "Релиз:" + " " + (albumDetail[0].releaseDate?.toStringDate() ?? "Дата не известна") 
        self.tableView.reloadData()
    }

    func failure(error: Error) {
        Alerts.presentAlert(view: self.view, viewController: self)
    }

}

extension AlbumDetailController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.albumDetail?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? AlbumDetailCell else { return UITableViewCell() }
        guard let track = presenter.albumDetail?[indexPath.row] else { return UITableViewCell() }
        cell.cellConfigure(with: track)

        return cell
    }

}

