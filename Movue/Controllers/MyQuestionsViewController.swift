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
    var handle: AuthStateDidChangeListenerHandle!
    var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.myQuestionTableView.reloadData()
            }
        }
    }
    var df: DateFormatter! = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
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
    
    var emptyLabel: TitleLabel! = {
        let label = TitleLabel(frame: .zero, text: "You dont't have any questions yet!", color: .customDarkBlue, font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 20)!)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    lazy var askButton: BigButton! = {
        let button = BigButton(frame: .zero, text: "Go Ask!")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(self.presentAskViewController(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "user.png")!, style: .plain, target: self, action: #selector(self.barbuttonPressed(_:)))
        myQuestionTableView.delegate = self
        myQuestionTableView.dataSource = self
        addSubviews()
        setupAutoLayout()
        self.view.backgroundColor = .white
        self.title = "My Questions"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.getPosts(_:)), name: .didCreatePost, object: nil)
    }
    
    @objc func barbuttonPressed(_: UIBarButtonItem) {
        let viewController = SignOutViewController()
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismiss(_:)), name: .didLogOut, object: nil)
        getPosts { (posts) in
            if posts.isEmpty {
                self.myQuestionTableView.isHidden = true
                self.emptyLabel.isHidden = false
                self.askButton.isHidden = false
            } else {
                self.myQuestionTableView.isHidden = false
                self.emptyLabel.isHidden = true
                self.askButton.isHidden = true
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func addSubviews() {
        self.view.addSubview(myQuestionTableView)
        self.view.addSubview(emptyLabel)
        self.view.addSubview(askButton)
    }
    
    func setupAutoLayout() {
        myQuestionTableView.translatesAutoresizingMaskIntoConstraints = false
        myQuestionTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        myQuestionTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myQuestionTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myQuestionTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        emptyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50).isActive = true
        
        askButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        askButton.topAnchor.constraint(equalTo: self.emptyLabel.bottomAnchor, constant: 10).isActive = true
        askButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        askButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    @objc func presentAskViewController(_ sender: UIButton) {
        let vc = AskQuestionPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func dismiss(_ sender: Notification) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func getPosts(_: Notification) {
        getPosts { (posts) in
            if posts.isEmpty {
                self.myQuestionTableView.isHidden = true
                self.emptyLabel.isHidden = false
                self.askButton.isHidden = false
            } else {
                self.myQuestionTableView.isHidden = false
                self.emptyLabel.isHidden = true
                self.askButton.isHidden = true
            }
        }
    }
    
    func getPosts(completion: @escaping ([Post]) -> ()) {
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
                print(snapshots.documents.count)
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
                                    let avatar = Avatar(color: UIColor.AvatarColors[avatarColor], glyph: UIImage.avatarGlyphs[avatarGlyph]!)
                                    let user = User(name: name, email: email, avatar: avatar)
                                    let question = PostQuestion(id: id, title: title, time: time, language: languages, plots: plot, isSpoiler: isSpoiler, casts: casts, user: user, lastupdate: lastUpdateString)
                                    let post = Post(id: postid, question: question, comments: [], createTime: createTime, commentCount: commentCount)
                                    posts.append(post)
                                }
                                if posts.count == snapshots.documents.count {
                                    posts = posts.sorted(by: { $0.createTime.compare($1.createTime) == .orderedDescending })
                                    self.posts = posts
                                    completion(posts)
                                }
                            }
                        }
                    }
                }
                completion(posts)
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
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyQuestionTableViewCell
        let post = posts[indexPath.row]
        let title = post.question.title
        let commentsCount = post.commentCount
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
