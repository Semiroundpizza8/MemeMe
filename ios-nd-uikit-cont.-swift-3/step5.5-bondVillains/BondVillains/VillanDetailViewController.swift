//
//  VillanDetailViewController.swift
//  BondVillains
//
//  Created by Benjamin Odisho on 6/21/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class VillainDetailViewController: UIViewController {

    
    var villain: Villain!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.label.text = self.villain.name
        self.imageView!.image = UIImage(named: villain.imageName)
    }
    
}
