//
//  AsKViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AskViewController: UIViewController {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, title: String, subtitle: String, floatingTextfieldTitle: String) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.textField = FloatingLabelTextField(placeholderText: floatingTextfieldTitle)
        self.titleLabel = AskTitleLabel(title: title)
        self.subtitleTextView = AskSubtitleLabel(title: subtitle)
    }
    
    convenience init(title: String, subtitle: String, floatingTextfieldTitle: String) {
        self.init(nibName: nil, bundle: nil, title: title, subtitle: subtitle, floatingTextfieldTitle: floatingTextfieldTitle)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var textField: FloatingLabelTextField!
    var titleLabel: AskTitleLabel!
    var subtitleTextView: AskSubtitleLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        self.view.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        setupAutoLayout()
    }

    func addSubviews() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(textField)
        self.view.addSubview(subtitleTextView)
    }
    
    func setupAutoLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 168).isActive = true
        
        subtitleTextView.translatesAutoresizingMaskIntoConstraints = false
        subtitleTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
        subtitleTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 252 / 375).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: subtitleTextView.bottomAnchor, constant: 20).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 284 / 375).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
}
