//
//  LoginViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var floatingLabel = FloatingLabelTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 50), placeholderText: "Email")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        view.addSubview(floatingLabel)
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        floatingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        floatingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }

}
