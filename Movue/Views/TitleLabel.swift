//
//  AuthTitleLabel.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/18.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
    init(frame: CGRect, text: String, color: UIColor, font: UIFont) {
        super.init(frame: frame)
        self.titleText = text
        self.titleTextColor = color
        self.titleFont = font
        setupAttribute()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAttribute()
    }
    
    var titleText: String?
    var titleTextColor: UIColor?
    var titleFont: UIFont?
    
    func setupAttribute() {
        self.text = titleText
        self.textColor = titleTextColor
        self.font = titleFont
    }
    
}
