//
//  MessageVC.swift
//  chatapp
//
//  Created by Vishavesh Tyagi on 26/08/21.
//

import UIKit
import Firebase

class MessageVC: UIViewController {
//MARK:- Outlets and Variables
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    var user = ""
    var email = ""
    var data = [QueryDocumentSnapshot]()
    
//MARK:- Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        title = user
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        messageTextField.delegate = self

        loadMessage()
        messageTextField.layer.cornerRadius = messageTextField.frame.height/2
        messageTextField.addleftPadding()
    }
    
    func loadMessage(){
        db.collection("messages").order(by: "time").addSnapshotListener { querySnapShot, error in
            if let e = error {
                print("There is an issue retrieving data\(e)")
            }
            else{
                if let snapshotDocument = querySnapShot?.documents{
                    self.data = snapshotDocument.filter{ snap in
                        if snap.data()["sender"] as? String == self.email && snap.data()["reciver"] as? String == Auth.auth().currentUser?.email || snap.data()["sender"] as? String == Auth.auth().currentUser?.email && snap.data()["reciver"] as? String == self.email {
                            return true
                        }
                        return false
                      }
                    
                        DispatchQueue.main.async {
                                    self.chatTableView.reloadData()
                    }
                }
            }
        }
    }
    //MARK:- IBAction
    @IBAction func sendPressed(_ sender: Any) {
        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        if let messageBody = messageTextField.text,let sender = Auth.auth().currentUser?.email{
            db.collection("messages").addDocument(data: ["sender": sender,"body":messageBody,"time":Date().timeIntervalSince1970,"reciver":email,"messageSentTime":formatter.string(from: currentTime)]) { error in
                if let e = error{
                    print("You have some issues\(e)")
                }
                else{
                    print("successfully saved")
                }
            }
        }
        messageTextField.text = ""
    }



}
//MARK:- TableView Delegates
extension MessageVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msgbody = data[indexPath.row].data()["body"] as! String
        let time = data[indexPath.row].data()["messageSentTime"] as! String
        
        let messageCell = self.chatTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell
        messageCell.messageLbl.text = msgbody
        messageCell.timeLbl.text = time
        
        let messageCell2 = self.chatTableView.dequeueReusableCell(withIdentifier: "messageCell2", for: indexPath) as! SenderMessageCell
        messageCell2.messageLbl?.text = msgbody
        messageCell2.timeLbl?.text = time
        
        if data[indexPath.row].data()["sender"] as? String == Auth.auth().currentUser?.email {
            return messageCell
        }
        else{
            return messageCell2
        }
    
    }
}

//MARK:- TextField Delegates
extension MessageVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
