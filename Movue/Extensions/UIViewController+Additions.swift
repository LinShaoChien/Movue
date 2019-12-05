//
//  UIView+Additions.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/12/5.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addDismissOnTap() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
