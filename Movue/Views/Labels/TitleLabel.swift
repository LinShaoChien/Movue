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
    
    convenience init() {
        self.init(frame: .zero, text: "", color: UIColor.clear, font: UIFont())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAttribute()
    }
    
    var titleText: String?
    var titleTextColor: UIColor?
    var titleFont: UIFont?
    
    func setupAttribute() {
        self.numberOfLines = 2
        self.lineBreakMode = .byTruncatingTail
        self.attributedText = NSAttributedString(string: titleText!, attributes: [
            NSAttributedString.Key.foregroundColor: titleTextColor!,
            NSAttributedString.Key.font: titleFont!,
        ])
    }
    
}
