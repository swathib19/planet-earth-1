//
//  GraphContainer.swift
//  DatabasesProject
//
//  Created by Rachel Bransom on 12/9/17.
//  Copyright © 2017 Tahia Emran. All rights reserved.
//

import UIKit

class GraphContainer: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let darkPurple = UIColor(red: 17.0/255.0, green: 29.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    let lightPurple = UIColor(red: 48.0/255.0, green: 59.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    let lightPurple1 = UIColor(red: 75.0/255.0, green: 102.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    let middle =  UIColor(red: 90.0/255.0, green: 132.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    let blue1 =  UIColor(red: 103.0/255.0, green: 159.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    let darkBlue = UIColor(red: 125.0/255.0, green: 203.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    
    
    var graph: GraphView!
    
    convenience init(){
        self.init(frame: CGRect.zero)
        self.graph = GraphView()

        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.frame
        self.layer.insertSublayer(newLayer, at: 0)
        
        self.addSubview(self.graph)
        self.graph.width(w: 300)
        self.graph.height(h: 350)
        self.graph.pinLeftRight(v: self, o: 20)
        self.graph.pinTopBottom(v: self)
        
    }
    
    

}
