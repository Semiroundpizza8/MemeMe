//
//  ViewController.swift
//  MYOA-personal
//
//  Created by Benjamin Odisho on 6/20/17.
//  Copyright © 2017 Benjamin Odisho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Start Over",
            style: .plain,
            target: self,
            action: #selector(startOver))
    }

    func startOver() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    

}

