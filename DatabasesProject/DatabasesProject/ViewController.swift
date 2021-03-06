//
//  ViewController.swift
//  DatabasesProject
//
//  Created by Tahia Emran on 11/9/17.
//  Copyright © 2017 Tahia Emran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    let darkPurple = UIColor(red: 17.0/255.0, green: 29.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    let lightPurple = UIColor(red: 48.0/255.0, green: 59.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    let lightPurple1 = UIColor(red: 75.0/255.0, green: 102.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    let middle =  UIColor(red: 90.0/255.0, green: 132.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    let blue1 =  UIColor(red: 103.0/255.0, green: 159.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    let darkBlue = UIColor(red: 125.0/255.0, green: 203.0/255.0, blue: 232.0/255.0, alpha: 1.0)

    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    fileprivate var emailAddress: String!
    fileprivate var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //Do any additional setup after loading the view, typically from a nib.
        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.view.frame
        view.layer.insertSublayer(newLayer, at: 0)
        self.emailTextField.delegate = self;
        self.passwordTextField.delegate = self;
        
        // set placeholder
        let placeholderString = "Email Address"
        let attrPlaceholder = NSMutableAttributedString(string: placeholderString)
        attrPlaceholder.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSMakeRange(0, placeholderString.count))
        let placholderTxt = NSAttributedString(attributedString: attrPlaceholder)
        //self.emailTextField.attributedPlaceholder = placholderTxt
        
    }
    
  
    
    
    @IBAction func Login(_ sender: UIButton) {
        
        guard let emailAddress = emailTextField.text, !emailAddress.isEmpty else {print("No email entered"); return}
        guard let password = passwordTextField.text, !password.isEmpty else {print("No pass entered"); return}
        
        Auth.auth().signIn(withEmail: emailAddress, password: password){ (user, error) in
            if error == nil {
                print("successful sign in")
                self.performSegue(withIdentifier: "login", sender: Any?)
            }else{
                print("didnt work")
                print(error!)
                //registration failure
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// take care of text in text fields 

extension ViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.becomeFirstResponder()
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailAddress = emailTextField.text!
        self.password = passwordTextField.text!
        self.resignFirstResponder()
        return true;
    }
    
}

