//
//  SigninViewController.swift
//  Chatty
//
//  Created by Ahmed Abd Elaziz on 10/14/19.
//  Copyright © 2019 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Firebase

class SigninViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signinButton.bindToKeyboard()
        setupPlaceHolderColor()
        setupTextFieldPadding()
    }
    
//MARK:- Setup Placeholder Color Functions
    func setupPlaceHolderColor() {
        emailTextField.changePlaceHolderColorToBlack(textField: emailTextField, name: "Enter your email")
        passwordTextField.changePlaceHolderColorToBlack(textField: passwordTextField, name: "Enter your password")
    }
    
//MARK:- Setup Text Field Padding Functions
    func setupTextFieldPadding() {
        emailTextField.setLeftPaddingPoints(16.0)
        passwordTextField.setLeftPaddingPoints(16.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func signinTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error == nil {
                print("Success login")
                let roomsVC = self.storyboard?.instantiateViewController(withIdentifier: "RoomsViewController") as? RoomsViewController
                self.show(roomsVC!, sender: nil)
            }else{
                Alert.danger("Error", message: error!.localizedDescription, alertPosition: .top)
            }
        }
    }

}
