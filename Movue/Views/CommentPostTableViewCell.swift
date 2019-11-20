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
    var movieTitle: String? = nil
    var movieYear: Int? = nil
    var posterURL: URL? = URL(string: "https://image.tmdb.org/t/p/w1280/7BsvSuDQuoqhWmU2fL7W2GOcZHU.jpg")!
    var postComment: String! = "Hey I think it might be this one"
    var voteNumber: Int? = nil
    var nicknameText: String! = "Eric Tsai"
    var time: String! = "2019/9/11_09:38"
    var avatarColor: UIColor! = UIColor.AvatarColors[1]
    var avatarGlyph: UIImage! = UIImage(named: "white-glyph-4.png")!
    
    // MARK: -Subviews
    lazy var posterNVoteStackView: UIStackView? = {
        if let posterImageView = self.posterImageView, let titleNYearStackView = self.titleNYearStackView, let voteStackView = self.voteStackView {
            let view = UIStackView(arrangedSubviews: [
                voteStackView,
                posterImageView,
                titleNYearStackView
            ])
            view.axis = .horizontal
            view.spacing = 20
            view.distribution = .equalSpacing
            view.alignment = .center
            return view
        } else {
            return nil
        }
    }()
    
    lazy var voteStackView: VotingStackView? = {
        if let voteNumber = self.voteNumber {
            let view = VotingStackView(voteNumber: voteNumber, status: VoteStatus.none)
            return view
        }
        return nil
    }()
    
    lazy var titleNYearStackView: MovieTitleAndYearStackView? = {
        if let title = self.movieTitle, let year = self.movieYear {
            let view = MovieTitleAndYearStackView(title: title, year: year)
            return view
        }
        return nil
    }()
    
    lazy var posterImageView: MoviePosterImageView? = {
        if let posterURL = self.posterURL {
            let view = MoviePosterImageView(posterURL: posterURL)
            return view
        } else {
            return nil
        }
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
        let view = UIStackView()
        view.addArrangedSubview(self.header)
        if let posterNVoteStackView = self.posterNVoteStackView {
            view.addArrangedSubview(posterNVoteStackView)
        }
        view.addArrangedSubview(self.commentLabel)
        view.addArrangedSubview(self.signatureView)
        view.addArrangedSubview(self.footer)
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .equalSpacing
        view.spacing = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var header = UIView()
    var footer = UIView()
    
    var footerView: UIView! = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: -Helpers
    func configure(postComment: PostAnswerComment) {
        if let url = postComment.moviePosterURL, let movieTitle = postComment.movieTitle, let movieYear = postComment.movieYear, let upVote = postComment.upVoteUser?.count, let downVote = postComment.downVoteUser?.count {
            self.voteNumber = upVote - downVote
            self.posterURL = url
            self.movieTitle = movieTitle
            self.movieYear = movieYear
        }
        self.postComment = postComment.comment
        self.nicknameText = postComment.user.name
        self.avatarColor = postComment.user.avatar.color
        self.avatarGlyph = postComment.user.avatar.glyph
        self.time = postComment.lastUpdate
        self.contentView.backgroundColor = .customDimLightGrey
        self.contentView.addSubview(stackView)
        self.contentView.addSubview(footerView)
        setupAutolayout()
    }
    
    func setupAutolayout() {
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30).isActive = true
        
        footerView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor).isActive = true
        footerView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        footerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
    }

}
