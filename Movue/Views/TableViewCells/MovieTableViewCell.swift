//
//  MovieTableViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/20.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: -Variables
    var movie: Movie! = Movie(title: "", year: 0)

    // MARK: -Subviews
    lazy var titleLabel: UILabel! = {
        let view = UILabel()
        view.backgroundColor = .green
        view.attributedText = NSAttributedString(string: self.movie.title, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customLightBlue,
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 14)!
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var yearLabel: UILabel! = {
        let view = UILabel()
        let year = String(self.movie.year)
        view.attributedText = NSAttributedString(string: year, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customLightBlue,
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 6)!
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: -Helpers
    func configure(movie: Movie) {
        self.movie = movie
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(yearLabel)
        
        // Setup Autolayout
        titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.width).isActive = true
        
        yearLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor).isActive = true
//        yearLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor).priority = .defaultLow
        yearLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10).isActive = true
        yearLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
    }
}
