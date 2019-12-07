//
//  LoginViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    // MARK: -Variables
    var handle: AuthStateDidChangeListenerHandle!
    var email: String? {
        return emailTextfield.textfield.text
    }
    var password: String? {
        return passwordTextfield.textfield.text
    }
    
    // MARK: - Subviews
    var emailTextfield = FloatingLabelTextFieldView(placeholderText: "Email")
    var passwordTextfield = ContentSecuredFloatingLabelTextField(placeholderText: "Password")
    var titleLabel = BigDarkBlueTitleLabel(text: "Movue")
    var subtitleLabel = SmallLightBlueTitleLabel(text: "What's that movie")
    var loginButton = BigButton(frame: CGRect.zero, text: "Login")
    var signupButton = BigButton(frame: .zero, text: "Sign up")
    var gmailImageButton = ImageButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40), image: UIImage(named: "gmail_logo")!)
    var googleSigninTextButton = TextButton(frame: CGRect(x: 50, y: 50, width: 100, height: 20), text: "Signin with Google", color: UIColor.googleRed, font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 14)!)
    var googleSigninStackView = UIStackView()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
        addSubviews()
        setupUIButtonsTarget()
        setupAutolayout()
        setupGoogleSigninStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // Check if signed in user has create account
            guard let user = user else { return }
            guard let email = user.email else { return }
            print(email)
            print("new")
            let docRef = db.collection("users").document(email)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    self.presentMainTabBarController()
                } else {
                    // Proceed to create user process
                    let viewController = CreateUserNavigationController(email: email)
                    self.present(viewController, animated: true, completion: nil)
                }
            }
            
        }
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.signOut(_:)), name: .didEndCreatingUser, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle)
        // NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - Helpers
    func addSubviews() {
        view.addSubview(emailTextfield)
        view.addSubview(titleLabel)
        view.addSubview(passwordTextfield)
        view.addSubview(subtitleLabel)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        view.addSubview(googleSigninStackView)
        view.addSubview(gmailImageButton)
        view.addSubview(googleSigninTextButton)
        view.addSubview(googleSigninStackView)
    }
    
    func setupUIButtonsTarget() {
        signupButton.addTarget(self, action: #selector(self.presentSignupViewController(_:)), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(self.signIn(_:)), for: .touchUpInside)
        gmailImageButton.addTarget(self, action: #selector(self.signInWithGoogle(_:)), for: .touchUpInside)
        googleSigninTextButton.addTarget(self, action: #selector(self.signInWithGoogle(_:)), for: .touchUpInside)
    }
    
    @objc func presentSignupViewController(_ sender: UIButton!) {
        let viewController = SignupViewController(email: email)
        self.present(viewController, animated: true, completion: nil)
    }
    
//    func presentSignupNavigationController() {
//        let signupNavigationController = SignupNavigationContoller(rootViewController: SignupViewController())
//        self.present(signupNavigationController, animated: true, completion: nil)
//    }
    
    @objc func signIn(_ sender: UIButton!) {
        guard let email = email, email != "" else {
            // Handle Empty email
            return
        }
        guard let password = password, password != "" else {
            // Handle empty password
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                // Handle error
                print(error.localizedDescription)
                return
            }
        }
    }
    
    @objc func signOut(_ sender: Notification) {
        do {
            try Auth.auth().signOut()
            print("did sign out")
        } catch let error {
            // Handle Error
            print(error.localizedDescription)
        }
    }
    
    func presentMainTabBarController() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        self.present(mainTabBarController, animated: true, completion: nil)
    }
    
    @objc func signInWithGoogle(_ sender: UIButton!) {
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.signIn()
    }
    
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
