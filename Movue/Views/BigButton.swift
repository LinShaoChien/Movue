//
//  BigButton.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/18.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class BigButton: UIButton {
    
    init(frame: CGRect, text: String) {
        super.init(frame: frame)
        self.titleText = text
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var titleText: String?
    
    func setup() {
        self.setTitle(titleText, for: .normal)
        self.backgroundColor = UIColor.customDarkBlue
        self.layer.cornerRadius = 8
        self.titleLabel?.textColor = UIColor.white
        self.titleLabel?.font = UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 14)
    }
}
