//
//  MyQuestionsViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MyQuestionsViewController: UIViewController {
    
    // MARK: -Variables
    var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.myQuestionTableView.reloadData()
            }
        }
    }
    var df: DateFormatter! = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return df
    }()
    
    weak var delegate: MyQuestionsViewControllerDelegate?
    // MARK: - Subviews
    var myQuestionTableView: UITableView! = {
        let tableView = UITableView()
        tableView.register(MyQuestionTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .customDimBlue
        return tableView
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        myQuestionTableView.delegate = self
        myQuestionTableView.dataSource = self
        addSubviews()
        setupAutoLayout()
        self.view.backgroundColor = .white
        self.title = "My Questions"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.getPosts(_:)), name: .didCreatePost, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        getPosts()
    }

    func addSubviews() {
        self.view.addSubview(myQuestionTableView)
    }
    
    func setupAutoLayout() {
        
        myQuestionTableView.translatesAutoresizingMaskIntoConstraints = false
        myQuestionTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        myQuestionTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myQuestionTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myQuestionTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    @objc func getPosts(_: Notification) {
        getPosts()
    }
    
    func getPosts() {
        let user = Auth.auth().currentUser!.email!
        let docRef = db.collection("posts").whereField("user", isEqualTo: user)
        docRef.order(by: "createTime", descending: true)
        docRef.getDocuments { (snapshots, err) in
            if let err = err {
                let allert = UIAlertController.errorAlert(withTitle: "Fail to get posts", andError: err)
                self.present(allert, animated: true, completion: nil)
            }
            var posts = [Post]()
            if let snapshots = snapshots {
                for document in snapshots.documents {
                    let data = document.data()
                    let createTime = (data["createTime"] as! Timestamp).dateValue()
                    let questionRef = data["question"] as! DocumentReference
                    questionRef.getDocument { (snapshot, error) in
                        if let err = err {
                            let allert = UIAlertController.errorAlert(withTitle: "Fail to get posts", andError: err)
                            self.present(allert, animated: true, completion: nil)
                        } else if let snapshot = snapshot {
                            let data = snapshot.data()!
                            let id = snapshot.documentID
                            let title = data["title"] as! String
                            let time = data["time"] as! String
                            let languages = data["languages"] as! String
                            let isSpoiler = data["isSpoiler"] as! Bool
                            let casts = data["casts"] as! String
                            let plot = data["plot"] as! String
                            let userEmail = data["user"] as! String
                            let lastUpdate = (data["lastUpdate"] as! Timestamp).dateValue()
                            let lastUpdateString = self.df.string(from: lastUpdate)
                            db.collection("users").document(userEmail).getDocument { (document, err) in
                                if let err = err {
                                    let allert = UIAlertController.errorAlert(withTitle: "Fail to get posts", andError: err)
                                    self.present(allert, animated: true, completion: nil)
                                } else if let document = document {
                                    let data = document.data()!
                                    let name = data["name"] as! String
                                    let email = data["email"] as! String
                                    let avatarColor = data["avatarColor"] as! Int
                                    let avatarGlyph = data["avatarGlyph"] as! Int
                                    let avatar = Avatar(color: UIColor.AvatarColors[avatarColor - 1], glyph: UIImage.avatarGlyphs[avatarGlyph - 1]!)
                                    let user = User(name: name, email: email, avatar: avatar)
                                    let question = PostQuestion(id: id, title: title, time: time, language: languages, plots: plot, isSpoiler: isSpoiler, casts: casts, user: user, lastupdate: lastUpdateString)
                                    let post = Post(question: question, comments: [], createTime: createTime)
                                    posts.append(post)
                                }
                                if posts.count == snapshots.documents.count {
                                    posts = posts.sorted(by: { $0.createTime.compare($1.createTime) == .orderedDescending })
                                    self.posts = posts
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension MyQuestionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let delegate = delegate else {
            return
        }
        let row = indexPath.row
        let post = posts[row]
        delegate.didTapRow(post: post)
    }
}

extension MyQuestionsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyQuestionTableViewCell
        let post = posts[indexPath.row]
        let title = post.question.title
        let commentsCount = post.comments.count
        cell.update(questionTitle: title, numberLabel: commentsCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

protocol MyQuestionsViewControllerDelegate: AnyObject {
    func didTapRow(post: Post)
}
