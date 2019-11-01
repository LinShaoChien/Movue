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
    
    static let customLightGrey = UIColor(displayP3Red: 232 / 256, green: 232 / 256, blue: 232 / 256, alpha: 100)
    
    static let customDimLightGrey = UIColor(displayP3Red: 237 / 256, green: 237 / 256, blue: 237 / 256, alpha: 100)
    
    static let customDimBlue = UIColor(displayP3Red: 144 / 256, green: 169 / 256, blue: 205 / 256, alpha: 100)
    
    static let customGreen = UIColor(displayP3Red: 117 / 256, green: 200 / 256, blue: 126 / 256, alpha: 100)
    
    static let customOrange = UIColor(displayP3Red: 235 / 256, green: 151 / 256, blue: 119 / 256, alpha: 100)
    
    enum Avatar: CaseIterable {
        static let color1 = UIColor(hex: "DF5054")
        static let color2 = UIColor(hex: "E96548")
        static let color3 = UIColor(hex: "DF7937")
        static let color4 = UIColor(hex: "D5962B")
        static let color5 = UIColor(hex: "5D9540")
        static let color6 = UIColor(hex: "48A088")
        static let color7 = UIColor(hex: "5497AC")
        static let color8 = UIColor(hex: "6088BF")
        static let color9 = UIColor(hex: "6975C2")
        static let color10 = UIColor(hex: "805EBF")
        static let color11 = UIColor(hex: "BE69C2")
        static let color12 = UIColor(hex: "E46E8E")
        static let color13 = UIColor(hex: "6E7985")
        static let color14 = UIColor(hex: "7F8880")
        static let color15 = UIColor(hex: "7D706B")
    }
    
    static let AvatarColors = [UIColor.Avatar.color1, UIColor.Avatar.color2, UIColor.Avatar.color3, UIColor.Avatar.color4, UIColor.Avatar.color5, UIColor.Avatar.color6, UIColor.Avatar.color7, UIColor.Avatar.color8, UIColor.Avatar.color9, UIColor.Avatar.color10, UIColor.Avatar.color11, UIColor.Avatar.color12, UIColor.Avatar.color13, UIColor.Avatar.color14, UIColor.Avatar.color15]
    
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
        
        self.init(red: (digitArray[0] * 16) + digitArray[1], green: (digitArray[2] * 16) + digitArray[3], blue: (digitArray[4] * 16) + digitArray[5])
    }
}

