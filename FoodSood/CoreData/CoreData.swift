//
//  CoreData.swift
//  FoodSood
//
//  Created by Asha on 27/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import Foundation
import CoreData
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

func saveFoodData(_ food: Food) {
    
    let context = appDelegate.persistentContainer.viewContext
    let newFood = NSEntityDescription.insertNewObject(forEntityName: "Foods", into: context)
    newFood.setValue(food.idMeal, forKey: "idMeal")
    newFood.setValue(food.strMeal, forKey: "strMeal")
    newFood.setValue(food.strCategory, forKey: "strCategory")
    newFood.setValue(food.strArea, forKey: "strArea")
    newFood.setValue(food.strInstructions, forKey: "strInstructions")
    newFood.setValue(food.strMealThumb, forKey: "strMealThumb")
    newFood.setValue(food.strTags, forKey: "strTags")
    newFood.setValue(food.strYoutube, forKey: "strYoutube")
    newFood.setValue(food.isBookMarked, forKey: "isBookMarked")
    do {
        try context.save()
        print("Success")
    } catch {
        print("Error saving: \(error)")
    }
    
}

func deleteFoodData(_ food : Food) {
    
    let context = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Foods")
    
    let predicate = NSPredicate(format: "idMeal = %@", food.idMeal ?? "")
    
    fetchRequest.predicate = predicate
    
    if let result = try? context.fetch(fetchRequest) {
            for object in result {
                if let obj = object as? NSManagedObject{
                    context.delete(obj)
                }
            }
        }
    
    do {
        try context.save() // <- remember to put this :)
    } catch {
        // Do something... fatalerror
    }
}

func fetchFoodData() -> [Food] {
    
    let context = appDelegate.persistentContainer.viewContext
    var foods = [Food]()
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Foods")
    fetchRequest.returnsObjectsAsFaults = false

    
    do {
        let results   = try context.fetch(fetchRequest)
        
        if !results.isEmpty {
                   for result in results as! [NSManagedObject] {
                    var dict = Food()
                    dict.idMeal = result.value(forKey: "idMeal") as? String ?? ""
                    dict.strMeal = result.value(forKey: "strMeal") as? String ?? ""
                    dict.strCategory = result.value(forKey: "strCategory") as? String ?? ""
                    dict.strArea = result.value(forKey: "strArea") as? String ?? ""
                    dict.strInstructions = result.value(forKey: "strInstructions") as? String ?? ""
                    dict.strMealThumb = result.value(forKey: "strMealThumb") as? String ?? ""
                    dict.strTags = result.value(forKey: "strTags") as? String ?? ""
                    dict.strYoutube = result.value(forKey: "strYoutube") as? String ?? ""
                    dict.isBookMarked = result.value(forKey: "isBookMarked") as? Bool ?? false
                    foods.append(dict)
            }
        }
        
        return foods
    } catch let error as NSError {
        print("Could not fetch \(error)")
    }
    
    return foods
}
