//
//  TestTableViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/29.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class CommentPostTableViewCell: UITableViewCell {

    // MARK: -Variables
    var posterURL: URL! = URL(string: "https://image.tmdb.org/t/p/w1280/7BsvSuDQuoqhWmU2fL7W2GOcZHU.jpg")!
    var postComment: String! = "Hey I think it might be this one"
    var nicknameText: String! = "Eric Tsai"
    var time: String! = "2019/9/11_09:38"
    var avatarColor: UIColor! = UIColor.AvatarColors[1]
    var avatarGlyph: UIImage! = UIImage(named: "white-glyph-4.png")!
    
    // MARK: -Subviews
    lazy var posterNVoteStackView: UIStackView! = {
        let view = UIStackView(arrangedSubviews: [
            self.voteStackView,
            self.posterImageView,
            self.titleNYearStackView
        ])
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .equalSpacing
        view.alignment = .center
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
    
    lazy var commentLabel: TitleLabel! = {
        let view = TitleLabel(frame: .zero, text: self.postComment, color: UIColor.customDarkBlue, font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 20)!)
        return view
    }()
    
    lazy var signatureView: SignatureView! = {
        let signatureView = SignatureView(frame: .zero, nickname: nicknameText, time: time, avatarColor: avatarColor, avatarGlyph: avatarGlyph)
        return signatureView
    }()
    
    lazy var stackView: UIStackView! = {
        let view = UIStackView(arrangedSubviews: [
            self.header,
            self.posterNVoteStackView,
            self.commentLabel,
            self.signatureView,
            self.footer
        ])
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .equalSpacing
        view.spacing = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var header = UIView()
    var footer = UIView()

    // MARK: -Helpers
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
