//
//  SignOutViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/12/6.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignOutViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle!
    var signOutButton: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Out", for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(signOutButton)
        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        signOutButton.addTarget(self, action: #selector(self.signOut(_:)), for: .touchUpInside)
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

}
