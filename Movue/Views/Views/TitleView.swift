//
//  TitleView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class TitleView: UIView {

    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        self.titleText = title
        setup()
    }
    
    convenience init(title: String) {
        self.init(frame: .zero, title: title)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var titleText: String?

    func setup() {
        
        let title = UILabel()
        self.addSubview(title)
        title.attributedText = NSAttributedString(string: titleText!, attributes: [
            NSAttributedString.Key.font: UIFont(name: PASSION_ONE.bold, size: 38)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true
        
        self.backgroundColor = .customLightBlue
    }
}
