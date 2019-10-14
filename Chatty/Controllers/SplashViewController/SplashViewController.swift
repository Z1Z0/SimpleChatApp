//
//  ViewController.swift
//  Chatty
//
//  Created by Ahmed Abd Elaziz on 10/14/19.
//  Copyright © 2019 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        if (Auth.auth().currentUser != nil) {
            let roomsVC = self.storyboard?.instantiateViewController(withIdentifier: "RoomsViewController") as? RoomsViewController
            self.show(roomsVC!, sender: nil)
        }else{
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "SigninViewController") as? SigninViewController
            self.show(loginVC!, sender: nil)
        }
    }


}

