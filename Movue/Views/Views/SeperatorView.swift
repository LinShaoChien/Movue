//
//  SeperatorView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/29.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class SeperatorView: UIView {

    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.color = color
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero, color: color)
    }
    
    var color: UIColor!
    
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = color
    }
}

extension SeperatorView {
    static func white() -> SeperatorView {
        return SeperatorView(color: .white)
    }
}
