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

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupAlbumImage()
        setupAlbumName()
        setupArtistName()
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

    //Setup constreints with SnapKit
    private func setupConstreints() {
        albumImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.width.equalTo(120)
        }

        albumNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(2)
            make.left.equalTo(13)
            make.right.equalTo(2)
        }

        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumNameLabel.snp.bottom).offset(1)
            make.left.equalTo(13)
            make.right.equalTo(2)
        }
    }

}
