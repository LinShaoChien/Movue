//
//  Post.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/7.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import Foundation

class Post {
    
    init(id: String, question: PostQuestion, comments: [PostAnswerComment], createTime: Date, commentCount: Int) {
        self.question = question
        self.comments = comments
        self.createTime = createTime
        self.id = id
        self.commentCount = commentCount
    }
    
    let id: String
    let createTime: Date
    let question: PostQuestion
    var comments: [PostAnswerComment]
    let commentCount: Int
}
