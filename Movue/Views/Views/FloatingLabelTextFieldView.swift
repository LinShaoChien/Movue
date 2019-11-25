//
//  FloatingLabelTextField.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class FloatingLabelTextFieldView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    init(frame: CGRect, placeholderText: String) {
        super.init(frame: frame)
        self.text = placeholderText
        setupSubviews()
    }
    
    convenience init(placeholderText: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), placeholderText: placeholderText)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    var text: String?
    var placeholderLabel = UILabel()
    var textfield = UITextField()
    
    func setupSubviews() {
        
        textfield.borderStyle = .none
        textfield.layer.borderWidth = 2.0
        textfield.layer.borderColor = UIColor.customLightBlue.cgColor
        textfield.layer.backgroundColor = UIColor.clear.cgColor
        textfield.layer.cornerRadius = 8.0
        textfield.layer.masksToBounds = true
        
        textfield.font = UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 14)
        textfield.textColor = UIColor.customDarkBlue
        textfield.defaultTextAttributes.updateValue(1.5, forKey: .kern)
        
        textfield.keyboardType = .emailAddress
        textfield.autocapitalizationType = .none
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 2))
        paddingView.backgroundColor = UIColor.clear
        textfield.leftViewMode = .always
        textfield.leftView = paddingView
        addSubview(textfield)
        
        placeholderLabel.text = "  " + text! + "  "
        placeholderLabel.frame = CGRect(x: 0, y: 0, width: placeholderLabel.intrinsicContentSize.width, height: placeholderLabel.intrinsicContentSize.height)
        placeholderLabel.textColor = UIColor.customDarkBlue
        placeholderLabel.font = UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 14.0)
        placeholderLabel.backgroundColor = UIColor.white
        addSubview(placeholderLabel)
      
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        placeholderLabel.centerYAnchor.constraint(equalTo: textfield.topAnchor).isActive = true
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        textfield.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textfield.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textfield.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }
}
