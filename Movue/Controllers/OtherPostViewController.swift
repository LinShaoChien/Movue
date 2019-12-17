//
//  OtherPostViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/13.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit
import FirebaseFirestore

class OtherPostViewController: UIViewController {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, post: Post) {
        super.init(nibName: nil, bundle: nil)
        self.post = post
        self.title = post.question.title
    }
    
    convenience init(post: Post) {
        self.init(nibName: nil, bundle: nil, post: post)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var post: Post!
    
    var comments: [PostAnswerComment]! {
        didSet {
            self.post.comments = comments
            self.post.comments = self.post.comments.sorted(by: { $0.lastUpdate.compare($1.lastUpdate) == .orderedAscending })
            let comments = post.comments
            for comment in comments {
                print(comment.lastUpdate)
            }
            self.tableView.reloadData()
        }
    }
    
    var df: DateFormatter! = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.navigationItem.largeTitleDisplayMode = .never
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.isTabBarHidden = true
        }
        setupAutolayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getComments()
        NotificationCenter.default.addObserver(self, selector: #selector(getComments(_:)), name: .didCreateComment, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.isTabBarHidden = false
        }
    }
    
    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.register(QuestionPostWithoutEditTableViewCell.self, forCellReuseIdentifier: "QuestionPostCell")
        tableView.register(CommentPostTableViewCell.self, forCellReuseIdentifier: "CommentPostCell")
        tableView.register(GoAnswerTableViewCell.self, forCellReuseIdentifier: "GoAnswerCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        return tableView
    }()
    
    func setupAutolayout() {
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    @objc func getComments(_ sender: Notification) {
        print("get comment")
        getComments()
    }
    
    func getComments() {
        var comments = [PostAnswerComment]()
        let postid = post.id
        let docRef = db.collection("posts").document(postid)
        docRef.getDocument { (document, error) in
            if let error = error {
                let alert = UIAlertController.errorAlert(withTitle: "Failed to get comments", andError: error)
                self.present(alert, animated: true, completion: nil)
            }
            if let document = document {
                let data = document.data()!
                let commentRefs = data["comments"] as! [DocumentReference]
                for commentRef in commentRefs {
                    commentRef.getDocument { (document, error) in
                        if let error = error {
                            // Handle error
                            print(error.localizedDescription)
                        }
                        if let document = document {
                            let data = document.data()!
                            let lastUpdate = (data["lastUpdate"] as! Timestamp).dateValue()
                            let title = data["title"] as! String
                            let comment = data["comment"] as! String
                            let year = data["year"] as! Int
                            let upvoteUser = data["upvoteUser"] as! [DocumentReference]
                            let downvoteUser = data["downvoteUser"] as! [DocumentReference]
                            let user = data["user"] as! String
                            let posterPath = data["posterPath"] as! String
                            let posterURL = URL(string: "https://image.tmdb.org/t/p/w1280" + posterPath)
                            db.collection("users").document(user).getDocument { (document, error) in
                                if let error = error {
                                    // Handle error
                                    print(error.localizedDescription)
                                    return
                                } else if let document = document {
                                    let data = document.data()!
                                    let email = data["email"] as! String
                                    let name = data["name"] as! String
                                    let avatarColor = data["avatarColor"] as! Int
                                    let avatarGlyph = data["avatarGlyph"] as! Int
                                    let commentUser = User(name: name, email: email, avatar: Avatar(color: UIColor.AvatarColors[avatarColor], glyph: UIImage.avatarGlyphs[avatarGlyph]!))
                                    let answer = PostAnswerComment(comment: comment, user: commentUser, lastUpdate: lastUpdate, upVoteUser: [], downVoteUser: [], movieTitle: title, movieYear: year, moviePosterURL: posterURL)
                                    comments.append(answer)
                                    if comments.count == commentRefs.count {
                                        self.comments = comments
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

extension OtherPostViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
}

extension OtherPostViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return post.comments.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionPostCell", for: indexPath) as! QuestionPostWithoutEditTableViewCell
            cell.configure(postQuestion: post.question)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentPostCell", for: indexPath) as! CommentPostTableViewCell
            let comment = self.post.comments[indexPath.row]
            print(comment.lastUpdate)
            cell.configure(postComment: comment)
            if let voteStackView = cell.stackView.arrangedSubviews[1] as? UIStackView {
                let posterImageView = voteStackView.arrangedSubviews[1] as! MoviePosterImageView
                posterImageView.delegate = self
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoAnswerCell", for: indexPath) as! GoAnswerTableViewCell
            cell.delegate = self
            cell.configure()
            return cell
        }
    }
}

extension OtherPostViewController: MoviePosterImageViewDelegate {
    
    func didTapPoster(poster: UIImage) {
        let vc = PosterViewController(poster: poster)
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension OtherPostViewController: GoAnswerTableViewCellDelegate {
    
    func didTapGoAnswerTableViewCell() {
        let viewController = AnswerNavigationController(rootViewController: AnswerMovieViewController())
        viewController.postid = post.id
        self.present(viewController, animated: true, completion: nil)
    }
    
}
