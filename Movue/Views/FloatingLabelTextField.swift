//
//  FloatingLabelTextField.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

// @IBDesignable
class FloatingLabelTextField: UIView {
    
    init(frame: CGRect, placeholderText: String) {
        super.init(frame: frame)
        self.text = placeholderText
        
        updateView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        updateView()
    }
    
    var text: String?
    
    func updateView() {
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = text
        placeholderLabel.frame = CGRect(x: 0, y: 0, width: placeholderLabel.intrinsicContentSize.width, height: placeholderLabel.intrinsicContentSize.height)
        placeholderLabel.textColor = UIColor.customLightBlue
        placeholderLabel.font = UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 14.0)
        addSubview(placeholderLabel)
        
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textfield.borderStyle = .none
        textfield.layer.borderWidth = 2.0
        textfield.layer.backgroundColor = UIColor.clear.cgColor
        textfield.layer.cornerRadius = 5.0
        textfield.layer.masksToBounds = true
        addSubview(textfield)
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        textfield.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textfield.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textfield.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
