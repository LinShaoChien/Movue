//
//  AskPlotViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/25.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AskPlotViewController: AskViewController {

    convenience init(title: String, subtitle: String, floatingTitleTextView: FloatingTitleTextView) {
        self.init(nibName: nil, bundle: nil, title: title, subtitle: subtitle, floatingTextfieldTitle: nil, firstInstructionView: nil, secondInstructionView: nil)
        self.floatingTitleTextView = floatingTitleTextView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        self.setupAutoLayout()
    }

    var floatingTitleTextView: FloatingTitleTextView!

    override func addSubviews() {
        super.addSubviews()
        self.view.addSubview(floatingTitleTextView)
    }
    
    override func setupAutoLayout() {
        super.setupAutoLayout()
        floatingTitleTextView.translatesAutoresizingMaskIntoConstraints = false
        floatingTitleTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        floatingTitleTextView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20).isActive = true
        floatingTitleTextView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 284 / 375).isActive = true
        floatingTitleTextView.heightAnchor.constraint(equalToConstant: 188).isActive = true
    }
}
