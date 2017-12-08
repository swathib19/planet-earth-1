//
//  CalendarViewCell.swift
//  DatabasesProject
//
//  Created by Tahia Emran on 11/9/17.
//  Copyright © 2017 Tahia Emran. All rights reserved.
//

import UIKit

class CalendarViewCell: UICollectionViewCell {
    var label: UITextField!
    convenience init(){
        self.init()
        self.label = UITextField()
        self.label.backgroundColor = UIColor.blue
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.label = .none
        self.contentView.subviews.forEach({$0.removeFromSuperview()})
    }
}
