//
//  Alerts.swift
//  base
//
//  Created by abdelrahman on 6/3/18.
//  Copyright © 2018 abdelrahman. All rights reserved.
//

import Foundation
import UIKit
import ISMessages

class Alert {

    //MARK:- background colors
    public static var successBackgroundColor : UIColor = UIColor(red: 142.0/255, green: 183.0/255, blue: 64.0/255,  alpha: 0.95)
    
    public static var infoBackgroundColor : UIColor = UIColor(red: 75/255, green: 107/255, blue: 122/255,  alpha: 0.95)
    
    public static var warningBackgroundColor : UIColor = UIColor(red: 230.0/255, green: 189.0/255, blue: 1.0/255,   alpha: 0.95)
    
    public static var errorBackgroundColor : UIColor = UIColor(hex:"c0392b").withAlphaComponent(1)
    
    public static var successImage : UIImage = #imageLiteral(resourceName: "isSuccessIcon.png")
    public static var infoImage : UIImage = #imageLiteral(resourceName: "isInfoIcon.png")
    public static var warningImage : UIImage = #imageLiteral(resourceName: "isWarningIcon.png")
    public static var errorImage : UIImage = #imageLiteral(resourceName: "isErrorIcon.png")
    //MARK:- alert main confgration
    public static func alertConfig(_ ISMessages:ISMessages) {
        ISMessages.parent?.view.semanticContentAttribute = LanguageManager.shared.isRightToLeft ? .forceRightToLeft : .forceLeftToRight
//        ISMessages.titleLabelFont = UIFont(name: "NeoSansArabic", size: 16)
//        ISMessages.messageLabelFont = UIFont(name: "NeoSansArabic", size: 14)
        ISMessages.titleLabelTextColor = .white
        ISMessages.messageLabelTextColor = .white
    }
    
    //MARK:- info alert
    
    class func info(_ title:String = "Info".locale ,message:String ,alertPosition : ISAlertPosition = .top){
        Alert.show(title:title, message:message, backgroundColor:infoBackgroundColor , image:infoImage,alertPosition :alertPosition)
    }
    
    //MARK:- warning alert

    class func warning(_ title:String = "Warning".locale, message:String ,alertPosition : ISAlertPosition = .top){
        Alert.show(title:title, message:message, backgroundColor:warningBackgroundColor , image:warningImage,alertPosition :alertPosition)
    }
    
    //MARK:- danger alert

    class func danger(_ title:String = "Worng".locale ,message:String ,alertPosition : ISAlertPosition = .top){
        Alert.show(title:title, message:message, backgroundColor:errorBackgroundColor , image:errorImage,alertPosition :alertPosition)
    }
    
    //MARK:- success alert

    class func success(_ title:String = "Success".locale,message:String ,alertPosition : ISAlertPosition = .top){
        Alert.show(title:title, message:message, backgroundColor:successBackgroundColor , image:successImage,alertPosition :alertPosition)
    }
    
    //MARK:- show custom alert

    class func show(title:String, message:String, backgroundColor:UIColor, image:UIImage ,alertPosition : ISAlertPosition = .top) {
        
        let cardAlert = ISMessages.cardAlert(
            withTitle: title,
            message: message,
            iconImage: image,
            duration: 5,
            hideOnSwipe: true,
            hideOnTap: true,
            alertType: .custom,
            alertPosition: alertPosition
        )
        
        cardAlert?.alertViewBackgroundColor = backgroundColor
        
        alertConfig(cardAlert!)
        
        cardAlert?.show(nil, didHide: nil)
    }
}
