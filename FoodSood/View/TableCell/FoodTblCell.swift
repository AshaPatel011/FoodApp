//
//  FoodTblCell.swift
//  FoodSood
//
//  Created by Asha on 27/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import UIKit

class FoodTblCell: UITableViewCell {
    
    //MARK: outlets ---------------------------------------------------------

    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var imgFood : UIImageView!
    @IBOutlet weak var viewOverlay : UIView!
    @IBOutlet weak var lblCatgeories : UILabel!
    @IBOutlet weak var lblTags : UILabel!
    @IBOutlet weak var btnBookMark : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgFood.setCorner()
        viewOverlay.setCorner()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: others ---------------------------------------------------------

    func setupData(_ food : Food){
        lblTitle.text = food.strMeal
        lblCatgeories.text = food.strCategory
        lblTags.text = food.strTags
        imgFood.imageFromUrl(urlString: food.strMealThumb ?? "")
        btnBookMark.tintColor = food.isBookMarked ?? false ? UIColor.systemYellow : UIColor.gray

    }
    

}
