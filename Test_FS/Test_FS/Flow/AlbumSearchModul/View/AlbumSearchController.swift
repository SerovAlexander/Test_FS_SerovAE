//
//  AlbumSearchController.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//

import Alamofire
import SnapKit
import UIKit

private let reuseIdentifier = "Cell"

class AlbumSearchController: UICollectionViewController {

    //MARK: - UI

    let searchBar = UISearchBar()
    let backgroundImageView = UIImageView()
    let noResultLabel = UILabel()
    var presenter: AlbumSearchPresenterProtocol!
    

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupBackgroundImageView()
        setupNoResultLabel()
        configureController()
        configureSearchBar()
    }

    //MARK: - Configure UI

    private func configureController() {
        self.collectionView!.register(AlbumSearchCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.backgroundView = backgroundImageView
    }
    
    private func configureSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.placeholder = "Search album"
    }
    
    private func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "search")
        backgroundImageView.contentMode = .center
    }
    private func setupNoResultLabel() {
        backgroundImageView.addSubview(noResultLabel)
        noResultLabel.text = "No result"
        noResultLabel.textColor = .systemGray2
        noResultLabel.font = UIFont.systemFont(ofSize: 25)
        noResultLabel.isHidden = true
        
        noResultLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundImageView.snp.centerX)
            make.bottom.equalToSuperview().inset(200)
        }
        
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.albums?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AlbumSearchCell else { return UICollectionViewCell() }
        guard let album = presenter.albums?[indexPath.row] else { return UICollectionViewCell() }
        cell.Configure(with: album)
        cell.backgroundColor = .systemGray5
        cell.layer.cornerRadius = 15

        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = presenter.albums?[indexPath.row].collectionId ?? 0
        let albumDetailController = ControllersBuilder.createAlbumDetailController(id: id)
        navigationController?.pushViewController(albumDetailController, animated: true)
    }
    
}

extension AlbumSearchController: AlbumSearchControllerProtocol {
    func showNoResultBackground() {
        self.backgroundImageView.isHidden = false
        self.noResultLabel.isHidden = false
    }
    
    func showBackground() {
        self.backgroundImageView.isHidden = false
        self.noResultLabel.isHidden = true
    }
    
    func hideBackground() {
        self.backgroundImageView.isHidden = true
    }
    
    func refreshData() {
        collectionView.reloadData()
    }

    func failure(error: Error) {
        Alerts.presentAlert(view: self.view, viewController: self)
    }
}
    //MARK: - SearchBar Delegate

extension AlbumSearchController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()

            return
        }
        searchBar.resignFirstResponder()
        presenter.searchAlbum(with: query)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchAlbum(with: searchText)
    }
}

extension AlbumSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2.2), height: 200)
    }
}

//
extension AlbumSearchController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.collectionView.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        self.searchBar.resignFirstResponder()
    }
}
