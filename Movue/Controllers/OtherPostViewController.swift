//
//  OtherPostViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/13.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.navigationItem.largeTitleDisplayMode = .never
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.isTabBarHidden = true
        }
        setupAutolayout()
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
            cell.configure(postComment: self.post.comments[indexPath.row])
            
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
