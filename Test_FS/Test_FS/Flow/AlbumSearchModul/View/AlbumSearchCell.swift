// ----------------------------------------------------------------------------

//  AlbumSearchCell.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//
// ----------------------------------------------------------------------------

import Kingfisher
import SnapKit
import UIKit

// ----------------------------------------------------------------------------

class AlbumSearchCell: UICollectionViewCell {

    let albumImageView = UIImageView()
    let albumNameLabel = UILabel()
    let artistNameLabel = UILabel()
    let collectionExplicitness = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupAlbumImage()
        setupAlbumName()
        setupArtistName()
        setupCollectionExplicitnes()
        setupConstreints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public Methods

    func Configure(with model: AlbumSearchModel) {
        let url = URL(string: model.artwork)
        self.albumImageView.kf.setImage(with: url)
        self.albumNameLabel.text = model.collectionName
        self.artistNameLabel.text = model.artistName

        if isExplicit(album: model.collectionExplicitness) {
            collectionExplicitness.isHidden = false
        } else {
            collectionExplicitness.isHidden = true
        }
    }

    //MARK: - Privarte Methods

    private func setupAlbumImage() {
        contentView.addSubview(albumImageView)
        albumImageView.contentMode = .scaleAspectFit
    }

    private func setupAlbumName() {
        contentView.addSubview(albumNameLabel)
        albumNameLabel.font = albumNameLabel.font.withSize(12)
    }

    private func setupArtistName() {
        contentView.addSubview(artistNameLabel)
        artistNameLabel.font = albumNameLabel.font.withSize(12)
    }

    private func setupCollectionExplicitnes() {
        contentView.addSubview(collectionExplicitness)
        collectionExplicitness.contentMode = .scaleAspectFit
        collectionExplicitness.image = UIImage(named: "explicit")
    }

    //Setup constreints with SnapKit
    private func setupConstreints() {
        albumImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.width.equalTo(140)
        }

        albumNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(2)
            make.left.equalTo(albumImageView.snp.left)
            make.right.equalToSuperview().inset(20)
        }

        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumNameLabel.snp.bottom).offset(1)
            make.left.equalTo(albumImageView.snp.left)
            make.right.equalToSuperview().inset(10)
        }
        
        collectionExplicitness.snp.makeConstraints { make in
            make.centerY.equalTo(albumNameLabel.snp.centerY)
            make.left.equalTo(albumNameLabel.snp.right).inset(5)
            make.width.height.equalTo(12)
        }
    }

    //Сhecking if the album is explicit retur true, else retur false.
    private func isExplicit(album: String) -> Bool {
        var isExplicit = false
        if album == "explicit" {
            isExplicit = true
        } else if album == "cleaned" {
            isExplicit = false
        }

        return isExplicit
    }

}
