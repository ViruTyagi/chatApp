//
//  ViewController.swift
//  chatapp
//
//  Created by Vishavesh Tyagi on 19/08/21.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import FirebaseAuth
import Firebase

class LoginVC: UIViewController {
    // MARK:- OUTLETS AND VARIABLES
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailOuttlet: UITextField!
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var facebookSignInButton: UIButton!
    
    var db: Firestore!
    let signInConfig = GIDConfiguration.init(clientID: "198782295148-sgjqdclr9u2d6ps7dphd0trfcma8ctf5.apps.googleusercontent.com")
    
    //MARK:- PROPERTIES
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonSetup()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func buttonSetup(){
        emailOuttlet.layer.cornerRadius = emailOuttlet.frame.height/2
        passwordOutlet.layer.cornerRadius = passwordOutlet.frame.height/2
        googleSignInButton.layer.cornerRadius = googleSignInButton.frame.height/2
        loginButton.layer.cornerRadius = loginButton.frame.height/2
        facebookSignInButton.layer.cornerRadius = facebookSignInButton.frame.height/2
        emailOuttlet.delegate = self
        passwordOutlet.delegate = self
        emailOuttlet.addleftPadding()
        passwordOutlet.addleftPadding()
        emailOuttlet.attPlaceholder(placeholder: "Email")
        passwordOutlet.attPlaceholder(placeholder: "Password")
    }

    func showError(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
//MARK:- IBActions
extension LoginVC{
    @IBAction func googleSignInPressed(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self){ user,error in
        }
    }
    
        
    @IBAction func loginButtonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailOuttlet.text!, password: passwordOutlet.text!){ result,err in
            if err != nil {
                self.showError(message: "Please Check your Email and Password")
                return
            }
            print("done")
            guard let contactsVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactsVC") as? ContactsVC else {return}
            self.navigationController?.pushViewController(contactsVC, animated: true)
        }
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        guard let signUpVC = storyboard?.instantiateViewController(identifier: "SignUpVC") as? SignUpVC else {return}
        self.navigationController?.pushViewController(signUpVC, animated: true)

    }
    @IBAction func facebookButtonPressed(_ sender: Any) {
       // let loginManager = LoginManager()
        
    }

}

//MARK:- TFDelegates
extension LoginVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
