//
//  ViewController.swift
//  PickingImage
//
//  Created by Mgdolen Zabad on 9/10/17.
//  Copyright © 2017 Udacity1stproject. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var camera: UIBarButtonItem!
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField(textField: topTextField, textAttributes: textAttributes, textAlignment: .center, text: "Top")
        configureTextField(textField: bottomTextField, textAttributes: textAttributes, textAlignment: .center, text: "Bottom")
        
        shareButton.isEnabled = false
    
            
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        camera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        imagepicker(fromAlbum: true)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        imagepicker(fromAlbum: false)
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
        let ac = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        ac.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.shareButton(self)
                self.save()
            }
        }
        present(ac, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func canceled(_ sender: Any) {
        pickedImage.image = nil
        topTextField.text = nil
        bottomTextField.text = nil
        
        dismiss(animated: true, completion: nil)
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        shareButton.isEnabled = false
        
        
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification as Notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    let textAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -4.0,
        
        ]
    
    
    func generateMemedImage() -> UIImage {
        
        toolBar.isHidden = true
        navBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolBar.isHidden = false
        navBar.isHidden = false
        
        
        return memedImage
    }

    func save(){
        
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: pickedImage.image!, memedImage: generateMemedImage() )
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
}

extension MemeEditorViewController: UIImagePickerControllerDelegate {
    
    func imagepicker(fromAlbum:Bool){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if fromAlbum {
            imagePicker.sourceType = .photoLibrary
            
        }
        else {
            imagePicker.sourceType = .camera
        }
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        shareButton.isEnabled = true
        let selectedImage = info [UIImagePickerControllerOriginalImage] as! UIImage
        pickedImage.image = selectedImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension MemeEditorViewController : UITextFieldDelegate {
    
    func configureTextField(textField: UITextField, textAttributes: [String:Any] ,textAlignment: NSTextAlignment, text : String) {
        
        textField.delegate = self
        textField.text = text
        textField.defaultTextAttributes = textAttributes
        textField.textAlignment = textAlignment
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("TextField should return method called")
        return true
    }
    
}












