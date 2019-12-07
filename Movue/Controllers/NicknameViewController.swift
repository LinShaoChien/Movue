//
//  NicknameViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/20.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class NicknameViewController: UIViewController {

    // MARK: - Subviews
    var subtitleLabel = SmallLightBlueTitleLabel(text: "Please tell us your nickname")
    var nicknameTextfield = FloatingLabelTextFieldView(placeholderText: "Nickname")
    var confirmButton = BigButton(frame: .zero, text: "That's me")
    
    weak var delegate: NicknameViewControllerDelegate?
    var nickname: String? {
        return nicknameTextfield.textfield.text
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addSubviews()
        setupAutolayout()
        addButtonTarget()
    }
    
    // MARK: - Helpers
    func addSubviews() {
        view.addSubview(subtitleLabel)
        view.addSubview(nicknameTextfield)
        view.addSubview(confirmButton)
    }
    
    func addButtonTarget() {
        confirmButton.addTarget(self, action: #selector(pushAvatarViewController(_:)), for: .touchUpInside)
    }
    
    @objc func pushAvatarViewController(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        do {
            guard nickname != nil && nickname != "" else {
                throw TextfieldError.emptyNickname
            }
        } catch let error {
            switch error {
            case TextfieldError.emptyNickname:
                let alert = UIAlertController.errorAlert(withTitle: "Empty nickname", andMessage: "Please enter your nickname")
                self.present(alert, animated: true, completion: nil)
            default:
                return
            }
        }
        delegate.willPushAvatarViewController(self)
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

protocol NicknameViewControllerDelegate: AnyObject {
    func willPushAvatarViewController(_ viewController: NicknameViewController)
}
