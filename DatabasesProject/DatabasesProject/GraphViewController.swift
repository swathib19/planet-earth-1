//
//  GraphViewController.swift
//  DatabasesProject
//
//  Created by Rachel Bransom on 12/9/17.
//  Copyright © 2017 Tahia Emran. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
   // @IBOutlet weak var graphView: GraphView!
//    @IBOutlet weak var averageWaterDrunk: UILabel!
//    @IBOutlet weak var maxLabel: UILabel!
//    @IBOutlet weak var stackView: UIStackView!
    
    var graph: GraphContainer!
    
    let darkPurple = UIColor(red: 17.0/255.0, green: 29.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    let lightPurple = UIColor(red: 48.0/255.0, green: 59.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    let lightPurple1 = UIColor(red: 75.0/255.0, green: 102.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    let middle =  UIColor(red: 90.0/255.0, green: 132.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    let blue1 =  UIColor(red: 103.0/255.0, green: 159.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    let darkBlue = UIColor(red: 125.0/255.0, green: 203.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.view.frame
        view.layer.insertSublayer(newLayer, at: 0)
     
        
        self.graph = GraphContainer()
        self.view.addSubview(self.graph)
        self.graph.height(h: 300)
        self.graph.width(w: 300)
        self.graph.pinTop(v: self.view, o: 100)
        self.graph.pinLeft(v: self.view, o: 50)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func setupGraphDisplay() {
//
//      //  let maxDayIndex = stackView.arrangedSubviews.count - 1
//
//        //  1 - replace last day with today's actual data
//        //graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
//        //2 - indicate that the graph needs to be redrawn
//        graphView.setNeedsDisplay()
//      //  maxLabel.text = "\(graphView.graphPoints.max()!)"
//
//        //  3 - calculate average from graphPoints
//        let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
//     //   averageWaterDrunk.text = "\(average)"
//
//        // 4 - setup date formatter and calendar
//        let today = Date()
//        let calendar = Calendar.current
//
//        let formatter = DateFormatter()
//        formatter.setLocalizedDateFormatFromTemplate("EEEEE")
//
//        // 5 - set up the day name labels with correct days
//        for i in 0...maxDayIndex {
//            if let date = calendar.date(byAdding: .day, value: -i, to: today),
//                let label = stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
//                label.text = formatter.string(from: date)
//            }
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
