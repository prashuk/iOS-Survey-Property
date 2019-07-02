//
//  ViewController.swift
//  test
//
//  Created by Prashuk Ajmera on 1/11/19.
//  Copyright © 2019 Prashuk Ajmera. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

class DashboardViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    var db: Firestore!
    
    var elevationImages: [UIImage] = []
    
    let sectionPicker = UIPickerView()
    let sectionData = ["Deteriorated Window Sill", "Deteriorated Lintels", "Cracked Masonry", "Spalled Masonary", "Deteriorated Mortar Joints", "Deteriorated Copping Stone", "Loose Fascia", "Spalled Concrete"]
    let nycData = ["Yes", "No", "Not Applicable"]
    var flag = 0;
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var elevationImageView: UIImageView!
    
    @IBOutlet weak var elevationTextfield: UITextField!
    @IBOutlet weak var floorTextfield: UITextField!
    @IBOutlet weak var windowLineTextfield: UITextField!
    @IBOutlet weak var sectionTextfield: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var appurtenancesTextfield: UITextField!
    @IBOutlet weak var railingsTextfield: UITextField!
    @IBOutlet weak var balconiesTextfield: UITextField!
    @IBOutlet weak var parapetTextfield: UITextField!
    @IBOutlet weak var fireescapesTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navItem.title = "New Project"
        
        elevationImageView.layer.borderWidth = 1
        elevationImageView.layer.borderColor = UIColor.black.cgColor
        
        let image = UIImage(named: "map.png")
        elevationImageView.image = image
        view.addSubview(elevationImageView)
        
        notesTextView.layer.borderWidth = 1
        notesTextView.layer.borderColor = UIColor.black.cgColor
        
        sectionPicker.delegate = self
        
        sectionTextfield.delegate = self
        appurtenancesTextfield.delegate = self
        railingsTextfield.delegate = self
        balconiesTextfield.delegate = self
        parapetTextfield.delegate = self
        fireescapesTextfield.delegate = self
        
        sectionTextfield.inputView = sectionPicker
        appurtenancesTextfield.inputView = sectionPicker
        railingsTextfield.inputView = sectionPicker
        balconiesTextfield.inputView = sectionPicker
        parapetTextfield.inputView = sectionPicker
        fireescapesTextfield.inputView = sectionPicker
        
        sectionTextfield.autocorrectionType = .no
        appurtenancesTextfield.autocorrectionType = .no
        railingsTextfield.autocorrectionType = .no
        balconiesTextfield.autocorrectionType = .no
        parapetTextfield.autocorrectionType = .no
        fireescapesTextfield.autocorrectionType = .no
        
        let toolBar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.size.width, height: 40)))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        
        let defaultButton = UIBarButtonItem(title: "Default", style: UIBarButtonItem.Style.plain, target: self, action: #selector(DashboardViewController.tappedToolBarBtn))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(DashboardViewController.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        toolBar.setItems([defaultButton,flexSpace,doneButton], animated: true)
        
        sectionTextfield.inputAccessoryView = toolBar
        appurtenancesTextfield.inputAccessoryView = toolBar
        railingsTextfield.inputAccessoryView = toolBar
        balconiesTextfield.inputAccessoryView = toolBar
        parapetTextfield.inputAccessoryView = toolBar
        fireescapesTextfield.inputAccessoryView = toolBar
        
        db = Firestore.firestore()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == sectionTextfield {
            flag = 1
        } else if textField == appurtenancesTextfield {
            flag = 2
        } else if textField == railingsTextfield {
            flag = 3
        } else if textField == balconiesTextfield {
            flag = 4
        } else if textField == parapetTextfield {
            flag = 5
        } else if textField == fireescapesTextfield {
            flag = 6
        }
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        if flag == 1 {
            sectionTextfield.resignFirstResponder()
        } else if flag == 2 {
            appurtenancesTextfield.resignFirstResponder()
        } else if flag == 3 {
            railingsTextfield.resignFirstResponder()
        } else if flag == 4 {
            balconiesTextfield.resignFirstResponder()
        } else if flag == 5 {
            parapetTextfield.resignFirstResponder()
        } else if flag == 6 {
            fireescapesTextfield.resignFirstResponder()
        }
    }
    
    @objc func tappedToolBarBtn(sender: UIBarButtonItem) {
        if flag == 1 {
            sectionTextfield.text = sectionData[0]
            sectionTextfield.resignFirstResponder()
        } else if flag == 2 {
            appurtenancesTextfield.text = nycData[0]
            appurtenancesTextfield.resignFirstResponder()
        } else if flag == 3 {
            railingsTextfield.text = nycData[0]
            railingsTextfield.resignFirstResponder()
        } else if flag == 4 {
            balconiesTextfield.text = nycData[0]
            balconiesTextfield.resignFirstResponder()
        } else if flag == 5 {
            parapetTextfield.text = nycData[0]
            parapetTextfield.resignFirstResponder()
        } else if flag == 6 {
            fireescapesTextfield.text = nycData[0]
            fireescapesTextfield.resignFirstResponder()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if flag == 1 {
            return sectionData.count
        } else {
            return nycData.count
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if flag == 1 {
            return sectionData[row]
        } else {
            return nycData[row]
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if flag == 1 {
            sectionTextfield.text = sectionData[row]
        } else if flag == 2 {
            appurtenancesTextfield.text = nycData[row]
        } else if flag == 3 {
            railingsTextfield.text = nycData[row]
        } else if flag == 4 {
            balconiesTextfield.text = nycData[row]
        } else if flag == 5 {
            parapetTextfield.text = nycData[row]
        } else if flag == 6 {
            fireescapesTextfield.text = nycData[row]
        }
    }
    
    @IBAction func rightBtnImage(_ sender: Any) {
        
    }
    
    @IBAction func leftBtnImage(_ sender: Any) {
        
    }
    
    @IBAction func camButtonTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func infoBtnTapped(_ sender: Any) {
        showPopup()
    }
    
    @IBAction func infoBtnTapped2(_ sender: Any) {
        showPopup()
    }
    
    func showPopup() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupSB") as! PopupViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    @IBAction func imgButtonMain(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveInfo(_ sender: Any) {
        
        var ref: DocumentReference? = nil
        guard let userEmail = Auth.auth().currentUser?.email else { return }
        ref = db.collection(userEmail + "/data/projects").addDocument(data: [
            "elevation": elevationTextfield.text ?? "",
            "floor": floorTextfield.text ?? "",
            "windowLine": windowLineTextfield.text ?? "",
            "condition": sectionTextfield.text ?? "",
            "notes": notesTextView.text ?? "",
            "appurtenances": appurtenancesTextfield.text ?? "",
            "railings": railingsTextfield.text ?? "",
            "balconies": balconiesTextfield.text ?? "",
            "parapetWalls": parapetTextfield.text ?? "",
            "fireEscapes": fireescapesTextfield.text ?? ""
            ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                let alert = UIAlertController(title: "Data Saved", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    self.performSegue(withIdentifier: "toSignInViewController", sender: self)
                }))
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func nextImage(_ sender: Any) {
        
    }
    
    @IBAction func previousImage(_ sender: Any) {
        
    }
    
}

