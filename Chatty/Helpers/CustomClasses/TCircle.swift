//
//  TMaterialButton.swift
//  Chefaa
//
//  Created by Ahmed Abd Elaziz on 9/4/19.
//  Copyright © 2019 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class TCircle: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width/2
    }
}
