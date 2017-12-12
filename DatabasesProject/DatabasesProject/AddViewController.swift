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
    
    
    
    @IBOutlet weak var dateChosen: UITextField!
    @IBOutlet weak var savePressed: UIButton!
    @IBOutlet weak var milesDriven: UITextField!

    let datePicker = UIDatePicker()
    
    var tripMiles: String!
    var tripDate: String!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.view.frame
        view.layer.insertSublayer(newLayer, at: 0)

        createDatePicker()
        
        
        //self.datePicker.setValue(UIColor.white, forKey: "textColor")
        // Do any additional setup after loading the view.
    }
    
    func createDatePicker(){
        
        datePicker.datePickerMode = .date
        
        dateChosen.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector (doneClicked))
        toolbar.setItems([doneButton], animated: true)
        
        dateChosen.inputAccessoryView = toolbar
    }
    
    func doneClicked(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        dateChosen.text = dateFormatter.string(from: datePicker.date)
        tripDate = dateChosen.text
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func savePressed(_ sender: Any) {
        guard let miles = milesDriven.text, !miles.isEmpty else {print("No miles entered"); return}
        guard let thisDate = dateChosen.text, !thisDate.isEmpty else {print("No date entered"); return}

        let userID = Auth.auth().currentUser?.uid
        var vID : Any = ""
        
        var ref = Database.database().reference().child("UserVehicles/".appending(userID!))
        
        ref.observeSingleEvent(of: .value, with: {snapshot in
            let whatDoIhave = snapshot.value!
            vID = whatDoIhave
        })
        
        ref = Database.database().reference().child("UserTrips/".appending(userID!))
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
                let myTrips = snapshot.value!
                print(myTrips)
                let key = ref.childByAutoId().key
                print(key)
                let trip = [
                    //"date": String(describing: self.dateChosen),
                    "date": self.tripDate,
                    "miles": self.tripMiles,
                    "vehicleId": vID
                ]
                print(trip)
                let update = ["\(userID!)/\(key)/": trip]
            
                ref.updateChildValues(update)
        })
    }}


extension AddViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
}

extension AddViewController: UITextFieldDelegate{
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//
//        let attrName: NSMutableAttributedString = NSMutableAttributedString(string: carName)
//        attrName.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSMakeRange(0, carName.count))
//        return NSAttributedString(attributedString: attrName)
//    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.becomeFirstResponder()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tripMiles = milesDriven.text!
        self.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.tripMiles = milesDriven.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.resignFirstResponder()
    }

}

