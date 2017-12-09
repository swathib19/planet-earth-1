//
//  StatsPageViewController.swift
//  DatabasesProject
//
//  Created by Tahia Emran on 12/7/17.
//  Copyright © 2017 Tahia Emran. All rights reserved.
//

import UIKit

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
    
    //MAKE THE TILE ON THE LEFT TURN RED OR GREEN BASED ON IF THEY ARE ABOVE OR BELOW THE AVERAGE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.view.frame
        view.layer.insertSublayer(newLayer, at: 0)
        // Do any additional setup after loading the view.
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
