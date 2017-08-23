//
//  MemeDetailViewController.swift
//  MemeMe v.2
//
//  Created by Benjamin Odisho on 8/22/17.
//  Copyright © 2017 Benjamin Odisho. All rights reserved.
//

import UIKit

class MemeDetailViewController : UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var memes: [Meme]!
    var pickedMeme: Meme!
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(pickedMeme.topText)
//        self.memeLabel.text = self.pickedMeme.topText
        self.imageView.image = self.pickedMeme.memedImage
    }
}
