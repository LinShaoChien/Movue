//
//  AnswerViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    // MARK: -Variables
    var movies: [Movie] = [
        Movie(title: "Green Book", year: 2018),
        Movie(title: "Green Street", year: 2007),
        Movie(title: "The Green Mile", year: 1999)
    ]
    
    var isResultEmpty: Bool {
        if movies.count == 0 {
            return true
        }
        return false
    }
    // MARK: -Subviews
    var titleLabel: UILabel! = {
        let view = UILabel()
        view.attributedText = NSAttributedString(string: "Search and Select Movie", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue,
            NSAttributedString.Key.font: UIFont(name: PASSION_ONE.bold, size: 25)!        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textField: FloatingLabelTextField = {
        let view = FloatingLabelTextField(placeholderText: "Movie Title")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var noResultLabel: UILabel = {
        let view = UILabel()
        view.attributedText = NSAttributedString(string: "No Result", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customLightBlue,
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 20)!
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var tableView: UITableView! = {
        let view = UITableView()
        return view
    }()
    
    // MARK: -Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAutolayout()
    }

    // MARK: -Helpers
    func setup() {
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(textField)
        self.view.addSubview(tableView)
        self.view.addSubview(noResultLabel)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupAutolayout() {
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        
        textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        textField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 284/375).isActive = true
        
        noResultLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 5).isActive = true
        noResultLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
    }

}

extension AnswerViewController: UITableViewDelegate {
    
}

extension AnswerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}
