//
//  CategoriesClsCell.swift
//  FoodSood
//
//  Created by Asha on 27/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import UIKit

class CategoriesClsCell: UICollectionViewCell {
    
    //MARK: outlets ---------------------------------------------------------

    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var imgCat : UIImageView!
    @IBOutlet weak var bgView : UIView!
    @IBOutlet weak var colorView : UIView!

    override func awakeFromNib() {
        bgView.addShadow(offset: CGSize.zero, color: UIColor.black, radius: 10, opacity: 0.1)
    }
    
    //MARK: others ---------------------------------------------------------

    func setupData(_ catgeory : Categories){
        lblTitle.text = catgeory.strCategory
        imgCat.imageFromUrl(urlString: catgeory.strCategoryThumb ?? "")

    }
    
}

