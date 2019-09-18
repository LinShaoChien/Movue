//
//  FloatingLabelPasswordTextField.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/18.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class ContentSecuredFloatingLabelTextField: FloatingLabelTextField {
    override init(frame: CGRect, placeholderText: String) {
        super.init(frame: frame, placeholderText: placeholderText)
        setupTextfield()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextfield()
    }
    
    convenience init(placeholderText: String) {
        self.init(frame: CGRect.zero, placeholderText: placeholderText)
    }
    
    func setupTextfield() {
        self.textfield.keyboardType = .default
        self.textfield.isSecureTextEntry = true
    }
}
