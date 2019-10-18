//
//  UITextField+Extensions.swift
//  Chatty
//
//  Created by Ahmed Abd Elaziz on 10/14/19.
//  Copyright © 2019 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func changePlaceHolderColor(textField: UITextField,name: String) {
        textField.attributedPlaceholder = NSAttributedString(string: name,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func changePlaceHolderColorToBlack(textField: UITextField,name: String) {
        textField.attributedPlaceholder = NSAttributedString(string: name,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }
}
