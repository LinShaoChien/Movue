//
//  SignOutViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/12/6.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignOutViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle!
    var signOutButton: BigButton! = {
        let button = BigButton(frame: .zero, text: "Sign out")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var avatarView: AvatarView = AvatarView()
    
    var label = TitleLabel(frame: .zero, text: "", color: .customLightBlue, font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 24)!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(signOutButton)
        view.addSubview(avatarView)
        view.addSubview(label)
        
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 176).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: 176).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 40).isActive = true
        
        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40).isActive = true
        signOutButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        signOutButton.addTarget(self, action: #selector(self.signOut(_:)), for: .touchUpInside)
        
        getUserProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user == nil {
                self.dismiss(animated: true) {
                    NotificationCenter.default.post(name: .didLogOut, object: nil)
                }
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    @objc func signOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func getUserProfile() {
        db.collection("users").document(Auth.auth().currentUser!.email!).getDocument { (document, error) in
            if let error = error {
                let alert = UIAlertController.errorAlert(withTitle: "Can't get user profile", andError: error)
                self.present(alert, animated: true, completion: nil)
                return
            } else if let document = document {
                let data = document.data()!
                let email = document.documentID
                let color = data["avatarColor"] as! Int
                let glyph = data["avatarGlyph"] as! Int
                self.avatarView = AvatarView(frame: .zero, color: UIColor.AvatarColors[color], image: UIImage.avatarGlyphs[glyph]!)
                self.label.attributedText = NSAttributedString(string: email, attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue,
                    NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 24)!
                ])
            }
        }
    }

}
