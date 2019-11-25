//
//  EmptyResultTableViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/22.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class EmptyResultTableViewCell: UITableViewCell {

    var emptyLabel: UILabel! = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "No Result", attributes: [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.customLightBlue
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func configure() {
        self.contentView.addSubview(emptyLabel)
        
        emptyLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
}
