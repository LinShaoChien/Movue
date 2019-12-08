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
        self.floatingTitleTextView.textView.returnKeyType = .next
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        self.setupAutoLayout()
    }

    var floatingTitleTextView: FloatingTitleTextView!
    var plotWarningView = PlotWarningView()
    var blueSwitch = BlueSwitch()

    override func addSubviews() {
        super.addSubviews()
        self.view.addSubview(floatingTitleTextView)
        self.view.addSubview(plotWarningView)
        self.view.addSubview(blueSwitch)
    }
    
    override func setupAutoLayout() {
        super.setupAutoLayout()
        floatingTitleTextView.translatesAutoresizingMaskIntoConstraints = false
        floatingTitleTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        floatingTitleTextView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20).isActive = true
        floatingTitleTextView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 284 / 375).isActive = true
        floatingTitleTextView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        
        blueSwitch.translatesAutoresizingMaskIntoConstraints = false
        blueSwitch.leadingAnchor.constraint(equalTo: floatingTitleTextView.leadingAnchor, constant: 15).isActive = true
        blueSwitch.topAnchor.constraint(equalTo: floatingTitleTextView.bottomAnchor, constant: 25).isActive = true
        
        plotWarningView.translatesAutoresizingMaskIntoConstraints = false
        plotWarningView.centerYAnchor.constraint(equalTo: blueSwitch.centerYAnchor).isActive = true
        plotWarningView.leadingAnchor.constraint(equalTo: blueSwitch.trailingAnchor, constant: 15).isActive = true
    }
}
