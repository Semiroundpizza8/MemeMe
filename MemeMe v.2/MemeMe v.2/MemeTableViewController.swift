//
//  MemeTableViewController.swift
//  MemeMe v.2
//
//  Created by Benjamin Odisho on 6/29/17.
//  Copyright © 2017 Benjamin Odisho. All rights reserved.
//

import UIKit

class MemeTableViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    var memes: [Meme]!
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    // MARK: Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.textLabel?.text = meme.topText
        cell.imageView?.image = meme.memedImage
        cell.detailTextLabel?.text = meme.bottomText
        
        return cell
    }
    

}
