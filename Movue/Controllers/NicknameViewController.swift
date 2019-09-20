//
//  NicknameViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/20.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class NicknameViewController: UIViewController {

    var subtitleLabel = SmallLightBlueTitleLabel(text: "Please tell us your nickname")
    var nicknameTextfield = FloatingLabelTextField(placeholderText: "Nickname")
    var confirmButton = BigButton(frame: .zero, text: "That's me")
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addSubviews()
        setupAutolayout()
    }
    
    // MARK: - Helpers
    func addSubviews() {
        view.addSubview(subtitleLabel)
        view.addSubview(nicknameTextfield)
        view.addSubview(confirmButton)
    }

    func setupAutolayout() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
        nicknameTextfield.translatesAutoresizingMaskIntoConstraints = false
        nicknameTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nicknameTextfield.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20).isActive = true
        nicknameTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 284 / 375).isActive = true
        nicknameTextfield.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.widthAnchor.constraint(equalTo: nicknameTextfield.widthAnchor).isActive = true
        confirmButton.heightAnchor.constraint(equalTo: nicknameTextfield.heightAnchor).isActive = true
        confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmButton.topAnchor.constraint(equalTo: nicknameTextfield.bottomAnchor, constant: 40).isActive = true
        
    }
}
