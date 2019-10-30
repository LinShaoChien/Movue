//
//  TestTableViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/29.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class CommentPostTableViewCell: UITableViewCell {

    let view = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure() {
        
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        view.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
    }

}
