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
    
    func setupTabBar() {
        tabBar.barTintColor = .customLightBlue
        tabBar.backgroundColor = .customLightBlue
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .customDarkBlue
    }

    func setupTabBarItems() {
        let myQuestionsViewController = MyQuestionsViewController()
        let firstTabBarItem = UITabBarItem(title: "My Questions", image: UIImage(named: "my_questions.png"), selectedImage: UIImage(named: "my_questions.png"))
        firstTabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 11)!
        ], for: .normal)
        myQuestionsViewController.tabBarItem = firstTabBarItem
        
        let allQuestionsViewController = AllQuestionsViewController()
        let secondTabBarItem = UITabBarItem(title: "All Questions", image: UIImage(named: "all_questions.png"), tag: 1)
        secondTabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 11)!
        ], for: .normal)
        allQuestionsViewController.tabBarItem = secondTabBarItem
        
        viewControllers = [myQuestionsViewController, allQuestionsViewController]
    }
    
    func setupCenterButton() {
        let centerButton = MainTabBarControllerCenterButton()
        self.tabBar.addSubview(centerButton)
        
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        centerButton.widthAnchor.constraint(equalToConstant: 73).isActive = true
        centerButton.heightAnchor.constraint(equalToConstant: centerButton.frame.size.width).isActive = true
        centerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
        centerButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor, constant: -10).isActive = true
    }
}
