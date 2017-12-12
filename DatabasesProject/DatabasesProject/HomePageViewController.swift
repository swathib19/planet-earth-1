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
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("UserTrips").child(userID!).queryOrdered(byChild: "miles").queryLimited(toFirst: 1).observeSingleEvent(of: .value, with: { snapshot in
            let newBest = snapshot.value as! NSDictionary
            let keys = newBest.allKeys as! [String]
            let newVal = newBest[keys[0]]
            let bestMiles = String(describing: newVal)
            let things = bestMiles.components(separatedBy: "miles = ")
            let secondHalf: String = things[1]
            let thongs = secondHalf.components(separatedBy: ";")
            let miles: String = thongs[0]
            self.worstMilesDriven.text = miles
        
            self.worstDayEmissions.text = String((Double(miles.trimmingCharacters(in: .whitespacesAndNewlines)))!
                * self.mpgPlaceholder * self.tonsOfC02perGallon)
        })
       
        ref.child("UserTrips").child(userID!).queryOrdered(byChild: "miles").queryLimited(toLast: 1).observeSingleEvent(of: .value, with: { snapshot in
            let newBest = snapshot.value as! NSDictionary
            let keys = newBest.allKeys as! [String]
            let newVal = newBest[keys[0]]
            let bestMiles = String(describing: newVal)
            let things = bestMiles.components(separatedBy: "miles = ")
            let secondHalf: String = things[1]
            let thongs = secondHalf.components(separatedBy: ";")
            let miles: String = thongs[0]
            self.bestMilesDriven.text = miles
            
            self.bestDayEmissions.text = String((Double(miles.trimmingCharacters(in: .whitespacesAndNewlines)))!
                * self.mpgPlaceholder * self.tonsOfC02perGallon)
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
