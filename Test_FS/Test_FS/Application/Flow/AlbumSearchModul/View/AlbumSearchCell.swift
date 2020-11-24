// ----------------------------------------------------------------------------
//
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

    // MARK: - UI

    let albumImageView = UIImageView()
    let albumNameLabel = UILabel()
    let artistNameLabel = UILabel()
    let explicitImageView = UIImageView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureAlbumImage()
        configureAlbumName()
        configureArtistName()
        configureCollectionExplicitnes()
        setupConstreints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public Methods

    func setupCell(with model: AlbumSearchModel) {
        let url = URL(string: model.artwork)
        self.albumImageView.kf.setImage(with: url)
        self.albumNameLabel.text = model.collectionName
        self.artistNameLabel.text = model.artistName

        if isExplicit(album: model.collectionExplicitness) {
            explicitImageView.isHidden = false
        } else {
            explicitImageView.isHidden = true
        }
    }

    //MARK: - Configure UI

    private func configureAlbumImage() {
        contentView.addSubview(albumImageView)
        albumImageView.contentMode = .scaleAspectFit
    }

    private func configureAlbumName() {
        contentView.addSubview(albumNameLabel)
        albumNameLabel.font = albumNameLabel.font.withSize(Inner.fontSize)
    }

    private func configureArtistName() {
        contentView.addSubview(artistNameLabel)
        artistNameLabel.font = albumNameLabel.font.withSize(Inner.fontSize)
    }

    private func configureCollectionExplicitnes() {
        contentView.addSubview(explicitImageView)
        explicitImageView.contentMode = .scaleAspectFit
        explicitImageView.image = UIImage(named: "explicit")
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

        explicitImageView.snp.makeConstraints { make in
            make.centerY.equalTo(albumNameLabel.snp.centerY)
            make.left.equalTo(albumNameLabel.snp.right).inset(5)
            make.width.height.equalTo(12)
        }
    }

    // MARK: - Private Methods

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

    // MARK: - Constants

    private struct Inner {
        static let fontSize: CGFloat = 12
    }

}
