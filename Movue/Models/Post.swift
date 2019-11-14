//
//  Post.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/7.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import Foundation

class Post {
    
    init(question: PostQuestion, comments: [PostAnswerComment]) {
        self.question = question
        self.comments = comments
    }
    
    let question: PostQuestion
    let comments: [PostAnswerComment]
}
