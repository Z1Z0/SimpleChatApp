//
//  RoomsViewController.swift
//  Chatty
//
//  Created by Ahmed Abd Elaziz on 10/14/19.
//  Copyright © 2019 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Firebase

class RoomsViewController: UIViewController {
    
    @IBOutlet weak var roomsTableView: UITableView!
    @IBOutlet weak var addRoomNameTextField: UITextField!
    
    var rooms = [Room]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.roomsTableView.register(UINib(nibName: "RoomsTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomsTableViewCell")
        self.navigationItem.setHidesBackButton(true, animated: false)
        addRoomNameTextField.changePlaceHolderColor(textField: addRoomNameTextField, name: "Room Name")
        addRoomNameTextField.setLeftPaddingPoints(16.0)
        observeRooms()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }

    @IBAction func signoutTapped(_ sender: Any){
        let alertController = UIAlertController(title: "Are you sure you want to signout?", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Signout", style: .destructive, handler: { (_) in
            try! Auth.auth().signOut()
            let toLoginVC = self.storyboard?.instantiateViewController(withIdentifier: "SigninViewController") as? SigninViewController
            self.show(toLoginVC!, sender: nil)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addRoomNameTapped(_ sender: Any){
        guard let roomName = self.addRoomNameTextField.text, roomName.isEmpty == false else {return}
        
        let databaseRef = Database.database().reference()
        let room = databaseRef.child("rooms").childByAutoId()
        let dataArray : [String:Any] = ["roomName":roomName]
        room.setValue(dataArray) { (error, ref) in
            if error == nil {
                self.addRoomNameTextField.text = ""
            }
        }
    }

//MARK:- Observe Rooms Functions
    func observeRooms() {
        let databaseRef = Database.database().reference()
        databaseRef.child("rooms").observe(.childAdded) { (snapshot) in
            if let dataArray = snapshot.value as? [String: Any] {
                if let roomName = dataArray["roomName"] as? String {
                    let room = Room.init(roomName: roomName, roomID: snapshot.key)
                    self.rooms.append(room)
                    self.roomsTableView.reloadData()
                }
            }
        }
    }

}

//MARK:- UITableViewDelegate
extension RoomsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //Choose your custom row height
    }
}

//MARK:- UITableViewDataSource
extension RoomsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsTableViewCell", for: indexPath) as? RoomsTableViewCell
        let room = self.rooms[indexPath.row]
        cell?.roomName.text = room.roomName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRoom = self.rooms[indexPath.row]
        let chatVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        chatVC?.room = selectedRoom
        self.show(chatVC!, sender: nil)
    }
    
}
