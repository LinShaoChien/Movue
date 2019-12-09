//
//  QuestionViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/29.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class MyPostViewController: UIViewController {

    // MARK: -Init
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
    
    // MARK: -Variables
    var post: Post!
    
    
    
    // MARK: -Lifecycles
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismiss(_:)), name: .didUpdateQuestion, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let tabBarController = self.tabBarController as? MainTabBarController {
            tabBarController.isTabBarHidden = false
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: -Subviews
    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.register(QuestionPostTableViewCell.self, forCellReuseIdentifier: "QuestionPostCell")
        tableView.register(CommentPostTableViewCell.self, forCellReuseIdentifier: "CommentPostCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // MARK: -Helpers
    func setupAutolayout() {
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    @objc func dismiss(_: Notification) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension MyPostViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
}

extension MyPostViewController: UITableViewDataSource {

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
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionPostCell", for: indexPath) as! QuestionPostTableViewCell
            cell.delegate = self
            cell.configure(postQuestion: post.question)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentPostCell", for: indexPath) as! CommentPostTableViewCell
            cell.configure(postComment: post.comments[indexPath.row])
            if let voteStackView = cell.stackView.arrangedSubviews[1] as? UIStackView {
                let posterImageView = voteStackView.arrangedSubviews[1] as! MoviePosterImageView
                posterImageView.delegate = self
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MyPostViewController: MoviePosterImageViewDelegate {
    
    func didTapPoster(poster: UIImage) {
        let vc = PosterViewController(poster: poster)
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension MyPostViewController: QuestionPostTableViewCellDelegate {
    
    func didTapEditButton(cell: QuestionPostTableViewCell) {
        let view = AskQuestionPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, questionTitle: cell.titleText, questionTime: cell.timeText, questionPlot: cell.plotText, questionLanguage: cell.languageText, questionCast: cell.castText, questionSpoiler: cell.isSpoiler)
        view.isEditMode = true
        view.uuid = post.question.id
        self.present(view, animated: true, completion: nil)
    }
    
}
