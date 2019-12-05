//
//  MyQuestionNavigationsController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/7.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class MyQuestionNavigationController: UINavigationController {
    
    // MARK: -Variables
    let myQuestionViewController = MyQuestionsViewController()
    var postViewController: MyPostViewController!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.setViewControllers([myQuestionViewController], animated: false)
        self.navigationBar.isTranslucent = false
        self.view.backgroundColor = .white
        myQuestionViewController.delegate = self
    }
    
}

extension MyQuestionNavigationController: MyQuestionsViewControllerDelegate {
    
    func didTapRow(post: Post) {
        postViewController = MyPostViewController(post: post)
        self.pushViewController(postViewController, animated: true)
    }
    
}
