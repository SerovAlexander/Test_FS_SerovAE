//
//  AlbumListCVC.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

class AlbumListCVC: UICollectionViewController {

    //MARK: - UI

    let searchBar = UISearchBar()
    var iTunesSearch = ITunesSearchService()
    var albums: [ITunesAlbumModel] = []

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        // Register cell classes
        self.collectionView!.register(AlbumListCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    //MARK: - Private Methods

    private func requsetAlbum(with query: String) {
        iTunesSearch.getAlbums(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(albums):
                self.albums = albums
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AlbumListCell else { return UICollectionViewCell() }

        let album = albums[indexPath.row]
        cell.Configure(with: album)

        return cell
    }
    
    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AlbumDetailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
    //MARK: - SearchBar Delegate

extension AlbumListCVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()

            return
        }
        searchBar.resignFirstResponder()
        self.requsetAlbum(with: query)
    }

}
