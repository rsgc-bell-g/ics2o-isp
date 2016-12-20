//
//  Wish.swift
//  SavingDataExample
//
//  Created by Gavin Bell on 12/16/16.
//  Copyright © 2016 Gavin Bell. All rights reserved.
//

import UIKit

class Wish : NSObject, NSCoding {
    
    // MARK: Properties
    var name : String
    var price : String
    var link : String
    var photo : UIImage?
    
    // MARK: Paths for archiving data across sessions
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    static let ArchiveURL = DocumentsDirectory[0].appendingPathComponent("Wish")
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let priceKey = "price"
        static let linkKey = "link"
        static let photoKey = "photo"
    }
    
    init(name : String, price : String, link: String, photo: UIImage?) {
        
        // Initialize stored properties
        self.name = name
        self.price = price
        self.link = link
        if let photo = photo {
            self.photo = photo
        }
    }
    
    // MARK: NSCoding required functions
    
    // This allows the Meal class to save values
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(price, forKey: PropertyKey.priceKey)
        aCoder.encode(link, forKey: PropertyKey.linkKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
    }
    
    // This allows the Meal class to load values from the file
    required convenience init?(coder aDecoder : NSCoder) {
        
        // Load the name
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        
        // Load the price
        let price = aDecoder.decodeObject(forKey: PropertyKey.priceKey) as! String
       
        // Load the link
        let link = aDecoder.decodeObject(forKey: PropertyKey.linkKey) as! String
        
        // Load the photo
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as! UIImage?
        
        
        // Now call the designated (main) initializer for this class
        self.init(name: name, price: price, link: link, photo: photo)
        
    }
    
}
