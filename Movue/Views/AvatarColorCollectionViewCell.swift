//
//  AvatarColorCollectionViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/21.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AvatarColorCollectionViewCell: UICollectionViewCell {
    
    var colorView = UIView()
    var selectedIndicator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(at indextPath: IndexPath) {
        contentView.backgroundColor = .clear
        contentView.addSubview(colorView)
        contentView.addSubview(selectedIndicator)
        
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        colorView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        colorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        colorView.backgroundColor = UIColor.AvatarColors[indextPath.item]
        
        colorView.layer.cornerRadius = contentView.frame.size.width / 2
        colorView.clipsToBounds = true
        
        selectedIndicator.translatesAutoresizingMaskIntoConstraints = false
        selectedIndicator.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -5).isActive = true
        selectedIndicator.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant:  -5).isActive = true
        selectedIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        selectedIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        selectedIndicator.layer.cornerRadius = (contentView.frame.size.width - 4) / 2
        selectedIndicator.backgroundColor = .clear
        selectedIndicator.layer.borderWidth = 1.3
        selectedIndicator.layer.borderColor = UIColor.white.cgColor
        selectedIndicator.isHidden = true
    }
    
}
