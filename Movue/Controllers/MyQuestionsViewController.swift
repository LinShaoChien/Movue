//
//  MyQuestionsViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class MyQuestionsViewController: UIViewController {

    // MARK: - Subviews
    let titleView = TitleView(title: "My Questions")
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupAutoLayout()
        self.view.backgroundColor = .white
    }

    func addSubviews() {
        self.view.addSubview(titleView)
    }
    
    func setupAutoLayout() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
    }
}
