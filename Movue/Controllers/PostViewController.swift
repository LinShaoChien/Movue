//
//  QuestionViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/29.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        setupAutolayout()
    }
    
    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.register(QuestionPostTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(CommentPostTableViewCell.self, forCellReuseIdentifier: "Cell2")
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

extension PostViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
}

extension PostViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! QuestionPostTableViewCell
            cell.configure()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! CommentPostTableViewCell
            cell.configure()
            let voteStackView = cell.stackView.arrangedSubviews[1] as! UIStackView
            let posterImageView = voteStackView.arrangedSubviews[1] as! MoviePosterImageView
            posterImageView.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension PostViewController: MoviePosterImageViewDelegate {
    
    func didTapPoster(poster: UIImage) {
        let vc = PosterViewController(poster: poster)
        self.present(vc, animated: true, completion: nil)
    }
    
}
