//
//  AddViewController.swift
//  DatabasesProject
//
//  Created by Swathi Balakrishnan on 12/7/17.
//  Copyright © 2017 Tahia Emran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

class AddViewController: UIViewController {

    let darkPurple = UIColor(red: 17.0/255.0, green: 29.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    let lightPurple = UIColor(red: 48.0/255.0, green: 59.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    let lightPurple1 = UIColor(red: 75.0/255.0, green: 102.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    let middle =  UIColor(red: 90.0/255.0, green: 132.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    let blue1 =  UIColor(red: 103.0/255.0, green: 159.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    let darkBlue = UIColor(red: 125.0/255.0, green: 203.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    
    var myDate = UIDatePicker()
    
    @IBOutlet weak var dateChosen: UITextField!
    @IBOutlet weak var savePressed: UIButton!
    @IBOutlet weak var milesDriven: UITextField!
    @IBOutlet weak var datePicker = UIDatePicker()
    
    fileprivate var miles: String!
    fileprivate var stringDate: String!
    fileprivate var vID = ""
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.view.frame
        view.layer.insertSublayer(newLayer, at: 0)

        ref = Database.database().reference()
        
        dateChosen.inputView = datePicker
        
        self.datePicker?.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        //self.datePicker.setValue(UIColor.white, forKey: "textColor")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dateChanged(_ sender: UIDatePicker) {
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            print("\(day) \(month) \(year)")
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let miles = milesDriven.text, !miles.isEmpty else {print("No miles entered"); return}
        
        print(dateChosen)
//        guard let stringDate = dateChosen.text, !dateChosen.isEmpty else {print("No miles entered"); return}
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("UserVehicles").child(userID!).observeSingleEvent(of: .value, with: { snapshot in
                let vehicleID = snapshot.value!
                print("user", userID!, "has vID", vehicleID)
                self.vID = String(describing: vehicleID)
                print (self.vID)
                let key = self.ref.child("UserTrips").childByAutoId().key
                let trip = [
                    //"date": String(describing: self.dateChosen),
                    "date": "353",
                    "miles": miles,
                    "vehicleId": self.vID
                ]
                let childUpdates = ["/UserTrips/\(userID!)/\(key)/": trip]
            
                self.ref.updateChildValues(childUpdates)
        })
    }}
    
    func datePicked(_ sender: UIDatePicker){
        print(sender.date)
    }


extension AddViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
}

extension AddViewController: UIPickerViewDelegate, UITextFieldDelegate{
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//
//        let attrName: NSMutableAttributedString = NSMutableAttributedString(string: carName)
//        attrName.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSMakeRange(0, carName.count))
//        return NSAttributedString(attributedString: attrName)
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected row", row)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.becomeFirstResponder()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.miles = milesDriven.text!
        self.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.miles = milesDriven.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.resignFirstResponder()
    }

}

