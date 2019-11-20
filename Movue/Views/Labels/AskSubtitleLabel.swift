//
//  AskSubtitleLabel.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AskSubtitleLabel: UILabel {

    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        self.titleText = title
        setup()
    }
    
    convenience init(title: String) {
        self.init(frame: .zero, title: title)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var titleText: String?

    func setup() {
        self.attributedText = NSAttributedString(string: titleText!, attributes: [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 14)!,
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue
        ])
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
    }

}
