//
//  EditButton.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/6.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class EditButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.setAttributedTitle(NSAttributedString(string: "Edit", attributes: [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 12)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]), for: .normal)
        self.backgroundColor = .customLightBlue
        self.layer.cornerRadius = 6
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
