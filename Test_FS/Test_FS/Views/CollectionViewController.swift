// ----------------------------------------------------------------------------
//
//  CollectionViewController.swift
//
//  @author     Aleksandr Serov <serov-ae@roxiemobile.com>
//  @copyright  Copyright (c) 2020, Roxie Mobile Ltd. All rights reserved.
//  @link       http://www.roxiemobile.com/
//
// ----------------------------------------------------------------------------

import UIKit

// ----------------------------------------------------------------------------

class CollectionViewController: UICollectionViewController {
// MARK: - Construction

    // ...

// MARK: - Properties

    // ...

// MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: Inner.ReuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//    }

// MARK: - Actions

    // ...

// MARK: - Private Methods

    // ...

// MARK: - Inner Types

    // ...

// MARK: - Constants

    private struct Inner {
        static let ReuseIdentifier = "Cell"
    }

// MARK: - Variables

    // ...
}

// ----------------------------------------------------------------------------
// MARK: - @protocol UICollectionViewDataSource
// ----------------------------------------------------------------------------

extension CollectionViewController: UICollectionViewDataSource
{
// MARK: - Methods

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        //#warning Incomplete method implementation -- Return the number of sections
        return 0
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Inner.ReuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell

        // Configure the cell

        return cell
    }

}

// ----------------------------------------------------------------------------
// MARK: - @protocol UICollectionViewDelegate
// ----------------------------------------------------------------------------

extension CollectionViewController: UICollectionViewDelegate
{
// MARK: - Methods

//    // Uncomment this method to specify if the specified item should be highlighted during tracking
//    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }

//    // Uncomment this method to specify if the specified item should be selected
//    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }

//    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }

//    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
//        return false
//    }

//    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
//
//    }

}
