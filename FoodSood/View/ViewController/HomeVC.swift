//
//  HomeVC.swift
//  FoodSood
//
//  Created by Asha on 27/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import UIKit


class HomeVC: UIViewController {
    
    //MARK: outlets ---------------------------------------------------------
    
    @IBOutlet weak var clsCategories: UICollectionView!
    @IBOutlet weak var tblFood: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblNodata: UILabel!
    @IBOutlet weak var clsCategoriesHeight: NSLayoutConstraint!
    
    
    //MARK: properties ---------------------------------------------------------
    
    let layout = UICollectionViewFlowLayout()
    var foodHelper_Parser = FoodHelper_Parser()
    
    //MARK: view controller life cycle ---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout.scrollDirection = .horizontal //this is for direction
        layout.minimumInteritemSpacing = 0 // this is for spacing between cells
        layout.itemSize = CGSize(width: clsCategories.frame.height - 20, height: clsCategories.frame.height) //this is for cell size
        layout.sectionInset.left = 10
        clsCategories.collectionViewLayout = layout
        
        getCategories()
        getFoodList()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.text = ""
        foodHelper_Parser.reloadData()
        self.tblFood.reloadData()
                
    }
    
    //MARK: API calling ---------------------------------------------------------
    
    func getFoodList()
    {
        self.view.endEditing(true)
        self.view.isUserInteractionEnabled = false
        foodHelper_Parser.getFoodList(viewController: self)
    }
    
    func getCategories(){
        
        self.view.endEditing(true)
        self.view.isUserInteractionEnabled = false
        foodHelper_Parser.initWith(helperDelegate: self)
        foodHelper_Parser.getCategoriesList(viewController: self)
    }
    
    //MARK: Others ---------------------------------------------------------
    
    func noDataFound(){
        lblNodata.isHidden = foodHelper_Parser.arrFood?.count ?? 0 == 0 ? false : true
    }
    
    @objc func btnBookmarkTapped(_ sender : UIButton){
        
        let hitPoint = sender.convert(CGPoint.zero, to: tblFood)
        let hitIndex: IndexPath? = tblFood.indexPathForRow(at: hitPoint)
               
        if let index = hitIndex{
            if foodHelper_Parser.arrFood?[index.row].isBookMarked == true{
                    foodHelper_Parser.arrFood?[index.row].isBookMarked = false
                    if let objFood = foodHelper_Parser.arrFood?[index.row]{
                        deleteFoodData(objFood)
                    }
                }
                else{
                    foodHelper_Parser.arrFood?[index.row].isBookMarked = true
                    if let objFood = foodHelper_Parser.arrFood?[index.row]{
                        saveFoodData(objFood)
                    }
                }
                
                if let cell = tblFood.cellForRow(at: IndexPath(row: index.row, section: 0)) as? FoodTblCell{
                    cell.setupData(foodHelper_Parser.arrFood?[index.row] ?? Food())
                }
        }
        
        
    }
}

//MARK: collectionView Delegate ---------------------------------------------------------

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodHelper_Parser.arrCategories?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesClsCell", for: indexPath) as! CategoriesClsCell
        cell.setupData(foodHelper_Parser.arrCategories?[indexPath.item] ?? Categories())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height - 20, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: collectionView Delegate ---------------------------------------------------------

extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodHelper_Parser.arrFood?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTblCell") as! FoodTblCell
        cell.setupData(foodHelper_Parser.arrFood?[indexPath.row] ?? Food())
        cell.btnBookMark.tag = indexPath.row
        cell.btnBookMark.addTarget(self, action: #selector(btnBookmarkTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: Food Helper Parser Delegate ---------------------------------------------------------

extension HomeVC : FoodHelperParserDelegate{
    func Success(arrFood : [Food]) {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.tblFood.reloadData()
            self.noDataFound()
            print("Successfull")
        }
    }
    
    func SuccessCategories(arrCategories: [Categories]) {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.clsCategories.reloadData()
            self.clsCategoriesHeight.constant = self.foodHelper_Parser.arrCategories?.count ?? 0 == 0 ? 0 : 200
            print("Successfull")
        }
    }
    
    func BookMark(food : Food) {
        
    }
    
    func Failed(strerrormessage: String) {
        
        DispatchQueue.main.async {
            
            self.clsCategoriesHeight.constant = self.foodHelper_Parser.arrCategories?.count ?? 0 == 0 ? 0 : 200
            
            self.view.isUserInteractionEnabled = true
            
            print(strerrormessage)
            
            let alertController: UIAlertController = UIAlertController(title: "Alert", message:strerrormessage, preferredStyle: .alert)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    
}


//MARK: searchBar Delegate ---------------------------------------------------------

extension HomeVC : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        foodHelper_Parser.getFoodList(searchText: searchBar.text ?? "", viewController: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        foodHelper_Parser.getFoodList(searchText: searchText, viewController: self)
    }
    
}
