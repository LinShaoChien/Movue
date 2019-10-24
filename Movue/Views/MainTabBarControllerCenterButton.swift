//
//  MainTabBarControllerCenterButton.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/23.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class MainTabBarControllerCenterButton: UIButton {
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 73, height: 73))
        setup()
    }

    func setup() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 7
        self.layer.borderColor = UIColor.customLightBlue.cgColor
        self.backgroundColor = .white
        self.setAttributedTitle(NSAttributedString(string: "Ask!", attributes: [
            NSAttributedString.Key.font: UIFont(name: PASSION_ONE.bold, size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor.customLightBlue
        ]), for: .normal)
    }
}
