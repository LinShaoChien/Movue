//
//  AvatarView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AvatarView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 176, height: 176))
        avatarBackgroundColor = UIColor.AvatarColors[0]
        avatarGlyphImage = UIImage(named: "white-glyph-1.png")
        setup()
    }
    
    var avatarBackgroundColor: UIColor?
    var avatarGlyphImage: UIImage?
    var imageView = UIImageView()

    func setup() {
        self.backgroundColor = avatarBackgroundColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.addSubview(imageView)
        
        imageView.image = avatarGlyphImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.70).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.70).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}
