//
//  Global.swift
//  FoodSood
//
//  Created by Asha on 27/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import Foundation

func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyz"
  return String((0..<length).map{ _ in letters.randomElement()! })
}
