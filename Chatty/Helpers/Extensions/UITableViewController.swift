//
//  UITableViewController.swift
//  BlueAge
//
//  Created by Omar Elhamy on 7/4/19.
//  Copyright © 2019 Omar Elhamy. All rights reserved.
//

import UIKit

extension UITableView {
    
    func getSwipIcon(_ imageName:String , indexPath:IndexPath , backgroundColor :UIColor = .white) -> UIImage {
        let backView = UIView()
        backView.backgroundColor = backgroundColor
        let frame = self.rectForRow(at: indexPath)
        
        let myImage = UIImageView()
        
        backView.frame = CGRect(x: 0, y: 0, width: 100, height: self.frame.size.height)

        myImage.frame = CGRect(x: LanguageManager.shared.isRightToLeft ? 180 : 20, y: frame.size.height/2-20, width: 35, height: 35)

        myImage.image = UIImage(named: imageName)!
        backView.addSubview(myImage)
        
        let imgSize: CGSize = self.frame.size
        UIGraphicsBeginImageContextWithOptions(imgSize, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        backView.layer.render(in: context!)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
        
    }
}
