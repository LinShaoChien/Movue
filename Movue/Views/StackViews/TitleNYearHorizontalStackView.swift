//
//  TitleNYearHorizontalStackView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/22.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class TitleNYearHorizontalStackView: UIStackView {

    // MARK: -Initializers
    init(frame: CGRect, movie: Movie) {
        super.init(frame: frame)
        self.title = movie.title
        self.year = movie.year
        setup()
    }
    
    convenience init(movie: Movie) {
        self.init(frame: .zero, movie: movie)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Subviews
    lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: self.title, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customLightBlue,
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 14)!
        ])
        label.widthAnchor.constraint(lessThanOrEqualToConstant: 220).isActive = true
        return label
    }()
    
    lazy var yearLabel: UILabel! = {
        let label = UILabel()
        let year = String(self.year)
        label.attributedText = NSAttributedString(string: year, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customLightBlue,
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 10)!
        ])
        return label
    }()
    
    // MARK: -Variables
    var title: String!
    var year: Int!
    weak var delegate: TitleNYearHorizontalStackViewDelegate?

    // MARK: -Helpers
    func setup() {
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(yearLabel)
        self.spacing = 10
        self.alignment = .lastBaseline
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.isUserInteractionEnabled = true
    }
    
    func setupGestureRecognizer() {
        let gestureRecognizer = UIGestureRecognizer(target: self, action: #selector(self.touchupInside))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func touchupInside() {
        if let delegate = self.delegate {
            delegate.didTap(title: title)
        }
    }
}

protocol TitleNYearHorizontalStackViewDelegate: AnyObject {
    func didTap(title: String)
}
