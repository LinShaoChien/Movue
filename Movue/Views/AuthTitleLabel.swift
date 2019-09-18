//
//  AuthTitleLabel.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/18.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AuthTitleLabel: UILabel {
    
    init(frame: CGRect, text: String) {
        super.init(frame: frame)
        self.titleText = text
        setupAttribute()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(text: String) {
        self.init(frame: CGRect.zero, text: text)
        setupAttribute()
    }
    
    var titleText: String?
    
    func setupAttribute() {
        self.text = titleText
        self.textColor = UIColor.customDarkBlue
        self.font = UIFont(name: PASSION_ONE.bold, size: 52.0)
    }
    
}
