//
//  ContactsVC.swift
//  chatapp
//
//  Created by Vishavesh Tyagi on 24/08/21.
//

import UIKit
import Firebase

class ContactsVC: UIViewController {
    
    // MARK:- OUTLETS AND VARIABLES
    @IBOutlet weak var mainTableView: UITableView!
    var data = [QueryDocumentSnapshot]()
    var db: Firestore!
    
    
    //MARK:- PROPERTIES
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
                // [END setup]
        db = Firestore.firestore()

        fetchData()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        let nib = UINib(nibName: "ContactsCell", bundle: nil)
        mainTableView.register(nib, forCellReuseIdentifier: "contactCell")
        // Do any additional setup after loading the view.
    }
    
    
    func fetchData(){
        db.collection("users").getDocuments{ snapshort,err in
            if let _ = err {
                print("Error in reading data")
                return
            }
            for element in snapshort!.documents{
                if element.data()["email"] as? String != Auth.auth().currentUser?.email {
                    self.data.append(element)
                }
            }
            self.mainTableView.reloadData()
        }
    }

}

extension ContactsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell",for: indexPath) as? ContactsCell else {fatalError("Something Wrong with cell")}
        cell.fullName?.text = data[indexPath.row].data()["full name"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = data[indexPath.row].data()["full name"] as! String
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MessageVC") as? MessageVC else {return}
        vc.user = name
        vc.email = data[indexPath.row].data()["email"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
