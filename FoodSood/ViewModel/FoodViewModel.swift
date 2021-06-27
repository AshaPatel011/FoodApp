//
//  FoodViewModel.swift
//  FoodSood
//
//  Created by Asha on 27/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import Foundation
import Alamofire

//MARK: delegate ---------------------------------------------------------

protocol FoodHelperParserDelegate: class {
    
    func Success(arrFood: [Food])
    func SuccessCategories(arrCategories: [Categories])
    func Failed(strerrormessage: String)
    
}

class FoodHelper_Parser: NSObject {
    
    //MARK: properties ---------------------------------------------------------
    
    weak var delegate: FoodHelperParserDelegate?
    var arrFood : [Food]?
    var arrSearchFood : [Food]?
    var arrCategories : [Categories]?

    //MARK: others ---------------------------------------------------------
    
    func initWith(helperDelegate: FoodHelperParserDelegate) {
        delegate = helperDelegate
    }
    
    func reloadData(){
        
        for (index, _) in (self.arrFood ?? [Food]()).enumerated() {
            self.arrFood?[index].isBookMarked = false
        }
        
        let arrFoodOffline = fetchFoodData()
        if arrFoodOffline.count > 0{
            arrFoodOffline.forEach { (Food) in
                if let index = self.arrFood?.firstIndex(where: {$0.idMeal == Food.idMeal}){
                    self.arrFood?[index].isBookMarked = true
                }
            }
        }
    }
    
    func getFoodList(searchText : String = "",viewController: UIViewController) {
       
        AppManager.sharedIntance.PostMethodAPi(request: searchText == "" ? BaseURL + searchRandomURL + randomString(length: 1) : BaseURL + searchTextURL + searchText, httpMethod: .get, params: [:], fromVC:viewController , apiSuccess: { (response) in
            
            if response["success"] as? Bool ?? true == false{
                self.delegate?.Failed(strerrormessage: response["status_message"] as? String ?? strErrorMessage)
                return
            }
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response["meals"] as? [AnyObject] ?? [AnyObject](), options: .prettyPrinted)
                    print(jsonData)
                    let jsonDecoder = JSONDecoder()
                    self.arrFood = try jsonDecoder.decode([Food].self, from: jsonData)
                    // api success
                    
                    self.reloadData()
                    
                    self.delegate?.Success(arrFood: self.arrFood ?? [Food]())
                    
                }catch let error{
                    print(error)
                }

        }) { (error) in
            DispatchQueue.main.async() {
                // api fail error
                self.delegate?.Failed(strerrormessage: strErrorMessage)
            }
            return
        }
    }
    
    func getCategoriesList(viewController: UIViewController) {
       
        AppManager.sharedIntance.PostMethodAPi(request: BaseURL + categoriesURL, httpMethod: .get, params: [:], fromVC:viewController , apiSuccess: { (response) in
            
            if response["success"] as? Bool ?? true == false{
                self.delegate?.Failed(strerrormessage: response["status_message"] as? String ?? strErrorMessage)
                return
            }

                do{
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: response["categories"] as! [AnyObject], options: .prettyPrinted)
                    print(jsonData)
                    let jsonDecoder = JSONDecoder()
                    self.arrCategories = try jsonDecoder.decode([Categories].self, from: jsonData)
                    // api success
                    self.delegate?.SuccessCategories(arrCategories: self.arrCategories ?? [Categories]())
                    
                }catch let error{
                    print(error)
                }

        }) { (error) in
            DispatchQueue.main.async() {
                // api fail error
                self.delegate?.Failed(strerrormessage: strErrorMessage)
            }
            return
        }
    }
    
    
}
