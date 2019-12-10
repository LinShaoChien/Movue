//
//  PostComment.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/7.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import Foundation

class PostAnswerComment: PostComment {
    

    init(comment: String, user: User, lastUpdate: Date, upVoteUser: [User]?, downVoteUser: [User]?, movieTitle: String?, movieYear: Int?, moviePosterURL: URL?) {
        self.upVoteUser = upVoteUser
        self.downVoteUser = downVoteUser
        self.movieTitle = movieTitle
        self.moviePosterURL = moviePosterURL
        self.movieYear = movieYear
        super.init(comment: comment, user: user, lastUpdate: lastUpdate)
    }
    
    let upVoteUser: [User]?
    let downVoteUser: [User]?
    var vote: Int? {
        guard let upVoteUser = upVoteUser, let downVoteUser = downVoteUser else { return nil }
        return upVoteUser.count - downVoteUser.count
    }
    let movieTitle: String?
    let movieYear: Int?
    let moviePosterURL: URL?
}
