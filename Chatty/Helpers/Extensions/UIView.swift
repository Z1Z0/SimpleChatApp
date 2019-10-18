//
//  UIView.swift
//  Chatty
//
//  Created by Ahmed Abd Elaziz on 10/14/19.
//  Copyright © 2019 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
extension UIView {
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.backgroundColor = UIColor.green.cgColor
        self.layer.mask = rectShape

    }

    @IBInspectable var setRightCorners: CGFloat {
        get {
            return  0
        }
        set {
            if #available(iOS 11.0, *){
                self.clipsToBounds = false
                self.layer.cornerRadius = newValue
                if LanguageManager.shared.isRightToLeft {
                    self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
                }else{
                    self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                }
            }else{
                if LanguageManager.shared.isRightToLeft {
                    roundCorners([.topLeft , .bottomLeft], radius: newValue)
                }else{
                    roundCorners([.topRight , .bottomRight], radius: newValue)
                }
            }
        }
    }
    
    @IBInspectable var setLeftCorners: CGFloat {
        get {
            return  0
        }
        set {
            if newValue != 0 {
                if #available(iOS 11.0, *){
                    self.clipsToBounds = false
                    self.layer.cornerRadius = newValue
                    if LanguageManager.shared.isRightToLeft {
                        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                    }else{
                        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
                    }
                }else{
                    if LanguageManager.shared.isRightToLeft {
                        roundCorners([.topRight , .bottomRight], radius: newValue)
                    }else{
                        roundCorners([.topLeft , .bottomLeft], radius: newValue)
                    }
                }
            }
        }
    }
    
    
    @IBInspectable var setTopCorners: CGFloat {
        get {
            return  0
        }
        set {
            if newValue != 0 {
                if #available(iOS 11.0, *){
                    self.clipsToBounds = false
                    self.layer.cornerRadius = newValue
                    self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                }else{
                    roundCorners([.topRight , .topLeft], radius: newValue)
                }
            }
        }
    }
    
    
    @IBInspectable var setBottomCorners: CGFloat {
        get {
            return  0
        }
        set {
            if newValue != 0 {
                if #available(iOS 11.0, *){
                    self.clipsToBounds = false
                    self.layer.cornerRadius = newValue
                    self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                }else{
                    roundCorners([.bottomRight , .bottomLeft], radius: newValue)
                }
            }
        }
    }
    
    @IBInspectable var setBottomLeftCorners: CGFloat {
        get {
            return  0
        }
        set {
            if newValue != 0 {
                if #available(iOS 11.0, *){
                    self.clipsToBounds = false
                    self.layer.cornerRadius = newValue
                    self.layer.maskedCorners = [.layerMinXMaxYCorner]
                }else{
                    roundCorners([.bottomLeft], radius: newValue)
                }
            }
        }
    }
    
    @IBInspectable var setBottomRightCorners: CGFloat {
        get {
            return  0
        }
        set {
            if newValue != 0 {
                if #available(iOS 11.0, *){
                    self.clipsToBounds = false
                    self.layer.cornerRadius = newValue
                    self.layer.maskedCorners = [.layerMaxXMaxYCorner]
                }else{
                    roundCorners([.bottomRight], radius: newValue)
                }
            }
        }
    }
    
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow(shadowColor:UIColor.black.cgColor )
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var SetShadowColor: UIColor {
        get {
            return .black
        }
        set {
            self.addShadow(shadowColor: newValue.cgColor )
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0, height: 2),
                   shadowOpacity: Float = 0.3,
                   shadowRadius: CGFloat = 6.0) {
        self.layer.masksToBounds = false
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    func addTapGesture(tapNumber : Int, target: Any , action : Selector) {
        
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func constrainCentered(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0)
        
        let horizontalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0)
        
        let heightContraint = NSLayoutConstraint(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.height)
        
        let widthContraint = NSLayoutConstraint(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.width)
        
        addConstraints([
            horizontalContraint,
            verticalContraint,
            heightContraint,
            widthContraint])
        
    }
    
    func constrainToEdges(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0)
        
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
    
    
}
