//
//  AnswerViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AnswerMovieViewController: UIViewController {
    
    // MARK: -Variables
    var movies: [Movie] = [
        Movie(title: "Green Book", year: 2018),
        Movie(title: "Green Street", year: 2007),
        Movie(title: "The Green Mile", year: 1999)
        ] {
        didSet {
            updateMovieList()
        }
    }
    
    var isResultEmpty: Bool {
        if movies.count == 0 {
            return true
        }
        return false
    }
    
    var userSelectedMovie: Movie?
    
    // MARK: -Subviews
    var titleLabel: UILabel! = {
        let view = UILabel()
        view.attributedText = NSAttributedString(string: "Search and Select Movie", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue,
            NSAttributedString.Key.font: UIFont(name: PASSION_ONE.bold, size: 25)!        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textField: FloatingLabelTextFieldView = {
        let view = FloatingLabelTextFieldView(placeholderText: "Movie Title")
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
    
    lazy var movieListStackView: UIStackView! = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 20
        view.distribution = .equalSpacing
        view.alignment = .leading
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var nextButton: UIButton! = {
        let button = BigButton(frame: .zero, text: "Next")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushAnswerCommentViewController(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: -Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAutolayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removieMovieListStackViewSubviews()
        movies = [
        Movie(title: "Green Book", year: 2018),
        Movie(title: "Green Street", year: 2007),
        Movie(title: "The Green Mile", year: 1999)
        ]
    }

    // MARK: -Helpers
    func setup() {
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(textField)
        self.view.addSubview(movieListStackView)
        self.view.addSubview(nextButton)
    }
    
    func setupAutolayout() {
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        
        textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        textField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 284/375).isActive = true
        
        movieListStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        movieListStackView.widthAnchor.constraint(equalTo: textField.widthAnchor, multiplier: 0.9).isActive = true
        movieListStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15).isActive = true
        
        nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 284 / 375).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    func updateMovieList() {
        if isResultEmpty {
            let emptyLabel: UILabel! = {
                let label = UILabel()
                label.attributedText = NSAttributedString(string: "No Result", attributes: [
                    NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 20)!,
                    NSAttributedString.Key.foregroundColor: UIColor.customLightBlue
                ])
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            movieListStackView.addArrangedSubview(emptyLabel)
        } else {
            for movie in movies {
                let button = TitleNYearButton(movie: movie)
                button.addTarget(self, action: #selector(fillTextfield(_:)), for: .touchUpInside)
                movieListStackView.addArrangedSubview(button)
                button.heightAnchor.constraint(equalToConstant: 20).isActive = true
                button.leadingAnchor.constraint(equalTo: movieListStackView.leadingAnchor).isActive = true
                button.trailingAnchor.constraint(equalTo: movieListStackView.trailingAnchor).isActive = true
            }
        }
    }
    
    @objc func fillTextfield(_ sender: UIButton) {
        let button = sender as! TitleNYearButton
        let movie = button.movie
        self.userSelectedMovie = movie
        let title = movie?.title
        self.textField.textfield.text = title
        removieMovieListStackViewSubviews()
    }
    
    @objc func pushAnswerCommentViewController(_ sender: UIButton) {
        let navigator = self.navigationController as! AnswerNavigationController
        if let movie = userSelectedMovie {
            navigator.movie = movie
            let viewController = AnswerCommentViewController()
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            // Tell user no valid movie is selected
        }
    }
    
    func removieMovieListStackViewSubviews() {
        let subviews = movieListStackView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}
