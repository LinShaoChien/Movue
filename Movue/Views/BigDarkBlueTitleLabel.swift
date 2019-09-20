//
//  BigDarkBlueTitleLabel.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/19.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class BigDarkBlueTitleLabel: TitleLabel {
    
    convenience init(text: String) {
        self.init(frame: CGRect.zero, text: text, color: UIColor.customDarkBlue, font: UIFont(name: PASSION_ONE.bold, size: 52)!)
    }

}
