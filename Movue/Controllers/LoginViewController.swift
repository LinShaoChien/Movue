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
    var signupButton = BigButton(frame: .zero, text: "Sign up")
    var gmailImageButton = ImageButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40), image: UIImage(named: "gmail_logo")!)
    var googleSigninTextButton = TextButton(frame: CGRect(x: 50, y: 50, width: 100, height: 20), text: "Signin with Google", color: UIColor.googleRed, font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 14)!)
    var googleSigninStackView = UIStackView()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(emailTextfield)
        view.addSubview(titleLabel)
        view.addSubview(passwordTextfield)
        view.addSubview(subTitleLabel)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        view.addSubview(googleSigninStackView)
        view.addSubview(gmailImageButton)
        view.addSubview(googleSigninTextButton)
        view.addSubview(googleSigninStackView)
        setupAutolayout()
        setupGoogleSigninStackView()
        
        
    }
    
    // MARK: - Helpers
    func setupGoogleSigninStackView() {
        googleSigninTextButton.translatesAutoresizingMaskIntoConstraints = false
        googleSigninTextButton.widthAnchor.constraint(equalToConstant: googleSigninTextButton.intrinsicContentSize.width).isActive = true
        googleSigninTextButton.heightAnchor.constraint(equalToConstant: googleSigninTextButton.intrinsicContentSize.height).isActive = true
        
        gmailImageButton.translatesAutoresizingMaskIntoConstraints = false
        gmailImageButton.heightAnchor.constraint(equalTo: googleSigninTextButton.heightAnchor).isActive = true
        gmailImageButton.widthAnchor.constraint(equalToConstant: gmailImageButton.frame.height).isActive = true
        
        googleSigninStackView.axis = .horizontal
        googleSigninStackView.spacing = 10
        googleSigninStackView.distribution = .equalSpacing
        googleSigninStackView.alignment = .center

        googleSigninStackView.addArrangedSubview(gmailImageButton)
        googleSigninStackView.addArrangedSubview(googleSigninTextButton)
    }
    
    func setupAutolayout() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if UIScreen.main.bounds.height == 667 {
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        } else {
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        }
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        
        emailTextfield.translatesAutoresizingMaskIntoConstraints = false
        emailTextfield.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 48).isActive = true
        emailTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 284 / 375).isActive = true
        emailTextfield.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 23).isActive = true
        passwordTextfield.widthAnchor.constraint(equalTo: emailTextfield.widthAnchor).isActive = true
        passwordTextfield.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor).isActive = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalTo: emailTextfield.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 40).isActive = true
        
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.widthAnchor.constraint(equalTo: emailTextfield.widthAnchor).isActive = true
        signupButton.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12).isActive = true
        
        
        googleSigninStackView.translatesAutoresizingMaskIntoConstraints = false
        googleSigninStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        googleSigninStackView.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 26).isActive = true
    }

}
