//
//  StatsPageViewController.swift
//  DatabasesProject
//
//  Created by Tahia Emran on 12/7/17.
//  Copyright © 2017 Tahia Emran. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
import FirebaseCore

class StatsPageViewController: UIViewController {
    let darkPurple = UIColor(red: 17.0/255.0, green: 29.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    let lightPurple = UIColor(red: 48.0/255.0, green: 59.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    let lightPurple1 = UIColor(red: 75.0/255.0, green: 102.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    let middle =  UIColor(red: 90.0/255.0, green: 132.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    let blue1 =  UIColor(red: 103.0/255.0, green: 159.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    let darkBlue = UIColor(red: 125.0/255.0, green: 203.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    
    // PLUG QUERY DATA IN TO THESE OBEJECTS
    //DATA - query database for average miles driven by a person and save in average miles) on a per day basis - MAKE SURE TO ACCOUNT FOR IF A PERSON HAS MULTIPLE ENTRIES ON A CERTAIN DAY - calculate the total for each day and then divide by the number of days logged
    @IBOutlet weak var yourAvgMiles: UILabel!
    //DATA - query database for "Vehicles miles traveled" in the zipcode of the user of the database and then divide by 365 to get a per day estimate
    @IBOutlet weak var zipAvgMiles: UILabel!
    //DATA - use the average number of miles data/miles per gallon * (0.008887/0898)
    @IBOutlet weak var yourAvgEmissions: UILabel!
    //DATA - get the average transportation carbon per year divide by 2.6 per household
    @IBOutlet weak var zipAvgEmisssions: UILabel!
    //DATA - figure out some formula for rating their car
    @IBOutlet weak var carRating: UILabel!
    //DATA - average gas mileage of all the cars
    @IBOutlet weak var carMileage: UILabel!
    
    var currentUserZipCode = ""
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.view.frame
        view.layer.insertSublayer(newLayer, at: 0)
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        let vehEmissionsRef = ref.child("VehicleEmissions")
        let userRef = ref.child("UserTrips")
        let vehRef = ref.child("UserVehicles")
        let zipRef = ref.child("UserZips")
        let locRef = ref.child("Locations").child("Emissions")
        
        userRef.child(userID!).observeSingleEvent(of: .value, with: { snapshot in
            
            let count = Int(snapshot.childrenCount)
            var sum = 0
            var avgMiles = 0
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
            for child in snapshots {
                let tripsSnap = child.childSnapshot(forPath: ("miles"))
                let data = tripsSnap.value
                let final = data as! String
                sum = sum + Int(final)!
            }
            }
        
            if (count != 0){avgMiles = sum/count}
            self.yourAvgMiles.text = String(avgMiles)
            
            vehRef.child(userID!).observeSingleEvent(of: .value, with: { snapshot4 in
                let vehicleID = snapshot4.value! as? String
                
                vehEmissionsRef.child(vehicleID!).observeSingleEvent(of: .value, with: { snapshot5 in
                    let emissionsDict = snapshot5.value as! NSDictionary
                    let mpg = emissionsDict["mpg"] as? Int
                    let avgEmission = (Double(avgMiles)/Double(mpg!)) * (0.008887/0.989)
                    self.yourAvgEmissions.text = String((round(100*avgEmission)/100))
                    self.carMileage.text = String(describing: mpg!)
                })
            })
        })
        
        zipRef.child(userID!).observeSingleEvent(of: .value, with: { snapshot in
            print("snapshot", snapshot)
            self.currentUserZipCode = (snapshot.value as? String)!
            print ("in my zip code", self.currentUserZipCode)
            
            locRef.child(self.currentUserZipCode).observeSingleEvent(of: .value, with: {snapshot2 in
                
                if (!(snapshot2.value is NSNull)) {
                    let zipDictionary = snapshot2.value as! NSDictionary
                    let miles = zipDictionary["VehicleMiles"] as? Int
                    let zipMiles = String (miles!/1095)
                    self.zipAvgMiles.text = zipMiles
                    let transport = zipDictionary["Transport"] as? Double
                    let thing = transport! / 1095
                    self.zipAvgEmisssions.text = String((round(100*thing)/100))
                }
            })
        })
        carRating.text = "NA"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
