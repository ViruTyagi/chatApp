//
//  SignUpVC.swift
//  chatapp
//
//  Created by Vishavesh Tyagi on 23/08/21.
//

import UIKit
import FirebaseAuth
import Firebase
class SignUpVC: UIViewController{
    
    // MARK:- OUTLETS AND VARIABLES
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneCodeTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var profileImageOutlet: UIImageView!
    
    var db: Firestore!
    
    //MARK:- PROPERTIES
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
                // [END setup]
        db = Firestore.firestore()

        setUpTextFields()
        // Do any additional setup after loading the view.
    }
    
    func setUpTextFields(){
        nameTF.delegate = self
        passwordTF.delegate = self
        confirmPasswordTF.delegate = self
        emailTF.delegate = self
        phoneTF.delegate = self
        phoneCodeTF.delegate = self
        emailTF.keyboardType = .emailAddress
        passwordTF.isSecureTextEntry = true
        confirmPasswordTF.isSecureTextEntry = true
        profileImageOutlet.layer.cornerRadius = profileImageOutlet.frame.height/2
        nameTF.addleftPadding()
        nameTF.attPlaceholder(placeholder: "Full Name")
        passwordTF.addleftPadding()
        passwordTF.attPlaceholder(placeholder: "Password")
        confirmPasswordTF.addleftPadding()
        confirmPasswordTF.attPlaceholder(placeholder: "Confirm Password")
        emailTF.addleftPadding()
        emailTF.attPlaceholder(placeholder: "Email")
        phoneTF.addleftPadding()
        phoneTF.attPlaceholder(placeholder: "Phone Number")
        phoneCodeTF.addleftPadding()
        phoneCodeTF.attPlaceholder(placeholder: "+91")
        signUpButton.layer.cornerRadius = signUpButton.frame.height/2
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!){result,err in
            if err != nil {
                self.showError(message : "wrong creditionals")
            }
            var ref: DocumentReference? = nil
            ref = self.db.collection("users").addDocument(data: [
                "email": self.emailTF.text!,
                "full name": self.nameTF.text!,
                "password": self.passwordTF.text!,
                "mobile": self.phoneTF.text!
                            ]) { err in
                           if let err = err {
                               print("Error adding document: \(err)")
                           } else {
                               print("Document added with ID: \(ref!.documentID)")
                           }
            }
            
            guard let contactsVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactsVC") as? ContactsVC else {return}
            self.navigationController?.pushViewController(contactsVC, animated: true)
            
        }
        
        
}
    func showError(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    

}


extension SignUpVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
