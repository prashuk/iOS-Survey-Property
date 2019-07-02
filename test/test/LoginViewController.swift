//
//  LoginViewController.swift
//  test
//
//  Created by Prashuk Ajmera on 5/30/19.
//  Copyright © 2019 Prashuk Ajmera. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordAgainTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var companyTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    
    @IBOutlet weak var segmentSignInUp: UISegmentedControl!
    @IBOutlet weak var signBtn: UIButton!
    
    var isSignIn: Bool = true
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextfield.text = "user@gmail.com"
        passwordTextfield.text = "123456"
        
        passwordAgainTextfield.isHidden = true
        nameTextfield.isHidden = true
        companyTextfield.isHidden = true
        phoneTextfield.isHidden = true
        
        db = Firestore.firestore()
    }
    
    @IBAction func signInUpSegmentTapped(_ sender: Any) {
        isSignIn = !isSignIn
        
        if isSignIn {
            passwordAgainTextfield.isHidden = true
            nameTextfield.isHidden = true
            companyTextfield.isHidden = true
            phoneTextfield.isHidden = true
            signBtn.setTitle("Sign In", for: .normal)
        } else {
            passwordAgainTextfield.isHidden = false
            nameTextfield.isHidden = false
            companyTextfield.isHidden = false
            phoneTextfield.isHidden = false
            signBtn.setTitle("Sign Up", for: .normal)
        }
    }
    
    @IBAction func signBtn(_ sender: Any) {
        
        if let email = usernameTextfield.text, let password = passwordTextfield.text, let name = nameTextfield.text, let company = companyTextfield.text, let phone = phoneTextfield.text {
            if isSignIn {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    
                    if user != nil {
                        self.performSegue(withIdentifier: "loggedin", sender: self)
                    } else {
                        if let errCode = AuthErrorCode(rawValue: error!._code) {
                            switch errCode {
                            case .userNotFound:
                                let alert = UIAlertController(title: "Email not registered", message: "", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                self.present(alert, animated: true)
                            case .wrongPassword:
                                let alert = UIAlertController(title: "Wrong Password", message: "", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                self.present(alert, animated: true)
                            case .networkError:
                                let alert = UIAlertController(title: "Connect internet", message: "", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                self.present(alert, animated: true)
                            default:
                                print("Signin Error: \(error!)")
                            }
                        }
                    }
                    
                }
            } else {
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    
                    if user != nil {
                        let alert = UIAlertController(title: "Thank you for Singup", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                            
                            
                            self.db.collection(email).document("profileData").setData([
                                "email": email,
                                "name": name,
                                "company": company,
                                "phone": phone
                            ]) { err in
                                if let err = err {
                                    print("Error adding document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
                            }
                            
                            self.usernameTextfield.text = ""
                            self.passwordTextfield.text = ""
                            self.passwordAgainTextfield.text = ""
                            self.nameTextfield.text = ""
                            self.companyTextfield.text = ""
                            self.phoneTextfield.text = ""
                            self.usernameTextfield.becomeFirstResponder()
                        }))
                        
                        self.present(alert, animated: true)
                        
                    } else {
                        
                        if let errCode = AuthErrorCode(rawValue: error!._code) {
                            switch errCode {
                            case .emailAlreadyInUse:
                                let alert = UIAlertController(title: "Email already registered", message: "", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                self.present(alert, animated: true)
                            case .invalidEmail:
                                let alert = UIAlertController(title: "Invalid email id", message: "", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                self.present(alert, animated: true)
                            case .networkError:
                                let alert = UIAlertController(title: "Connect internet", message: "", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                self.present(alert, animated: true)
                            default:
                                print("Signup Error: \(error!)")
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    
    @IBAction func unwindToLoginViewController(segue:UIStoryboardSegue) { }
    
}
