//
//  CarPageViewController.swift
//  DatabasesProject
//
//  Created by Swathi Balakrishnan on 12/9/17.
//  Copyright © 2017 Tahia Emran. All rights reserved.
//

import UIKit

class CarPageViewController: UIViewController {

    let darkPurple = UIColor(red: 17.0/255.0, green: 29.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    let lightPurple = UIColor(red: 48.0/255.0, green: 59.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    let lightPurple1 = UIColor(red: 75.0/255.0, green: 102.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    let middle =  UIColor(red: 90.0/255.0, green: 132.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    let blue1 =  UIColor(red: 103.0/255.0, green: 159.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    let darkBlue = UIColor(red: 125.0/255.0, green: 203.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    @IBOutlet weak var car1Make: UITextField!
    //DATA - Save car1 make, model, and year into the database
    @IBOutlet weak var car1Model: UITextField!
    @IBOutlet weak var car1Year: UITextField!
    
    fileprivate var carMake1: String!
    fileprivate var carModel1: String!
    fileprivate var carYear1: String!

    
    @IBOutlet weak var car2Make: UITextField!
    //DATA - SAVE car2 make, model, and year into the database (if it exists)
    @IBOutlet weak var car2Model: UITextField!
    @IBOutlet weak var car2Year: UITextField!
    
    fileprivate var carMake2: String!
    fileprivate var carModel2: String!
    fileprivate var carYear2: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.view.frame
        view.layer.insertSublayer(newLayer, at: 0)
       
        self.car1Year.delegate = self
        self.car2Year.delegate = self
        
        self.car1Make.attributedPlaceholder = getPlaceHolderText(text: "Car Make")
        self.car1Model.attributedPlaceholder = getPlaceHolderText(text: "Car Model")
        self.car1Year.attributedPlaceholder = getPlaceHolderText(text: "Car Year")
        
        self.car2Make.attributedPlaceholder = getPlaceHolderText(text: "Car Make")
        self.car2Model.attributedPlaceholder = getPlaceHolderText(text: "Car Model")
        self.car2Year.attributedPlaceholder = getPlaceHolderText(text: "Car Year")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func getPlaceHolderText(text:String) -> NSAttributedString{
        let attrPlaceholder = NSMutableAttributedString(string: text)
        attrPlaceholder.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray, range: NSMakeRange(0, text.count))
        let placholderTxt = NSAttributedString(attributedString: attrPlaceholder)
        return placholderTxt
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveButtonClicked(_ sender: Any) {
        self.carMake1 = car1Make.text!
        self.carModel1 = car1Model.text!
        self.carYear1 = car1Year.text!
        
        self.carMake2 = car2Make.text!
        self.carModel2 = car2Model.text!
        self.carYear2 = car2Year.text!
        
    }
    
    
    
    
    
}

extension CarPageViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.becomeFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.carMake1 = car1Make.text!
        self.carModel1 = car1Model.text!
        self.carYear1 = car1Year.text!
        
        self.carMake2 = car2Make.text!
        self.carModel2 = car2Model.text!
        self.carYear2 = car2Year.text!
        
        self.resignFirstResponder()
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.carMake1 = car1Make.text!
        self.carModel1 = car1Model.text!
        self.carYear1 = car1Year.text!
        
        self.carMake2 = car2Make.text!
        self.carModel2 = car2Model.text!
        self.carYear2 = car2Year.text!
        self.resignFirstResponder()
        return true
    }
}

