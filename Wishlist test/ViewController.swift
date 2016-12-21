//  ViewController.swift
//  Wishlist test
//  Created by Gavin Bell on 2016-11-16.
//  Copyright © 2016 Gavin Bell. All rights reserved.

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // MARK: Properties
    
    @IBOutlet weak var linkTextFieldWish: UITextField!
    @IBOutlet weak var priceTextFieldWish: UITextField!
    @IBOutlet weak var photoImageViewWish: UIImageView!
    @IBOutlet weak var nameTextFieldWish: UITextField!
    
    var wish = Wish(name: "", price: "", link: "", photo: #imageLiteral(resourceName: "default photo"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field's user input through delegate callbacks
        nameTextFieldWish.delegate = self
        priceTextFieldWish.delegate = self
        linkTextFieldWish.delegate = self
        
        // Try to load the wish from disk
        if let savedWish = loadWish() {
            linkTextFieldWish.text = savedWish.link
            priceTextFieldWish.text = savedWish.price
            nameTextFieldWish.text = savedWish.name
            photoImageViewWish.image = savedWish.photo
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        // Iterate over all subviews of the main interface
        // For any that are text fields, make it so that when editing ends, the class list is saved
        // This works by invoking the saveClassList function
        nameTextFieldWish.addTarget(self, action: #selector(self.saveWish), for: .editingChanged)
        priceTextFieldWish.addTarget(self, action: #selector(self.saveWish), for: .editingChanged)
        linkTextFieldWish.addTarget(self, action: #selector(self.saveWish), for: .editingChanged)
        
    }
    
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let link = "link"
        static let price = "price"
    }
    
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: UIImagePickerControllerDelegate
    
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
        
        // Call save image
        saveWish()
    }
    
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibraryWish(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard
        nameTextFieldWish.resignFirstResponder()
        priceTextFieldWish.resignFirstResponder()
        linkTextFieldWish.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from thier photo library
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked not taken
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: NSCoder
    
    // Try to load wish
    func loadWish() -> Wish? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Wish.ArchiveURL.path) as? Wish
    }
    
    // Save Wish
    func saveWish() {
        if let link = linkTextFieldWish.text {
            wish.link = link
        }
        if let price = priceTextFieldWish.text {
            wish.price = price
        }
        if let name = nameTextFieldWish.text {
            wish.name = name
        }
        if let photo = photoImageViewWish.image {
            wish.photo = photo
        }
        
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(wish, toFile: Wish.ArchiveURL.path)
        
        // Log an error if this didn't work
        if isSuccessfulSave == false {
            print("Failed to save wish...")
        }
    }
    
    
}

