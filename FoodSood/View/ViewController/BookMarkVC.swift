//
//  BookMarkVC.swift
//  FoodSood
//
//  Created by Asha on 27/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import UIKit

class BookMarkVC: UIViewController {

    //MARK: outlets ---------------------------------------------------------

    @IBOutlet weak var tblFood: UITableView!
    @IBOutlet weak var lblNodata: UILabel!

    //MARK: properties ---------------------------------------------------------

    var arrFood : [Food]?

    //MARK: view controller life cycle ---------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        arrFood = fetchFoodData().reversed()
        self.tblFood.reloadData()
        noDataFound()
        
    }
    
    //MARK: Others ---------------------------------------------------------

    @objc func btnBookmarkTapped(_ sender : UIButton){
        
        let hitPoint = sender.convert(CGPoint.zero, to: tblFood)
        let hitIndex: IndexPath? = tblFood.indexPathForRow(at: hitPoint)
        
        if let index = hitIndex{
            if let objFood = arrFood?[index.row]{
                deleteFoodData(objFood)
            }
            arrFood?.remove(at: index.row)
            tblFood.deleteRows(at: [IndexPath(item: index.row, section: 0)], with: .fade)
        }
        noDataFound()

    }
    
    func noDataFound(){
        lblNodata.isHidden = arrFood?.count ?? 0 == 0 ? false : true
    }
}


//MARK: tableView Delegate ---------------------------------------------------------

extension BookMarkVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFood?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTblCell") as! FoodTblCell
        cell.setupData(arrFood?[indexPath.row] ?? Food())
        cell.btnBookMark.tag = indexPath.row
        cell.btnBookMark.addTarget(self, action: #selector(btnBookmarkTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
