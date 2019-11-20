//
//  RoundedLabel.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/26.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class RoundedLabel: UILabel {
    
    init(frame: CGRect, color: UIColor, text: String) {
        super.init(frame: frame)
        self.backcolor = color
        self.titleText = text
        setup()
    }

    convenience init(color: UIColor, text: String) {
        self.init(frame: .zero, color: color, text: text)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var backcolor: UIColor!
    var titleText: String!
    
    func setup() {
        self.backgroundColor = backcolor
        self.attributedText = NSAttributedString(string: titleText, attributes: [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 10)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: NSNumber(value: 0.4)
        ])
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        self.textAlignment = .center
    }
}
