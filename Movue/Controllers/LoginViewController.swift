//
//  LoginViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Subviews
    var emailTextfield = FloatingLabelTextField(placeholderText: "Email")
    var passwordTextfield = ContentSecuredFloatingLabelTextField(placeholderText: "Password")
    var titleLabel = TitleLabel(frame: .zero, text: "Movue", color: UIColor.customDarkBlue, font: UIFont(name: PASSION_ONE.bold, size: 52)!)
    var subTitleLabel = TitleLabel(frame: .zero, text: "What's that movie", color: UIColor.customLightBlue, font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 14)!)
    var loginButton = BigButton(frame: CGRect.zero, text: "Login")
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(emailTextfield)
        view.addSubview(titleLabel)
        view.addSubview(passwordTextfield)
        view.addSubview(subTitleLabel)
        view.addSubview(loginButton)
        
        setupAutolayout()
        
    }
    
    // MARK: - Helpers
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
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalTo: emailTextfield.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 10).isActive = true
    }

}
