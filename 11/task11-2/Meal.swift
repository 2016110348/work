//
//  task11_2Tests.swift
//  task11-2Tests
//
//  Created by student on 2018/12/11.
//  Copyright © 2018年 yupeng. All rights reserved.
//

import UIKit
  //MARK: Properties
class Meal {
    var name: String
    var photo: UIImage?
    var rating: Int
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0  {
            return nil
        }
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
