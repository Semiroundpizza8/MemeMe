//
//  ViewController.swift
//  ClickCounter
//
//  Created by Benjamin Odisho on 3/23/17.
//  Copyright © 2017 Benjamin Odisho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count = 0
    @IBOutlet var label:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func incrementCount(){
        self.count = count + 1
        self.label.text = "\(self.count)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

