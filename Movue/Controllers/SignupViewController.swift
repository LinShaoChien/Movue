//
//  SignupViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/19.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    // MARK: - Subviews
    var titleLabel = BigDarkBlueTitleLabel(text: "Signing Up")
    var subtitleLabel = SmallLightBlueTitleLabel(text: "Let's build a friendly community together")
    var emailTextfield = FloatingLabelTextField(placeholderText: "Email")
    var passwordTextfield = ContentSecuredFloatingLabelTextField(placeholderText: "Password")
    var signupButton = BigButton(frame: .zero, text: "Sign up")
    var cancelButton = UnderlineTextButton(frame: .zero, text: "Cancel", color: UIColor.customDarkBlue, font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 14)!)
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        addSubviews()
        setupAutolayout()
        setupUIButtonTarget()
    }
    
    // MARK: - Helpers
    func setupUIButtonTarget() {
        cancelButton.addTarget(self, action: #selector(self.dismissViewController(_:)), for: .touchUpInside)
    }
    
    @objc func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(emailTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(signupButton)
        view.addSubview(cancelButton)
    }
    
    func setupAutolayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if UIScreen.main.bounds.height == 667 {
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        } else {
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        }
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        
        emailTextfield.translatesAutoresizingMaskIntoConstraints = false
        emailTextfield.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 48).isActive = true
        emailTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 284 / 375).isActive = true
        emailTextfield.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 23).isActive = true
        passwordTextfield.widthAnchor.constraint(equalTo: emailTextfield.widthAnchor).isActive = true
        passwordTextfield.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor).isActive = true
        
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.widthAnchor.constraint(equalTo: emailTextfield.widthAnchor).isActive = true
        signupButton.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 40).isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 13).isActive = true
    }
}
