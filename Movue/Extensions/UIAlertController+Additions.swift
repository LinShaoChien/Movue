//
//  UIAlertController+Additions.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/12/7.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    class func errorAlert(withTitle title: String, andError error: Error) -> UIAlertController {
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        return alert
    }
    
    class func errorAlert(withTitle title: String, andMessage message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
}
