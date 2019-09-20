//
//  SmallLightBlueTitleLabel.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/19.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class SmallLightBlueTitleLabel: TitleLabel {

    convenience init(text: String) {
        self.init(frame: CGRect.zero, text: text, color: UIColor.customLightBlue, font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 14)!)
    }

}
