//
//  SignupNavigationContoller.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/20.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateUserNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    convenience init(email: String) {
        self.init(rootViewController: NicknameViewController())
        self.userEmail = email
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
//
//    var signupViewController: SignupViewController? {
//        return self.viewControllers.first as? SignupViewController
//    }
    
    var nameViewController: NicknameViewController? {
        return self.viewControllers.first as? NicknameViewController
    }
    
    var nicknameViewController = NicknameViewController()
    var avatarViewController = AvatarViewController()
    
    var userEmail: String?
    var userNickname: String?
    var userAvatarColor: Int?
    var userAvatarGlyph: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentationController?.delegate = self
        nicknameViewController.delegate = self
        avatarViewController.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameViewController?.delegate = self
        // signupViewController?.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        do {
//            try Auth.auth().signOut()
//            print("did sign out")
//        } catch let error {
//            print(error.localizedDescription)
//        }
        NotificationCenter.default.post(name: .didEndCreatingUser, object: nil)
    }
    
    func setup() {
        self.isNavigationBarHidden = true
    }
}

//extension SignupNavigationContoller: SignupViewControllerDelegate {
//    
//    func willPushNicknameViewController(_ viewController: SignupViewController) {
//        self.userEmail = viewController.email
//        self.pushViewController(nicknameViewController, animated: true)
//    }
//    
//}

extension CreateUserNavigationController: NicknameViewControllerDelegate {
    
    func willPushAvatarViewController(_ viewController: NicknameViewController) {
        self.userNickname = viewController.nickname
        self.pushViewController(avatarViewController, animated: true)
    }
    
}

extension CreateUserNavigationController: AvatarViewControllerDelegate {
    
    func willDismissAvatarViewController(_ viewController: AvatarViewController) {
        self.userAvatarColor = viewController.avatarColorCollectionView.indexPathsForSelectedItems![0].item
        self.userAvatarGlyph = viewController.avatarGlyphCollectionView.indexPathsForSelectedItems![0].item
        guard let email = userEmail, let name = userNickname, let avatarColor = userAvatarColor, let avatarGlyph = userAvatarGlyph else {
            // Handle error
            return
        }
        db.collection("users").document(email).setData([
            "name": name,
            "email": email,
            "avatarColor": avatarColor,
            "avatarGlyph": avatarGlyph
        ]) { (error) in
            if let error = error {
                // Handle Error
                return
            }
            let viewController = MainTabBarController()
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
}

extension CreateUserNavigationController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            do {
                try Auth.auth().signOut()
                print("did sign out")
            } catch let error {
                print(error.localizedDescription)
            }
    }
}
