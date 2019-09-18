//
//  LoginViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var emailTextfield = FloatingLabelTextField(placeholderText: "Email")
    var passwordTextfield = ContentSecuredFloatingLabelTextField(placeholderText: "Password")
    var titleLabel = AuthTitleLabel(text: "Movue")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(emailTextfield)
        view.addSubview(titleLabel)
        view.addSubview(passwordTextfield)
        
        setupAutolayout()
        
    }
    
    func setupAutolayout() {
        emailTextfield.translatesAutoresizingMaskIntoConstraints = false
        emailTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextfield.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emailTextfield.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        emailTextfield.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 50).isActive = true
        passwordTextfield.widthAnchor.constraint(equalTo: emailTextfield.widthAnchor).isActive = true
        passwordTextfield.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    }

}
