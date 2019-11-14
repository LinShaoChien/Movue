//
//  MainTabBarController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/23.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarItems()
        setupTabBar()
        setupCenterButton()
    }
    
    var isTabBarHidden: Bool = false {
        didSet {
            if isTabBarHidden == true {
                var frame = self.tabBar.frame
                frame.origin.y = self.view.frame.size.height + frame.size.height
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.tabBar.frame = frame
                }
            } else if isTabBarHidden == false {
                var frame = self.tabBar.frame
                frame.origin.y = self.view.frame.size.height - frame.size.height
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.tabBar.frame = frame
                }
            }
        }
    }
    
    func setupTabBar() {
        tabBar.barTintColor = .customLightBlue
        tabBar.backgroundColor = .customLightBlue
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .customDimBlue
    }

    func setupTabBarItems() {
        let myQuestionsNavigationController = MyQuestionNavigationController(navigationBarClass: PostNavigationBar.self, toolbarClass: nil)
        let firstTabBarItem = UITabBarItem(title: "My Questions", image: UIImage(named: "my_questions.png"), selectedImage: UIImage(named: "my_questions.png"))
        firstTabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 11)!
        ], for: .normal)
        myQuestionsNavigationController.tabBarItem = firstTabBarItem
        
        let allQuestionsNavigationController = AllQuestionsNavigationController(navigationBarClass: PostNavigationBar.self, toolbarClass: nil)
        let secondTabBarItem = UITabBarItem(title: "All Questions", image: UIImage(named: "all_questions.png"), tag: 1)
        secondTabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 11)!
        ], for: .normal)
        allQuestionsNavigationController.tabBarItem = secondTabBarItem
        
        viewControllers = [myQuestionsNavigationController, allQuestionsNavigationController]
    }
    
    func setupCenterButton() {
        let centerButton = MainTabBarControllerCenterButton()
        self.tabBar.addSubview(centerButton)
        
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        centerButton.widthAnchor.constraint(equalToConstant: 73).isActive = true
        centerButton.heightAnchor.constraint(equalToConstant: centerButton.frame.size.width).isActive = true
        centerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
        centerButton.bottomAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        
        centerButton.addTarget(self, action: #selector(self.presentAskViewController(_:)), for: .touchUpInside)
    }
    
    @objc func presentAskViewController(_: UIButton!) {
        let view = AskQuestionPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        self.present(view, animated: true, completion: nil)
    }
}
