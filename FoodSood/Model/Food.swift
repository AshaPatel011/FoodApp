//
//  Food.swift
//  FoodSood
//
//  Created by Asha on 27/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import Foundation

struct Food : Codable{
    
    var idMeal : String?
    var strMeal : String?
    var strCategory : String?
    var strArea : String?
    var strInstructions : String?
    var strMealThumb : String?
    var strTags : String?
    var strYoutube : String?
    var isBookMarked : Bool? = false
    
}
