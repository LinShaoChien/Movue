//
//  SignupViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/19.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    
    // MARK: -Initialize
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, email: String?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.emailFromLoginView = email
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(email: String?) {
        self.init(nibName: nil, bundle: nil, email: email)
    }
    
    // MARK: - Subviews
    var titleLabel = BigDarkBlueTitleLabel(text: "Signing Up")
    var subtitleLabel = SmallLightBlueTitleLabel(text: "Let's build a friendly community together")
    var emailTextfield = FloatingLabelTextFieldView(placeholderText: "Email")
    var passwordTextfield = ContentSecuredFloatingLabelTextField(placeholderText: "Password")
    var signupButton = BigButton(frame: .zero, text: "Sign up")
    var cancelButton = UnderlineTextButton(frame: .zero, text: "Cancel", color: UIColor.customDarkBlue, font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 14)!)
    
    // MARK: - Variables
    var email: String? {
        return emailTextfield.textfield.text
    }
    
    var password: String? {
        return passwordTextfield.textfield.text
    }
    
    var emailFromLoginView: String?
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        addSubviews()
        setupAutolayout()
        setupUIButtonTarget()
        
        self.emailTextfield.textfield.text = emailFromLoginView
    }
    
    // MARK: - Helpers
    func setupUIButtonTarget() {
        cancelButton.addTarget(self, action: #selector(self.dismissViewController(_:)), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(self.pushNicknameViewController(_:)), for: .touchUpInside)
    }
    
    @objc func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func pushNicknameViewController(_ sender: UIButton) {
        
        guard let email = email, email != "" else { return }
        guard let password = password, password != "" else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                // Handle error
                return
            }
            self.dismiss(animated: true) {
                Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                    if let error = error {
                        // Handle error
                        return
                    }
                }
            }
//            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
//                if let error = error {
//                    // Handle error
//                    return
//                }
//                self.dismiss(animated: true, completion: nil)
//            }
        }
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

