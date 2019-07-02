//
//  SignInViewController.swift
//  test
//
//  Created by Prashuk Ajmera on 7/2/19.
//  Copyright © 2019 Prashuk Ajmera. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    var db: Firestore!
    var data: [String: Any]?
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        guard let userEmail = Auth.auth().currentUser?.email else { return }
        
        let docRef = db.collection(userEmail).document("profileData")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.data = document.data()
                if let data = self.data {
                    self.navItem.title = "Welcome" + (data["name"] as? String ?? "")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "toLoginViewController", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    @IBAction func unwindToSignInViewController(segue:UIStoryboardSegue) { }
}
