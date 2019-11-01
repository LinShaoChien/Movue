//
//  TestTableViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/29.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class CommentPostTableViewCell: UITableViewCell {

    var posterURL: URL! = URL(string: "https://image.tmdb.org/t/p/w1280/7BsvSuDQuoqhWmU2fL7W2GOcZHU.jpg")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    lazy var stackView: UIStackView! = {
        let view = UIStackView(arrangedSubviews: [
            self.voteStackView,
            self.posterImageView,
            self.titleNYearStackView
        ])
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .equalSpacing
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var voteStackView: VotingStackView! = {
        let view = VotingStackView(voteNumber: 30, status: VoteStatus.none)
        return view
    }()
    
    lazy var titleNYearStackView: MovieTitleAndYearStackView! = {
        let view = MovieTitleAndYearStackView(title: "Green Book", year: 2018)
        return view
    }()
    
    lazy var posterImageView: MoviePosterImageView! = {
        let view = MoviePosterImageView(posterURL: self.posterURL)
        return view
    }()

    func configure() {
        self.contentView.backgroundColor = .customDimLightGrey
        self.contentView.addSubview(stackView)
        setupAutolayout()
    }
    
    func setupAutolayout() {
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30).isActive = true
        
    }

}
