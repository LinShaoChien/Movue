//
//  BlueSwitch.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/25.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class BlueSwitch: UISwitch {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        self.onTintColor = .customLightBlue
        self.tintColor = .customLightGrey
    }
}
