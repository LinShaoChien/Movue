//
//  SignupNavigationContoller.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/20.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class SignupNavigationContoller: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    convenience init() {
        self.init(rootViewController: SignupViewController())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var signupViewController: SignupViewController? {
        return self.viewControllers.first as? SignupViewController
    }
    
    var nicknameViewController = NicknameViewController()
    
    var userEmail: String?
    var userPassword: String?
    var userNickname: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameViewController.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signupViewController?.delegate = self
    }
    
    func setup() {
        self.isNavigationBarHidden = true
    }
}

extension SignupNavigationContoller: SignupViewControllerDelegate {
    
    func willPushNicknameViewController(_ viewController: SignupViewController) {
        self.userEmail = viewController.email
        self.userPassword = viewController.password
        self.pushViewController(nicknameViewController, animated: true)
    }
    
}

extension SignupNavigationContoller: NicknameViewControllerDelegate {
    
    func willPushAvatarViewController(_ viewController: NicknameViewController) {
        self.userNickname = viewController.nickname
    }
    
}
