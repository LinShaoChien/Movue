//
//  TextButton.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/20.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class TextButton: UIButton {

    init(frame: CGRect, text: String, color: UIColor, font: UIFont) {
        super.init(frame: frame)
        self.titleText = text
        self.titleColor = color
        self.titleFont = font
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    var titleText: String?
    var titleColor: UIColor?
    var titleFont: UIFont?
    
    func setup() {
        self.setTitle(titleText, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = titleFont
    }
}
