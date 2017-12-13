//
//  HomePageViewController.swift
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
import Foundation

class HomePageViewController: UIViewController {
    let darkPurple = UIColor(red: 17.0/255.0, green: 29.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    let lightPurple = UIColor(red: 48.0/255.0, green: 59.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    let lightPurple1 = UIColor(red: 75.0/255.0, green: 102.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    let middle =  UIColor(red: 90.0/255.0, green: 132.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    let blue1 =  UIColor(red: 103.0/255.0, green: 159.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    let darkBlue = UIColor(red: 125.0/255.0, green: 203.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    
    var ref: DatabaseReference!
    
    let tonsOfC02perGallon = 0.008887/0.989
    let mpgPlaceholder = 20.0
    var worst: String = ""
    var best: String = ""
    var milesdouble =  0.0
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var bestDayMiles: UILabel!
    @IBOutlet weak var worstDayMiles: UILabel!
    
    @IBOutlet weak var worstDay: UILabel!
    @IBOutlet weak var bestDay: UILabel!
    
    @IBOutlet weak var bestDayEmissions: UILabel!
    @IBOutlet weak var worstDayEmissions: UILabel!
    
    
    @IBOutlet weak var worstMilesDriven: UILabel!
    @IBOutlet weak var bestMilesDriven: UILabel!
    
    var holder: Double = 0.0
    
    // DATA uncomment the lines below to fill in the best/worst day emissions
    // var mpg: Int = query that gives mpg for car driven on best day
    // use this formula to calculate emissions of a car: (0.008887/0.989) * (miles driven)/(miles per gallon)
    // DATA: set the best day emissions label (attributed text) with above results - turn it white with turnTextWhite
    // DATA: set the worst day emissions label (attribuetd text) with above results - turn it white with turnTextWhite (same equation as above)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.view.frame
        view.layer.insertSublayer(newLayer, at: 0)

        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("UserTrips").child(userID!).observe(.value, with: { snapshot in
            
            print("snapshot", snapshot)
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                
                var min = 10000
                var max = -1
                
                for child in snapshots {
                    let tripsSnap = child.childSnapshot(forPath: ("miles"))
                    let data = tripsSnap.value
                    print("data:", data)
    
                    let boop = data as! String
                    let final = Int(boop)!
                    
                    if (final < min) {
                        min = final
                    }
                    if (final > max) {
                        max = final
                    }
                }
                
                if (min == 10000){min = 0}
                if (max == -1){max = 0}
                self.bestMilesDriven.text = String(describing: min)
                self.worstMilesDriven.text = String(describing: max)
                let bestEmissions = (Double(min) / self.mpgPlaceholder) * self.tonsOfC02perGallon
                self.bestDayEmissions.text = String((round(100*bestEmissions)/100))
                let worstEmissions = (Double(max) / self.mpgPlaceholder) * self.tonsOfC02perGallon
                self.worstDayEmissions.text = String((round(100*worstEmissions)/100))
            }
        })
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // FUNCTION TO TURN TEXT WHITE
    fileprivate func turnTextWhite(text:String) -> NSAttributedString{
        let attrPlaceholder = NSMutableAttributedString(string: text)
        attrPlaceholder.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray, range: NSMakeRange(0, text.count))
        let placholderTxt = NSAttributedString(attributedString: attrPlaceholder)
        return placholderTxt
    }
    
    fileprivate func getPlaceHolderText(text:String) -> NSAttributedString{
        let attrPlaceholder = NSMutableAttributedString(string: text)
        attrPlaceholder.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray, range: NSMakeRange(0, text.count))
        let placholderTxt = NSAttributedString(attributedString: attrPlaceholder)
        return placholderTxt
    }

}
