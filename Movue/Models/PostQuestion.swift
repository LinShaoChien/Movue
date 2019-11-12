//
//  PostQuestion.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/7.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import Foundation

struct PostQuestion {
    
    init(title: String, time: String, language: String, plots: String, isSpoiler: Bool, casts: String, user: User, lastupdate: String) {
        self.title = title
        self.time = time
        self.language = language
        self.plots = plots
        self.isSpoiler = isSpoiler
        self.casts = casts
        self.user = user
        self.lastupdate = lastupdate
    }
    
    let title: String
    let time: String
    let language: String
    let plots: String
    let isSpoiler: Bool
    let casts: String
    let user: User
    let lastupdate: String
}
