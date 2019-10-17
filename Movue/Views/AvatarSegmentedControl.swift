//
//  AvatarSegmentedControl.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AvatarSegmentedControl: UISegmentedControl {
    
    convenience init() {
        self.init(items: ["Color", "Glyph"])
        setup()
    }
    
    func setup() {
        self.backgroundColor = .customLightGrey
        self.selectedSegmentTintColor = UIColor.customDarkBlue
        self.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 14)!
        ], for: .normal)
        self.setWidth(117, forSegmentAt: 0)
        self.setWidth(117, forSegmentAt: 1)
        self.selectedSegmentIndex = 0
    }
}
