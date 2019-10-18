//
//  UISearchBar.swift
//  Chatty
//
//  Created by Ahmed Abd Elaziz on 10/14/19.
//  Copyright © 2019 Ahmed Abd Elaziz. All rights reserved.
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
