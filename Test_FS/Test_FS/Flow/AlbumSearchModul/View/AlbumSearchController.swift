//
//  AlbumSearchController.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

class AlbumSearchController: UICollectionViewController {

    //MARK: - UI

    let searchBar = UISearchBar()
    var presenter: AlbumSearchPresenterProtocol!

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        ConfigureSearchBar()
    }

    //MARK: - Configure UI

    private func configureController() {
        self.collectionView!.register(AlbumSearchCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .systemBackground

    }
    
    private func ConfigureSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.placeholder = "Search album"
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
        let albumDetailController = Builder.createAlbumDetailController(id: id)
        navigationController?.pushViewController(albumDetailController, animated: true)
    }
}

extension AlbumSearchController: AlbumSearchControllerProtocol {
    func succes() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error)
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

}

extension AlbumSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2.2), height: 200)
    }
}
