//
//  MemeCollectionViewController.swift
//  MemeMe v.2
//
//  Created by Benjamin Odisho on 6/29/17.
//  Copyright © 2017 Benjamin Odisho. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var memes: [Meme]!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        super.viewDidLoad()
        
        // Set-up grid layout
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
            
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    //------------------------------------------------------------------
    //     collectionView Functions
    //------------------------------------------------------------------
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
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
