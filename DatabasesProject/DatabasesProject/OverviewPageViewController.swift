//
//  OverviewPageViewController.swift
//  DatabasesProject
//
//  Created by Swathi Balakrishnan on 12/7/17.
//  Copyright © 2017 Tahia Emran. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
import FirebaseCore

class OverviewPageViewController: UIViewController {
    let darkPurple = UIColor(red: 17.0/255.0, green: 29.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    let lightPurple = UIColor(red: 48.0/255.0, green: 59.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    let lightPurple1 = UIColor(red: 75.0/255.0, green: 102.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    let middle =  UIColor(red: 90.0/255.0, green: 132.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    let blue1 =  UIColor(red: 103.0/255.0, green: 159.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    let darkBlue = UIColor(red: 125.0/255.0, green: 203.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    
    //DATA - Query based on the date selected and save the number of miles driven on that day
    @IBOutlet weak var milesDriven: UILabel!
    //DATA - use the number fo miles driven on a date divide by miles gallon * (0.008887/0.898)
    @IBOutlet weak var energyImpact: UILabel!
    
    @IBOutlet weak var datePicked: UIDatePicker!
    //DATA - query the database and save the number of entries that a person has (COUNT)
    @IBOutlet weak var daysLogged: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.view.frame
        view.layer.insertSublayer(newLayer, at: 0)
        self.datePicker.setValue(UIColor.white, forKey: "textColor")
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        let userRef = ref.child("UserTrips")
        let vehRef = ref.child("UserVehicles")
        let vehEmissionsRef = ref.child("VehicleEmissions")
        
        vehRef.child(userID!).observeSingleEvent(of: .value, with: { snapshot in
            let vehicleID = snapshot.value! as? String
            
            var totalMiles = 0
            
            userRef.child(userID!).observeSingleEvent(of: .value, with: { snapshot2 in
                
                let count = Int(snapshot2.childrenCount)
                self.daysLogged.text = String(describing: count)
                
                if let snapshots = snapshot2.children.allObjects as? [DataSnapshot] {
                    for child in snapshots {
                        let tripsSnap = child.childSnapshot(forPath: ("miles"))
                        let data = tripsSnap.value
                        let final = data as! String
                        totalMiles = totalMiles + Int(final)!
                    }
                    self.milesDriven.text = String(describing: totalMiles)
                }
                
                vehEmissionsRef.child(vehicleID!).observeSingleEvent(of: .value, with: { snapshot3 in
                    let emissionsDict = snapshot3.value as! NSDictionary
                    let mpg = emissionsDict["mpg"] as? Int
                    let totalEmissions = (Double(totalMiles)/Double(mpg!)) * (0.008887/0.989)
                    self.energyImpact.text = String((round(100*totalEmissions)/100))
                })
                
            })
        })
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
