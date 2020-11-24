// ----------------------------------------------------------------------------
//
//  AlbumSearchController.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//
// ----------------------------------------------------------------------------

import SnapKit
import UIKit

// ----------------------------------------------------------------------------

class AlbumSearchController: UICollectionViewController {

    // MARK: - UI

    let searchBar = UISearchBar()
    let searchImageView = UIImageView()
    let noResultImageView = UIImageView()

    // MARK: - Properties
    
    var presenter: AlbumSearchPresenterProtocol!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureController()
        configureSearchBar()
        configureNoResultImageView()
        configureBackgroundImageView()
        hideKeyboardWhenTappedAround()
    }

    // MARK: - Configure UI

    private func configureController() {
        self.collectionView!.register(AlbumSearchCell.self, forCellWithReuseIdentifier: Inner.reuseIdentifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.backgroundView = searchImageView
    }
    
    private func configureSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.placeholder = "Search album"
    }
    
    private func configureBackgroundImageView() {
        searchImageView.image = UIImage(named: "search")
        searchImageView.contentMode = .center
    }

    private func configureNoResultImageView() {
        noResultImageView.image = UIImage(named: "noResult")
        noResultImageView.contentMode = .center
        }

    private func configureCell(cell: UICollectionViewCell) {
        cell.backgroundColor = .systemGray5
        cell.layer.cornerRadius = 15
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.albums?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Inner.reuseIdentifier, for: indexPath) as? AlbumSearchCell else { return UICollectionViewCell() }
        configureCell(cell: cell)
        guard let album = presenter.albums?[indexPath.row] else { return UICollectionViewCell() }
        cell.setupCell(with: album)

        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let album = presenter.albums?[indexPath.row] else { return }
        let albumDetailController = ControllersBuilder.createAlbumDetailController(id: album.collectionId,
                                                                                   albumName: album.collectionName,
                                                                                   artistName: album.artistName,
                                                                                   artWork: album.artwork,
                                                                                   musicStyle: album.musicStyle,
                                                                                   trackCount: album.trackCount,
                                                                                   reliseDate: album.releaseDate)
        navigationController?.pushViewController(albumDetailController, animated: true)
    }

    // MARK: - Constants

    private struct Inner {
        static let reuseIdentifier = "albumCell"
    }
}

// ----------------------------------------------------------------------------

extension AlbumSearchController: AlbumSearchControllerProtocol {

    func showNoResultBackground() {
        self.collectionView.backgroundView = noResultImageView
    }
    
    func showBackground() {
        self.collectionView.backgroundView = searchImageView
    }
    
    func hideBackground() {
        self.collectionView.backgroundView = nil
    }
    
    func refreshData() {
        collectionView.reloadData()
    }

    func failure(error: Error) {
        Alerts.presentAlert(view: self.view, viewController: self)
    }
}

// ----------------------------------------------------------------------------

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

// ----------------------------------------------------------------------------

extension AlbumSearchController {
    // Method for hide keybord when tapped around

    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.collectionView.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        self.searchBar.resignFirstResponder()
    }
}
