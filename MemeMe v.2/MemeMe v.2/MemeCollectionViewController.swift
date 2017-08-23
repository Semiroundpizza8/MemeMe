//
//  MemeCollectionViewController.swift
//  MemeMe v.2
//
//  Created by Benjamin Odisho on 6/29/17.
//  Copyright © 2017 Benjamin Odisho. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //------------------------------------------------------------------
    //     Variables
    //------------------------------------------------------------------
    
    var memes: [Meme]!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    //------------------------------------------------------------------
    //     Setup
    //------------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        var picturesPerRow : CGFloat!
        
        // If in landscape, set x pictures per row
        if UIDevice.current.orientation.isLandscape {
            picturesPerRow = 4
        } else {
            picturesPerRow = 3
        }
        
        // Set-up grid layout
        let space:CGFloat = 3.0
        // Dimensions of pictures are size of the frame divided by the pictures needed per row, less the space between rows
        let dimension = (view.frame.size.width / picturesPerRow) - space
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = (view.frame.size.width - (picturesPerRow * dimension)) / (picturesPerRow - 1)
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        collectionView.reloadData()
    }
    
    //------------------------------------------------------------------
    //     collectionView Functions
    //------------------------------------------------------------------
    
    // Count number of items needed
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    // Fill in each item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.memeImage?.image = meme.memedImage
        
        return cell
    }
    
    // Push to detail view controller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.pickedMeme = memes[indexPath.row]
        navigationController!.pushViewController(detailController, animated: true)
    }
}
