//
//  AlbumDetailCell.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 21.11.2020.
//

import SnapKit
import UIKit

class AlbumDetailCell: UITableViewCell {

    //MARK: - UI

    private let trackNameLabel = UILabel()
    private let trackNumberLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTrackNumberLabel()
        setupTrackNameLabel()
        setupConstreints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public Method

    func cellConfigure(with album: AlbumModel) {
        trackNumberLabel.text = String(album.trackNumber ?? 1)
        trackNameLabel.text = album.trackName ?? ""
    }

    //MARK: - Configure UI

    private func setupTrackNumberLabel() {
        contentView.addSubview(trackNumberLabel)
    }

    private func setupTrackNameLabel() {
        contentView.addSubview(trackNameLabel)
    }

    // Setup constraint with SnapKit
    private func setupConstreints() {
        trackNumberLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(25)
        }

        trackNameLabel.snp.makeConstraints { make in
            make.left.equalTo(trackNumberLabel.snp.right).inset(2)
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalToSuperview().inset(30)
        }
    }

}
