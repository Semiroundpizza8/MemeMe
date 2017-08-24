//
//  MemeEditorViewController.swift
//  MemeMe v.1
//
//  Created by Benjamin Odisho on 6/14/17.
//  Copyright © 2017 Benjamin Odisho. All rights reserved.
//

import UIKit

class MemeEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

//------------------------------------------------------------------
//     IBOutlet Variables
//------------------------------------------------------------------

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet var cameraButton: UIBarButtonItem!
    @IBOutlet var topText: UITextField!
    @IBOutlet var bottomText: UITextField!
    @IBOutlet var shareButton: UIBarButtonItem!
    @IBOutlet var topToolbar: UIToolbar!
    @IBOutlet var bottomToolbar: UIToolbar!
    
    let memeTextAttributes:[String:Any] = [             // Prepares the Text
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -5,]
    
//------------------------------------------------------------------
//     Load Functions
//------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Prepare topText
        configureText(topText, defaultText: "TOP")
        
        // Prepare bottomText
        configureText(bottomText, defaultText: "BOTTOM")
        
        // Disable shareButton
        shareButton.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check whether or not there is a Camera, and enable cameraButton if there is
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }

    
    
//------------------------------------------------------------------
//     Image View Functions
//------------------------------------------------------------------
    
    // Code for Album button
    @IBAction func pickAnImage(_ sender:Any) {
        pickAnImageFrom(.photoLibrary)
    }
    
    // Code for Camera button
    @IBAction func pickAnImageCamera(_ sender: AnyObject) {
        pickAnImageFrom(.camera)
    }
    
    func pickAnImageFrom(_ source: UIImagePickerControllerSourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }
    
    // Presents the selected image
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            self.view.backgroundColor = UIColor.black
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    // If no image was chosen/ the Cancel button was pressed
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
            dismiss(animated: true, completion: nil)
    }
    
//------------------------------------------------------------------
//     Text Field Functions
//------------------------------------------------------------------
    
    // Clear topText when user selects it
    @IBAction private func topTextDidBeginEditing(_ sender: AnyObject) {
        topText.text = ""
    }
    
    // Clear bottomText when user selects it
    @IBAction private func bottomTextDidBeginEditing(_ sender: AnyObject) {
        bottomText.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func configureText(_ textField: UITextField, defaultText: String) {
        // Code to configure the textField
        textField.delegate = self
        textField.text = defaultText
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
    }
    
//------------------------------------------------------------------
//     Keyboard Functions
//------------------------------------------------------------------
    
    // Adjust screen when using bottomText
    func keyboardWillShow(_ notification:Notification) {
        if bottomText.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    // Puts screen back into initial position
    func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    // Reads the height of the keyboard
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // Prepares notifications
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    // Undoes notifications
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
//------------------------------------------------------------------
//     Creating and Saving Meme
//------------------------------------------------------------------
    
    // Save the shared Meme
    func save(memedImage: UIImage) {
        // Create the meme
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }

    
    // Observes screen and generates Memed Image
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        hideBars(shouldBarHide: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar again
        hideBars(shouldBarHide: false)
        return memedImage
    }
    
    func hideBars(shouldBarHide: Bool) {
        self.navigationController?.setNavigationBarHidden(shouldBarHide, animated: true)
        topToolbar.isHidden = shouldBarHide
        bottomToolbar.isHidden = shouldBarHide
    }
    
//------------------------------------------------------------------
//     Share, Return, and Reset Buttons
//------------------------------------------------------------------
    
    // Show sharing interface when the Share button is clicked
    @IBAction func shareButtonClicked(_ sender: AnyObject) {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil);
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save(memedImage: memedImage)
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    // Reset the screen when the Cancel button is clicked **CHANGED TO RETURN**
    @IBAction func cancelButtonClicked(_ sender: AnyObject) {
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        imagePickerView.image = nil
        self.view.backgroundColor = UIColor.white
        shareButton.isEnabled = false
    }
    
    @IBAction func dismissScreen(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

