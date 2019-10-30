//
//  MyQuestionsViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class MyQuestionsViewController: UIViewController {

    // MARK: - Subviews
    let titleView = TitleView(title: "My Questions")
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
    }

    func addSubviews() {
        self.view.addSubview(titleView)
        self.view.addSubview(myQuestionTableView)
    }
    
    func setupAutoLayout() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        
        myQuestionTableView.translatesAutoresizingMaskIntoConstraints = false
        myQuestionTableView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        myQuestionTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myQuestionTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myQuestionTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

extension MyQuestionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MyQuestionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyQuestionTableViewCell
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
