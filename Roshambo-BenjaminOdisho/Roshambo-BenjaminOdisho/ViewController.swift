//
//  ViewController.swift
//  Roshambo-BenjaminOdisho
//
//  Created by Benjamin Odisho on 3/26/17.
//  Copyright © 2017 Benjamin Odisho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var playerChoice = 0
    var npcChoice = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Executes after the Rock button is pressed
    @IBAction func rockButtonPressed(_ sender: AnyObject) {
        playerChoice = 1
        print("\(playerChoice)")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "resultsViewController") as! resultsViewController
        present(vc, animated: true, completion: nil)
    }
    //Executes after the Paper button is pressed
    @IBAction func paperButtonPressed(_ sender: AnyObject) {
        playerChoice = 2
        performSegue(withIdentifier: "doMove", sender: self)
        print("\(playerChoice)")
    }
    //Executes after the Scissors button is pressed
    @IBAction func scissorsButtonPressed(_ sender: AnyObject) {
        playerChoice = 3
        print("\(playerChoice)")
    }

}

