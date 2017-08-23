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
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {            return self.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath)
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.nameLabel.text = memes.topText
        cell.villainImageView?.image = UIImage(named: villain.imageName)
        
        return cell
    }
}
