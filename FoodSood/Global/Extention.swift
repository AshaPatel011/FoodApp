//
//  Extention.swift
//  FoodSood
//
//  Created by Asha on 27/06/21.
//  Copyright © 2021 Deny. All rights reserved.
//

import Foundation
import UIKit

//MARK: UIImageView ---------------------------------------------------------

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url as URL)
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {
                (response: URLResponse!, data: Data!, error: Error!) -> Void in
                self.image = UIImage(data: data as Data)
            }
        }
    }
}

//MARK: UIView ---------------------------------------------------------

extension UIView{
    
    func setCorner(_ radius : CGFloat = 10.0){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
         
           layer.cornerRadius = radius
           layer.masksToBounds = true;
           backgroundColor = UIColor.white
           layer.shadowColor = color.cgColor
           layer.shadowOpacity = opacity
           layer.shadowOffset = offset
           layer.shadowRadius = radius
           layer.masksToBounds = false
       }
    
}

@IBDesignable extension UIView {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

