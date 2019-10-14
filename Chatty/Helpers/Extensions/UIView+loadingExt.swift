//
//  UIView+loadingExt.swift
//  base
//
//  Created by abdelrahman on 6/3/18.
//  Copyright © 2018 abdelrahman. All rights reserved.
//

import Foundation
import UIKit
import DGActivityIndicatorView
import SnapKit

@IBDesignable
extension UIView {

    func showLoadingView(at centerYOffset: CGFloat, withColor color: UIColor) {
        
        self.stopLoading()
        
        let indicatorView = DGActivityIndicatorView(type: .nineDots, tintColor: color, size: 70)
        indicatorView?.tag = 112233
        indicatorView?.startAnimating()
        
        self.addSubview(indicatorView!)
        self.bringSubviewToFront(indicatorView!)
        
        indicatorView?.snp.makeConstraints { (make) in
            
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(centerYOffset)
        }
    }
    
    func startLoading(withColor color: UIColor) {
        
        self.showLoadingView(at: 0, withColor: color)
    }
    
    func startLoading() {
        self.showLoadingView(at: 0, withColor: .white)
    }
    
    func stopLoading() {
        
        let loadingView = self.viewWithTag(112233) as? DGActivityIndicatorView
        
        loadingView?.stopAnimating()
        
        loadingView?.removeFromSuperview()
    }

}
