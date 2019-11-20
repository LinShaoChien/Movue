//
//  ImageButton.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/18.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class ImageButton: UIButton {

    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        self.image = image
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var image: UIImage?
    
    func setup() {
        self.setImage(image, for: .normal)
        self.contentMode = .scaleAspectFit
    }
}
