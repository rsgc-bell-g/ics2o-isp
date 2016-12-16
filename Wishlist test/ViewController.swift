//  ViewController.swift
//  Wishlist test
//  Created by Gavin Bell on 2016-11-16.
//  Copyright © 2016 Gavin Bell. All rights reserved.

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // Mark: Properties
    
    @IBOutlet weak var siteTextFieldWish: UITextField!
    @IBOutlet weak var priceTextFieldWish: UITextField!
    @IBOutlet weak var photoImageViewWish: UIImageView!
    @IBOutlet weak var nameTextFieldWish: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field's user input through delegate callbacks
        nameTextFieldWish.delegate = self
        priceTextFieldWish.delegate = self
        siteTextFieldWish.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    
    // Mark: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    
    // Mark: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        // Dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [ String : Any]) {
        
        // The info dictionary contains multiple representations of the image, and this ensures the original image is used
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView object to siplay the selected image
        photoImageViewWish.image = selectedImage
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    
    // Mark: Actions
    @IBAction func selectImageFromPhotoLibraryWish(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard
        nameTextFieldWish.resignFirstResponder()
        priceTextFieldWish.resignFirstResponder()
        siteTextFieldWish.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from thier photo library
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked not taken
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
}

