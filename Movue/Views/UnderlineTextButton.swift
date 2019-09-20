//
//  UnderlineTextButton.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/19.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class UnderlineTextButton: TextButton {
    
    override init(frame: CGRect, text: String, color: UIColor, font: UIFont) {
        super.init(frame: frame, text: text, color: color, font: font)
        setupUnderline()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUnderline()
    }
    
    func setupUnderline() {
        let underline = UIView(frame: .zero)
        self.addSubview(underline)
        underline.backgroundColor = self.titleColor
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.heightAnchor.constraint(equalToConstant: 1).isActive = true
        underline.widthAnchor.constraint(equalTo: self.titleLabel!.widthAnchor).isActive = true
        underline.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true
        underline.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
