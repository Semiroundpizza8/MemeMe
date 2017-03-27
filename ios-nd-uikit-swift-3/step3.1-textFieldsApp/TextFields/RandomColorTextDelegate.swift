//
//  RandomColorTextDelegate.swift
//  TextFields
//
//  Created by Benjamin Odisho on 3/26/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class RandomColorTextDelegate: NSObject, UITextFieldDelegate {
    
    let colors:[UIColor] = [.red, .orange, .yellow, .green, .blue, .purple, .brown]
    func randomColor() -> UIColor {
        let randomIndex = Int(arc4random() % UInt32(colors.count))
        return colors[randomIndex]
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        textField.textColor = randomColor()
        return true
        
    }
    
}
