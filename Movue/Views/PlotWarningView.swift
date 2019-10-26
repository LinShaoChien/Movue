//
//  PlotWarningView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/25.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class PlotWarningView: UIView {
    
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
    
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()

    func setup() {
        titleLabel.attributedText = NSAttributedString(string: "Ending Spoiler", attributes: [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 15)!,
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue
        ])
        self.addSubview(titleLabel)
        subtitleLabel.attributedText = NSAttributedString(string: "Turn on if you will give out the ending", attributes: [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 10)!,
            NSAttributedString.Key.foregroundColor: UIColor.customOrange
        ])
        self.addSubview(subtitleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 3).isActive = true
    }
}
