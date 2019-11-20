//
//  AvatarGlyphCollectionViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AvatarGlyphCollectionViewCell: UICollectionViewCell {
    
    var glyphView = UIImageView()
    var selectedIndicator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(at indextPath: IndexPath) {
        contentView.backgroundColor = .clear
        contentView.addSubview(selectedIndicator)
        contentView.addSubview(glyphView)
        
        glyphView.translatesAutoresizingMaskIntoConstraints = false
        glyphView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85).isActive = true
        glyphView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85).isActive = true
        glyphView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        glyphView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        glyphView.image = UIImage(named: "grey-glyph-\(indextPath.item + 1).png")
        
        selectedIndicator.translatesAutoresizingMaskIntoConstraints = false
        selectedIndicator.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        selectedIndicator.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1).isActive = true
        selectedIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        selectedIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        selectedIndicator.backgroundColor = .customLightGrey
        selectedIndicator.layer.cornerRadius = 8
        selectedIndicator.isHidden = true
    }
    
}
