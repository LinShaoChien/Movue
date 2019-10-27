//
//  AllQuestionsViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AllQuestionsViewController: UIViewController {

    // MARK: - Subviews
    let titleView = TitleView(title: "All Questions")
    var allQuestionTableView: UITableView! = {
        let tableView = UITableView()
        tableView.register(AllQuestionTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .customDarkBlue
        return tableView
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allQuestionTableView.delegate = self
        allQuestionTableView.dataSource = self
        addSubviews()
        setupAutoLayout()
        self.view.backgroundColor = .white
    }

    func addSubviews() {
        self.view.addSubview(titleView)
        self.view.addSubview(allQuestionTableView)
    }
    
    func setupAutoLayout() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        
        allQuestionTableView.translatesAutoresizingMaskIntoConstraints = false
        allQuestionTableView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        allQuestionTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        allQuestionTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        allQuestionTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
}

extension AllQuestionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AllQuestionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllQuestionTableViewCell
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
