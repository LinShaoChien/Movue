//
//  AnswerNavigationController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/26.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AnswerNavigationController: UINavigationController {

    var movie: Movie!
    var comment: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.isHidden = true
    }
    

}
