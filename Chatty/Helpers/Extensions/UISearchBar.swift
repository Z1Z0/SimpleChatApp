//
//  UISearchBar.swift
//  BlueAge
//
//  Created by Omar Elhamy on 7/22/19.
//  Copyright © 2019 Omar Elhamy. All rights reserved.
//

import UIKit

extension UISearchBar {

    var textField:UITextField {
        guard let txtField = self.value(forKey: "_searchField") as? UITextField else {
            assertionFailure()
            return UITextField()
        }
        return txtField
    }
}
