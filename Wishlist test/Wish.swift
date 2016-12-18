//
//  Wish.swift
//  Wishlist test
//
//  Created by Gavin Bell on 2016-12-16.
//  Copyright © 2016 Gavin Bell. All rights reserved.
//

import UIKit
class Wish {
    
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var link: String
    var price: String
}


//MARK: Initialization

init?(name: String, photo: UIImage?, link: String, price: String) {
    
    // Initialization should fail if there is no name or if the rating is negative.
    if name.isEmpty || price.isEmpty || link.isEmpty {
        return nil
    }
    
    // Initialize stored properties.
    self.name = name
    self.photo = photo
    self.link = link
    self.price = price
    
}
