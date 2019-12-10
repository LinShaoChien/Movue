//
//  PostAuthorComment.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/7.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import Foundation

class PostComment {
    
    init(comment: String, user: User, lastUpdate: Date) {
        self.comment = comment
        self.user = user
        self.lastUpdate = lastUpdate
    }
    
    let comment: String
    let user: User
    let lastUpdate: Date
}
