//
//  CFAlert+UIViewControllerExt.swift
//  Chatty
//
//  Created by Ahmed Abd Elaziz on 10/14/19.
//  Copyright © 2019 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import CFAlertViewController
//import Cosmos
extension UIViewController {
    
    func test()  {
     
    }
    
    //MARK: - Alerts
    func actionSheet(title: String,message: String? = nil, actionTitle : String ,cancelTitle:String =
        "Cancel".locale , completion: @escaping (_ action: CFAlertAction) -> ()){
        // Create Alet View Controller
        let alertController = alertViewController(title,message:message)

        // Create Upgrade Action
        let defaultAction = defaultAlertAction(actionTitle) { (action) in
            completion(action)
        }
        // Create Cancel Action
        let cancelAction = cancelAlertAction()
        // Add Action Button Into Alert
        alertController.addAction(defaultAction)
        // Add Action Button Into Alert
        alertController.addAction(cancelAction)
        // Present Alert View Controller
        present(alertController, animated: true, completion: nil)
    }
    
    func alertViewController(_ title: String,message: String? = nil , preferredStyle:CFAlertViewController.CFAlertControllerStyle = .actionSheet) -> CFAlertViewController{
        
        // Create Alet View Controller
        let alertController = CFAlertViewController(title: title,
                                                    titleColor: .mainColor,
                                                    message: message,
                                                    messageColor: nil,
                                                    textAlignment: .center,
                                                    preferredStyle: preferredStyle,
                                                    headerView: nil,
                                                    footerView: nil,
                                                    didDismissAlertHandler: nil)
        
        return alertController
    }

    func defaultAlertAction(_ title:String, backgroundColor:UIColor = .mainColor, completion: @escaping (_ action: CFAlertAction) -> () ) -> CFAlertAction{
        // Create Action
        let action = CFAlertAction(title: title,
                                   style: .Default,
                                   alignment: .justified,
                                   backgroundColor: backgroundColor,
                                   textColor: nil,
                                   handler: { (action) in
                                    completion(action)
        })
        return action
    }
    
    func cancelAlertAction(_ title:String =
        "Cancel".locale) ->  CFAlertAction{
        // Create Action
        let action = CFAlertAction(title: title,
                                   style: .Default,
                                   alignment: .justified,
                                   backgroundColor: .lightGray,
                                   textColor: .white,
                                   handler: nil)
        return action
    }
}
extension UIViewController {
  
}
