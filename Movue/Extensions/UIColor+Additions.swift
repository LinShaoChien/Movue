//
//  UIColor+Additions.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let customLightBlue = UIColor(displayP3Red: 73 / 256, green: 125 / 256, blue: 199 / 256, alpha: 100)
    
    static let customDarkBlue = UIColor(displayP3Red: 52 / 256, green: 91 / 256, blue: 130 / 256, alpha: 100)
    
    static let googleRed = UIColor(displayP3Red: 178 / 256, green: 58 / 256, blue: 47 / 256, alpha: 100)
    
}

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(displayP3Red: red / 256, green: green / 256, blue: blue / 256, alpha: 100)
    }
    
    convenience init(hex: String) {
        let stringArray = Array(hex)
        var digitArray = [CGFloat]()
        for hexNumber in stringArray {
            if hexNumber == "A" {
                digitArray.append(10)
            } else if hexNumber == "B" {
                digitArray.append(11)
            } else if hexNumber == "C" {
                digitArray.append(12)
            } else if hexNumber == "D" {
                digitArray.append(13)
            } else if hexNumber == "E" {
                digitArray.append(14)
            } else if hexNumber == "F" {
                digitArray.append(15)
            } else {
                digitArray.append(CGFloat(Int(String(hexNumber))!))
            }
        }
        print(digitArray)
        print((digitArray[0] * 16) + digitArray[1])
        self.init(red: (digitArray[0] * 16) + digitArray[1], green: (digitArray[2] * 16) + digitArray[3], blue: (digitArray[4] * 16) + digitArray[5])
    }
}

