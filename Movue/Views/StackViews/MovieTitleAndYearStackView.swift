//
//  MovieTitleAndYearStackView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/30.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class MovieTitleAndYearStackView: UIStackView {

    // MARK: -Init
    init(frame: CGRect, title: String, year: Int) {
        super.init(frame: frame)
        self.movieTitle = title
        self.movieYear = year
        setupStackView()
    }
    
    convenience init(title: String, year: Int) {
        self.init(frame: .zero, title: title, year: year)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Variables
    private var movieTitle: String!
    private var movieYear: Int!
    
    // MARK: -Subviews
    lazy private var movieTitleLabel: UILabel! = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: self.movieTitle, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue,
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 14)!,
            NSAttributedString.Key.kern: 1.2
        ])
        return label
    }()
    lazy private var movieYearLabel: UILabel! = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: String(movieYear), attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue,
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 14)!,
            NSAttributedString.Key.kern: 1
        ])
        return label
    }()
    
    // MARK: -Helpers
    private func setupStackView() {
        self.alignment = .leading
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.spacing = 8
        self.addArrangedSubview(movieTitleLabel)
        self.addArrangedSubview(movieYearLabel)
    }
}
