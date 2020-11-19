// ----------------------------------------------------------------------------

//  AlbumListCell.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//
// ----------------------------------------------------------------------------

import Kingfisher
import SnapKit
import UIKit

// ----------------------------------------------------------------------------

class AlbumListCell: UICollectionViewCell {

    let albumImageView = UIImageView()
    let almbumNameLabel = UILabel()
    let artistNameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAlbumImage() {
        contentView.addSubview(albumImageView)
        albumImageView.contentMode = .scaleAspectFit

        albumImageView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }

    }

    func Configure(with model: ITunesAlbumModel) {
        let url = URL(string: model.artwork)
        self.albumImageView.kf.setImage(with: url)

    }

}
