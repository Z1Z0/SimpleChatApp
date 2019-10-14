//
//  SignupViewController.swift
//  Chatty
//
//  Created by Ahmed Abd Elaziz on 10/14/19.
//  Copyright © 2019 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupPlaceHolderColor()
        setupTextFieldPadding()
    }
    
    func setupPlaceHolderColor() {
        usernameTextField.changePlaceHolderColorToBlack(textField: usernameTextField, name: "Enter your name")
        emailTextField.changePlaceHolderColorToBlack(textField: emailTextField, name: "Enter your email")
        passwordTextField.changePlaceHolderColorToBlack(textField: passwordTextField, name: "Enter your password")
    }
    
    func setupTextFieldPadding() {
        usernameTextField.setLeftPaddingPoints(16.0)
        emailTextField.setLeftPaddingPoints(16.0)
        passwordTextField.setLeftPaddingPoints(16.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        if emailTextField.text?.isBlank == false && usernameTextField.text?.isBlank == false && passwordTextField.text?.isBlank == false {
            if emailTextField.text?.isEmail == true {
                if passwordTextField.text?.isValidPassword == false {
                    guard let email = emailTextField.text, let password = passwordTextField.text else { return }
                    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                        if error == nil {
                            guard let userId = result?.user.uid, let username = self.usernameTextField.text else { return }
                            self.ref = Database.database().reference()
                            let user = self.ref.child("users").child(userId)
                            let dataArray : [String:Any] = ["username":username]
                            user.setValue(dataArray)
                            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "SigninViewController") as? SigninViewController
                            self.show(loginVC!, sender: nil)
                        }else{
                            Alert.danger("Error", message: "\(error!.localizedDescription)", alertPosition: .top)
                        }
                    }
                }else{
                    Alert.danger("Weak password", message: "Please enter password that contains at least one uppercase, at least one digit, at least one lowercase, 8 characters total.", alertPosition: .top)
                }
                
            }else{
                Alert.danger("Error", message: "Please enter a valid email", alertPosition: .top)
            }
            
        }else{
            Alert.danger("Error", message: "Please fill all fields", alertPosition: .top)
        }
        
    }
    
}
