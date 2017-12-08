//
//  ViewController.swift
//  DatabasesProject
//
//  Created by Tahia Emran on 11/9/17.
//  Copyright © 2017 Tahia Emran. All rights reserved.
//

import UIKit

// dark purple = 111D44
// middle = 303B74
// middle = 4B66A0
// middle = 5A84B6
// middle = 679FCA
// blue = 7DCBE8

class ViewController: UIViewController {

    let darkPurple = UIColor(red: 17.0/255.0, green: 29.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    let lightPurple = UIColor(red: 48.0/255.0, green: 59.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    let lightPurple1 = UIColor(red: 75.0/255.0, green: 102.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    let middle =  UIColor(red: 90.0/255.0, green: 132.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    let blue1 =  UIColor(red: 103.0/255.0, green: 159.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    let darkBlue = UIColor(red: 125.0/255.0, green: 203.0/255.0, blue: 232.0/255.0, alpha: 1.0)

    @IBOutlet weak var emailTextField: UITextField!
    fileprivate var emailAddress: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print ("hi")
         //Do any additional setup after loading the view, typically from a nib.
        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.view.frame
        view.layer.insertSublayer(newLayer, at: 0)
        self.emailTextField.delegate = self;
     
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
        print(self.emailAddress)
        self.resignFirstResponder()
        self.performSegue(withIdentifier: "login", sender: Any?)
        return true;
    }
    
}

