//
//  HorrizontalImageAndTextStackView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/18.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class HorrizontalImageAndTextStackView: UIStackView {
    
    init(frame: CGRect, image: UIButton, label: UIButton, spacing: CGFloat) {
        super.init(frame: frame)
        self.spacing = spacing
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    var image: UIImage?
    var text: UILabel?
    
    func setup() {
        let imageView = UIImageView(image: image)
        self.addArrangedSubview(imageView)
        self.addArrangedSubview(text!)
        self.axis = .horizontal
        self.alignment = .fill
        self.spacing = 10
        
    }
}
