//
//  AnswerNavigationController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/26.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AnswerNavigationController: UINavigationController {

    var postid: String!
    var movie: Movie!
    var comment: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.isHidden = true
    }
    
    func createPostComment(completion: @escaping (Error?) -> ()) {
        let uuid = UUID().uuidString
        db.collection("comments").document(uuid).setData([
            "title": movie.title,
            "year": movie.year,
            "comment": self.comment!,
            "posterPath": movie.posterPath,
            "upvoteUser": [],
            "downvoteUser": [],
            "lastUpdate": Timestamp(date: Date()),
            "user": Auth.auth().currentUser!.email!
        ]) { (error) in
            if let error = error {
                completion(error)
                return
            }
            db.collection("posts").document(self.postid).updateData([
                "comments": FieldValue.arrayUnion([
                    db.collection("comments").document(uuid)
                ])
            ]) { (error) in
                if let error = error {
                    completion(error)
                }
                completion(nil)
            }
        }
    }

}
