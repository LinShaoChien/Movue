//
//  MyQuestionsViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class MyQuestionsViewController: UIViewController {

    // MARK: -Data simulation
    let avatar1 = Avatar(color: UIColor.Avatar.color3, glyph: UIImage(named: "white-glyph-1.png")!)
    let avatar2 = Avatar(color: UIColor.Avatar.color1, glyph: UIImage(named: "white-glyph-7.png")!)
    lazy var user1 = User(name: "Aaron Lin", email: "aaronlin851117@gmail.com", avatar: self.avatar1)
    lazy var user2 = User(name: "Eric Tsai", email: "ts.eric@gmail.com", avatar: self.avatar2)
    lazy var postComment1 = PostComment(comment: "Hey I think it's this one", user: user1, lastUpdate: "2019/9/12_09:56")
    lazy var postCommentAnswer1 = PostAnswerComment(comment: "Is it green book?", user: user2, lastUpdate: "2019/9/12_09:25", upVoteUser: [user1,user2], downVoteUser: nil, movieTitle: "Green Book", moviePosterURL: URL(string: "https://image.tmdb.org/t/p/w1280/7BsvSuDQuoqhWmU2fL7W2GOcZHU.jpg")!)
    lazy var postQuestion = PostQuestion(title: "A road movie and it is very very good", time: "2 years ago", language: "English", plots: "A black pianist and his driver going on a road trip to perform in the southern states of the US", isSpoiler: false, casts: "Viggo Mortenson", user: user1, lastupdate: "2019/9/12_09:12")
    lazy var post = Post(question: self.postQuestion, comments: [self.postCommentAnswer1, self.postComment1])
    
    // MARK: -Variables
    lazy var posts = [self.post]
    
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
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.isTabBarHidden = false
            print("haha")
        }
        self.view.backgroundColor = .white
        self.title = "My Questions"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
}

extension MyQuestionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let delegate = delegate else {
            print("return")
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
        cell.configureCell(commentNumbers: post.comments.count, questionTitle: post.question.title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

protocol MyQuestionsViewControllerDelegate: AnyObject {
    func didTapRow(post: Post)
}
