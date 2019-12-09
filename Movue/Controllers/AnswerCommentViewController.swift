//
//  AnswerCommentViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/26.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AnswerCommentViewController: UIViewController {

    // MARK: -Variables
    var comment: String! {
        let comment = textView.textView.text
        return comment
    }
    
    // MARK: -Subviews
    var titleLabel: UILabel! = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Write Comment", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customLightBlue,
            NSAttributedString.Key.font: UIFont(name: PASSION_ONE.bold, size: 25)!
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var textView: FloatingTitleTextView! = {
        let view = FloatingTitleTextView(title: "Comment")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var doneButton: BigButton! = {
        let button = BigButton(frame: .zero, text: "Done")
        button.addTarget(self, action: #selector(dismissSelf(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: -Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addDismissOnTap()
        setupView()
        setupAutolayout()
    }

    // MARK: -Helpers
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(textView)
        view.addSubview(doneButton)
    }
    
    func setupAutolayout() {
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        
        textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        textView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 284/375).isActive = true
        
        doneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 284 / 375).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    @objc func dismissSelf(_ sender: UIButton) {
        let navigationController = self.navigationController as! AnswerNavigationController
        navigationController.comment = self.comment
        navigationController.createPostComment()
        dismiss(animated: true, completion: nil)
    }
}
