//
//  InstructionView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class InstructionView: UIView {

    init(frame: CGRect, minorTitle: String, majorTitle: String, titleColor: UIColor) {
        super.init(frame: frame)
        self.minorTitle = minorTitle
        self.majorTitle = majorTitle
        self.titleColor = titleColor
        setup()
        setupAutolayout()
    }
    
    convenience init(minorTitle: String, majorTitle: String, titleColor: UIColor) {
        self.init(frame: .zero, minorTitle: minorTitle, majorTitle: majorTitle, titleColor: titleColor)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupAutolayout()
    }
    
    var minorTitle: String!
    var majorTitle: String!
    var titleColor: UIColor!
    
    var minorTitleLabel = UILabel()
    var majorTitleLabel = UILabel()
    
    func setup() {
        addSubview(minorTitleLabel)
        addSubview(majorTitleLabel)
        minorTitleLabel.attributedText = NSAttributedString(string: minorTitle, attributes: [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 10)!,
            NSAttributedString.Key.foregroundColor: titleColor!
        ])
        
        majorTitleLabel.attributedText = NSAttributedString(string: majorTitle, attributes: [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 14)!,
            NSAttributedString.Key.foregroundColor: titleColor!
        ])
    }
    
    func setupAutolayout() {
        minorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        minorTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        minorTitleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        majorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        majorTitleLabel.topAnchor.constraint(equalTo: minorTitleLabel.bottomAnchor, constant: 5).isActive = true
        majorTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        majorTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
