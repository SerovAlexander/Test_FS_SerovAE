// ----------------------------------------------------------------------------

//  AlbumsListCVC.swift
//  Test_FS
//
//  Created by Серов Александр Евгеньевич on 19.11.2020.
//
// ----------------------------------------------------------------------------

import UIKit

// ----------------------------------------------------------------------------

class AlbumsListCVC: UICollectionViewController {

    var iTunesSearch = ITunesSearchService()
    var albums: [ITunesAlbumModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Inner.reuseIdentifier)

        iTunesSearch.getAlbums(forQuery: "Jay Z") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(albums):
                self.albums = albums
                print(albums)
            case let .failure(error):
                print(error)
            }
        }
    }

// ----------------------------------------------------------------------------
// MARK: - @protocol UICollectionViewDataSource
// ----------------------------------------------------------------------------
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Inner.reuseIdentifier, for: indexPath) as? AlbumListCell else { return UICollectionViewCell() }
        let album = albums[indexPath.row]
        cell.Configure(with: album)
        return cell
    }

// ----------------------------------------------------------------------------
// MARK: - @protocol UICollectionViewDelegate
// ----------------------------------------------------------------------------

    // MARK: - Constants

    private struct Inner {
        static let reuseIdentifier = "Cell"
    }


}

extension UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.height/2)
    }
}
