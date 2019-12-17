//
//  PostComment.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/7.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import Foundation

class PostAnswerComment: PostComment {
    

    init(id: String, comment: String, user: User, lastUpdate: Date, upVoteUser: [String]?, downVoteUser: [String]?, movieTitle: String?, movieYear: Int?, moviePosterURL: URL?) {
        self.upVoteUser = upVoteUser
        self.downVoteUser = downVoteUser
        self.movieTitle = movieTitle
        self.moviePosterURL = moviePosterURL
        self.movieYear = movieYear
        super.init(id: id, comment: comment, user: user, lastUpdate: lastUpdate)
    }
    
    let upVoteUser: [String]?
    let downVoteUser: [String]?
    var vote: Int? {
        guard let upVoteUser = upVoteUser, let downVoteUser = downVoteUser else { return nil }
        return upVoteUser.count - downVoteUser.count
    }
    let movieTitle: String?
    let movieYear: Int?
    let moviePosterURL: URL?
}
