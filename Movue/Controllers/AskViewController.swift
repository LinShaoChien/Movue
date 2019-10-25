//
//  AsKViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AskViewController: UIViewController {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, title: String, subtitle: String, floatingTextfieldTitle: String, firstInstructionView: InstructionView?, secondInstructionView: InstructionView?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.textField = FloatingLabelTextField(placeholderText: floatingTextfieldTitle)
        self.titleLabel = AskTitleLabel(title: title)
        self.subtitleTextView = AskSubtitleLabel(title: subtitle)
        self.firstInstructionView = firstInstructionView
        self.secondInstructionView = secondInstructionView
    }
    
    convenience init(title: String, subtitle: String, floatingTextfieldTitle: String, firstInstructionView: InstructionView?, secondInstructionView: InstructionView?) {
        self.init(nibName: nil, bundle: nil, title: title, subtitle: subtitle, floatingTextfieldTitle: floatingTextfieldTitle, firstInstructionView: firstInstructionView, secondInstructionView: secondInstructionView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var textField: FloatingLabelTextField!
    var titleLabel: AskTitleLabel!
    var subtitleTextView: AskSubtitleLabel!
    var firstInstructionView: InstructionView?
    var secondInstructionView: InstructionView?
    
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
        guard let firstInstructionView = firstInstructionView else { return }
        self.view.addSubview(firstInstructionView)
        guard let secondInstructionView = secondInstructionView else { return }
        self.view.addSubview(secondInstructionView)
    }
    
    func setupAutoLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 130).isActive = true
        
        subtitleTextView.translatesAutoresizingMaskIntoConstraints = false
        subtitleTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
        subtitleTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 252 / 375).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: subtitleTextView.bottomAnchor, constant: 20).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 284 / 375).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        guard let firstInstructionView = firstInstructionView else { return }
        firstInstructionView.translatesAutoresizingMaskIntoConstraints = false
        firstInstructionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstInstructionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30).isActive = true
        firstInstructionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 252 / 375).isActive = true
        
        guard let secondInstructionView = secondInstructionView else { return }
        secondInstructionView.translatesAutoresizingMaskIntoConstraints = false
        secondInstructionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondInstructionView.topAnchor.constraint(equalTo: firstInstructionView.bottomAnchor, constant: 20).isActive = true
        secondInstructionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 252 / 375).isActive = true
    }
}
