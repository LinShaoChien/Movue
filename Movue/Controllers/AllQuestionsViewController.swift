//
//  AllQuestionsViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AllQuestionsViewController: UIViewController {
    
    // MARK: -Data simulation
    let avatar1 = Avatar(color: UIColor.Avatar.color3, glyph: UIImage(named: "white-glyph-1.png")!)
    let avatar2 = Avatar(color: UIColor.Avatar.color1, glyph: UIImage(named: "white-glyph-7.png")!)
    lazy var user1 = User(name: "Aaron Lin", email: "aaronlin851117@gmail.com", avatar: self.avatar1)
    lazy var user2 = User(name: "Eric Tsai", email: "ts.eric@gmail.com", avatar: self.avatar2)
    lazy var postComment1 = PostAnswerComment(comment: "Hey I think it's this one", user: user1, lastUpdate: "2019/9/12_09:36", upVoteUser: nil, downVoteUser: nil, movieTitle: nil, movieYear: nil, moviePosterURL: nil)
    lazy var postCommentAnswer1 = PostAnswerComment(comment: "Is it green book?", user: user2, lastUpdate: "2019/9/12_09:25", upVoteUser: [user1,user2], downVoteUser: [], movieTitle: "Green Book", movieYear: 2018, moviePosterURL: URL(string: "https://image.tmdb.org/t/p/w1280/7BsvSuDQuoqhWmU2fL7W2GOcZHU.jpg")!)
    lazy var postQuestion = PostQuestion(title: "A road movie and it is very very good", time: "2 years ago", language: "English", plots: "A black pianist and his driver going on a road trip to perform in the southern states of the US", isSpoiler: false, casts: "Viggo Mortenson", user: user1, lastupdate: "2019/9/12_09:12")
    lazy var post = Post(question: self.postQuestion, comments: [self.postCommentAnswer1, self.postComment1], createTime: Date())
    
    // MARK: -Variables
    lazy var posts = [self.post]
    weak var delegate: AllQuestionViewControllerDelegate?

    // MARK: - Subviews
    var allQuestionTableView: UITableView! = {
        let tableView = UITableView()
        tableView.register(AllQuestionTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .customDimBlue
        return tableView
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

    func addSubviews() {
        self.view.addSubview(allQuestionTableView)
    }
    
    func setupAutoLayout() {
        
        allQuestionTableView.translatesAutoresizingMaskIntoConstraints = false
        allQuestionTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        allQuestionTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        allQuestionTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        allQuestionTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
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
        cell.configureCell(commentNumbers: post.comments.count, questionTitle: post.question.title, questionContent: post.question.plots, isSpoiler: post.question.isSpoiler)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}



protocol AllQuestionViewControllerDelegate: AnyObject {
    func didTapRow(post: Post)
}
