//
//  Notification+Additions.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/12/7.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didEndCreatingUser = Notification.Name("didEndCreatingUser")
    static let didCreatePost = Notification.Name("didCreatePost")
    static let didUpdateQuestion = Notification.Name("didUpdateQuestion")
    static let didCreateComment = Notification.Name("didCreateComment")
    static let didLogOut = Notification.Name("didLogout")
}
