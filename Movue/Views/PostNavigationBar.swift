//
//  PostNavigationBar.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/12.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class PostNavigationBar: UINavigationBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: PASSION_ONE.bold, size: 22)!,
            NSAttributedString.Key.kern: 1.4
        ]
        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: PASSION_ONE.bold, size: 44)!,
            NSAttributedString.Key.kern: 1.4
        ]
        appearance.backgroundColor = .customLightBlue
        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance
        self.backgroundColor = .white
        self.isTranslucent = true
        self.tintColor = .white
        self.barTintColor = .customLightBlue
//        self.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: UIColor.white,
//            NSAttributedString.Key.font: UIFont(name: PASSION_ONE.bold, size: 38)!,
//            NSAttributedString.Key.kern: 1.4
//        ]
    }
    
}
