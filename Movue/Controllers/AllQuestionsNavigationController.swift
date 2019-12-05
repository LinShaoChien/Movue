//
//  AllQuestionsNavigationController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/13.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AllQuestionsNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: -Variables
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    let allQuestionsViewController = AllQuestionsViewController()
    var postViewController: MyPostViewController!
    
    func setup() {
        self.setViewControllers([allQuestionsViewController], animated: false)
        
        self.navigationBar.isTranslucent = false
        self.view.backgroundColor = .white
        
        allQuestionsViewController.delegate = self
        
    }

}

extension AllQuestionsNavigationController: AllQuestionViewControllerDelegate {
    
    func didTapRow(post: Post) {
        let view = OtherPostViewController(post: post)
        self.pushViewController(view, animated: true)
    }
    
}
