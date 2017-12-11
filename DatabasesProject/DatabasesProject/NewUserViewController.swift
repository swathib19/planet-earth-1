//
//  NewUserViewController.swift
//  DatabasesProject
//
//  Created by Tahia Emran on 12/7/17.
//  Copyright © 2017 Tahia Emran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class NewUserViewController: UIViewController {
    let darkPurple = UIColor(red: 17.0/255.0, green: 29.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    let lightPurple = UIColor(red: 48.0/255.0, green: 59.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    let lightPurple1 = UIColor(red: 75.0/255.0, green: 102.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    let middle =  UIColor(red: 90.0/255.0, green: 132.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    let blue1 =  UIColor(red: 103.0/255.0, green: 159.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    let darkBlue = UIColor(red: 125.0/255.0, green: 203.0/255.0, blue: 232.0/255.0, alpha: 1.0)

    @IBOutlet weak var createNewUser: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    fileprivate var name: String!
    fileprivate var email: String!
    fileprivate var pass: String!
    fileprivate var zip: String!
    
    var ref: DatabaseReference!
    
    @IBAction func createNewUser(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {print("No email entered"); return}
        guard let password = passwordTextField.text, !password.isEmpty else {print("No pass entered"); return}

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                //registration successful
            }else{
                print("didnt work")
                print(error!)
                //registration failure
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.view.frame
        view.layer.insertSublayer(newLayer, at: 0)
        zipCodeTextField.delegate = self
        //passwordTextField.delegate = self
        
        ref = Database.database().reference()
        
        // set placeholder
        
        self.emailTextField.attributedPlaceholder = getPlaceHolderText(text: "Email Address")
        
        self.nameTextField.attributedPlaceholder = getPlaceHolderText(text: "Name")
        
        self.passwordTextField.attributedPlaceholder = getPlaceHolderText(text: "Password")
        
        self.zipCodeTextField.attributedPlaceholder = getPlaceHolderText(text: "Zip Code")
        
    }
    
    fileprivate func getPlaceHolderText(text:String) -> NSAttributedString{
        let attrPlaceholder = NSMutableAttributedString(string: text)
        attrPlaceholder.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray, range: NSMakeRange(0, text.count))
        let placholderTxt = NSAttributedString(attributedString: attrPlaceholder)
        return placholderTxt
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension NewUserViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.becomeFirstResponder()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.email = emailTextField.text!
        self.name = nameTextField.text!
        self.pass = passwordTextField.text!
        self.zip = zipCodeTextField.text!
        self.resignFirstResponder()
       // self.performSegue(withIdentifier: "login", sender: self.Any?)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.pass = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.zip = zipCodeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.resignFirstResponder()
    }
    
}
