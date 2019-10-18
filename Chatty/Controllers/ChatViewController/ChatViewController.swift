//
//  ChatViewController.swift
//  Chatty
//
//  Created by Ahmed Abd Elaziz on 10/14/19.
//  Copyright © 2019 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var messageTableView: UITableView!
    
    var room:Room?
    var chatMessages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        messageTableView.register(UINib(nibName: "ChatBubbleTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatBubbleTableViewCell")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        observeMessages()
        messageTextField.changePlaceHolderColor(textField: messageTextField, name: "Enter message")
        messageTextField.setLeftPaddingPoints(16.0)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
//MARK:- Observe Messages Functions
    func observeMessages() {
        guard let roomID = self.room?.roomID else {return}
        let databaseRef = Database.database().reference()
        databaseRef.child("rooms").child(roomID).child("messages").observe(.childAdded) { (snapshot) in
            if let dataArray = snapshot.value as? [String:Any] {
                guard let senderName = dataArray["senderName"] as? String, let messageBody = dataArray["text"] as? String, let userId = dataArray["senderId"] as? String else {
                    return
                }
                let message = Message.init(messageKey: snapshot.key, senderName: senderName, messageBody: messageBody, userID: userId)
                self.chatMessages.append(message)
                self.messageTableView.reloadData()
            }
        }
    }
    
//MARK:- Get Username and User ID Functions
    func getUsernameWithID(id: String, completion: @escaping (_ username: String?) -> ()) {
        let databaseRef = Database.database().reference()
        let user = databaseRef.child("users").child(id)
        user.child("username").observeSingleEvent(of: .value) { (snapshot) in
            if let username = snapshot.value as? String {
                completion(username)
            }else{
                completion(nil)
            }
        }
    }
    
//MARK:- Send Messages Functions
    func sendMessages(text:String, completion: @escaping (_ isSuccess: Bool) -> ()) {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference()
        getUsernameWithID(id: userId) { (username) in
            if let username = username {
                if let roomId = self.room?.roomID, let userId = Auth.auth().currentUser?.uid {
                    let dataArray: [String:Any] = ["senderName": username, "text": text, "senderId": userId]
                    let room = databaseRef.child("rooms").child(roomId)
                    room.child("messages").childByAutoId().setValue(dataArray) { (error, ref) in
                        if error == nil {
                            completion(true)
                            //                            self.messageTextField.text = ""
                            //                            print("Success message")
                        }else{
                            completion(false)
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func sendMessageTapped(_ sender: Any) {
        guard let chatText = self.messageTextField.text, chatText.isEmpty == false else {return}
        sendMessages(text: chatText) { (isSuccess) in
            if isSuccess {
                print("Message send successfully")
                self.messageTextField.text = ""
            }
        }
    }
}

//MARK:- UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    
}

//MARK:- UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatBubbleTableViewCell", for: indexPath) as? ChatBubbleTableViewCell
        let message = self.chatMessages[indexPath.row]
        cell?.setMessageData(message: message)
        if message.userID == Auth.auth().currentUser?.uid {
            cell?.setBubbleType(type: .outgoing)
        }else{
            cell?.setBubbleType(type: .incoming)
        }
        return cell!
    }
    
}
