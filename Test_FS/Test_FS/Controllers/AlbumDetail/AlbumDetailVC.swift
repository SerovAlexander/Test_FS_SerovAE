//
//  AlbumDetailVC.swift
//  Test_FS
//
//  Created by Aleksandr Serov on 21.11.2020.
//

import SnapKit
import UIKit

class AlbumDetailVC: UIViewController {

    //MARK: - UI
    private let albumImageView = UIImageView()
    private let tableView = UITableView()

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlbumImageView()
        setupConstreints()

    }

    //MARK: - Configure UI

    private func setupAlbumImageView() {
        self.view.addSubview(albumImageView)
        albumImageView.contentMode = .scaleAspectFit
    }

    private func setupConstreints() {
        albumImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().inset(10)
            make.height.width.equalTo(100)
        }
    }

}
