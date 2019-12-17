//
//  AllQuestionsViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AllQuestionsViewController: UIViewController {
    
    // MARK: -Variables
    var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.allQuestionTableView.reloadData()
            }
        }
    }
    var df: DateFormatter! = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df
    }()
    weak var delegate: AllQuestionViewControllerDelegate?

    // MARK: - Subviews
    var allQuestionTableView: UITableView! = {
        let tableView = UITableView()
        tableView.register(AllQuestionTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .customDimBlue
        return tableView
    }()
    
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .customLightBlue
        spinner.isHidden = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "All Questions"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        allQuestionTableView.delegate = self
        allQuestionTableView.dataSource = self
        addSubviews()
        setupAutoLayout()
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPosts()
    }

    func addSubviews() {
        self.view.addSubview(allQuestionTableView)
        self.view.addSubview(spinner)
    }
    
    func setupAutoLayout() {
        allQuestionTableView.translatesAutoresizingMaskIntoConstraints = false
        allQuestionTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        allQuestionTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        allQuestionTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        allQuestionTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
    }
    
    func getPosts() {
        spinner.startAnimating()
        var posts = [Post]()
        let docRef = db.collection("posts")
        docRef.order(by: "createTime", descending: true)
        docRef.getDocuments { (snapshots, err) in
            if let err = err {
                let allert = UIAlertController.errorAlert(withTitle: "Fail to get posts", andError: err)
                self.present(allert, animated: true, completion: nil)
                self.spinner.stopAnimating()
            }
            if let snapshots = snapshots {
                for document in snapshots.documents {
                    let data = document.data()
                    let postid = document.documentID
                    let commentRefs = data["comments"] as! [DocumentReference]
                    let commentCount = commentRefs.count
                    let createTime = (data["createTime"] as! Timestamp).dateValue()
                    let questionRef = data["question"] as! DocumentReference
                    questionRef.getDocument { (snapshot, error) in
                        if let err = err {
                            let allert = UIAlertController.errorAlert(withTitle: "Fail to get posts", andError: err)
                            self.present(allert, animated: true, completion: nil)
                            self.spinner.stopAnimating()
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
                                    self.spinner.stopAnimating()
                                } else if let document = document {
                                    let data = document.data()!
                                    let name = data["name"] as! String
                                    let email = data["email"] as! String
                                    let avatarColor = data["avatarColor"] as! Int
                                    let avatarGlyph = data["avatarGlyph"] as! Int
                                    let avatar = Avatar(color: UIColor.AvatarColors[avatarColor], glyph: UIImage.avatarGlyphs[avatarGlyph]!)
                                    let user = User(name: name, email: email, avatar: avatar)
                                    let question = PostQuestion(id: id, title: title, time: time, language: languages, plots: plot, isSpoiler: isSpoiler, casts: casts, user: user, lastupdate: lastUpdateString)
                                    let post = Post(id: postid, question: question, comments: [], createTime: createTime, commentCount: commentCount)
                                    posts.append(post)
                                }
                                if posts.count == snapshots.documents.count {
                                    posts = posts.sorted(by: { $0.createTime.compare($1.createTime) == .orderedDescending })
                                    self.posts = posts
                                }
                                self.spinner.stopAnimating()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension AllQuestionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let delegate = self.delegate else { return }
        delegate.didTapRow(post: posts[indexPath.row])
    }
}

extension AllQuestionsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllQuestionTableViewCell
        let post = posts[indexPath.row]
        cell.updateCell(commentNumbers: post.commentCount, questionTitle: post.question.title, questionContent: post.question.plots, isSpoiler: post.question.isSpoiler)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

protocol AllQuestionViewControllerDelegate: AnyObject {
    func didTapRow(post: Post)
}
