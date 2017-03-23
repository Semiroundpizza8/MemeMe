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
    var label:UILabel! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // label
        let label = UILabel()
        label.frame = CGRect.init(x: 150, y: 150, width: 60, height: 60)
        label.text = "0"
        
        self.view.addSubview(label)
        self.label = label
        
        //Increment button
        let button = UIButton()
        
        button.frame = CGRect.init(x: 150, y: 250, width: 60, height: 60)
        button.setTitle("Click", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        self.view.addSubview(button)
        button.addTarget(self, action: "incrementCount", for: UIControlEvents.touchUpInside)
        
        //Deincrement Button
        let otherButton = UIButton()
        
        otherButton.frame = CGRect.init(x: 150, y: 200, width: 60, height: 60)
        otherButton.setTitle("Decrease", for: .normal)
        otherButton.setTitleColor(UIColor.red, for: .normal)
        self.view.addSubview(otherButton)
        otherButton.addTarget(self, action: "deincrementCount", for: UIControlEvents.touchUpInside)
        
    }

    func incrementCount(){
        self.count = count + 1
        self.label.text = "\(self.count)"
    }
    func deincrementCount(){
        self.count = count - 1
        self.label.text = "\(self.count)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

