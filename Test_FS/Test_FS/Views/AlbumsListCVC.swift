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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Inner.reuseIdentifier)

//        iTunesSearch.getAlbums(forQuery: "Jay-z") { result in
//            switch result {
//            case let .success(json):
//                print(json ?? [:])
//            case let .failure(error):
//                print(error)
//            }
//        }
    }

// ----------------------------------------------------------------------------
// MARK: - @protocol UICollectionViewDataSource
// ----------------------------------------------------------------------------
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Inner.reuseIdentifier, for: indexPath)


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
