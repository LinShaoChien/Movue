//
//  AnswerViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/17.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit
import SwiftyJSON

class AnswerMovieViewController: UIViewController {
    
    // MARK: -Variables
    var movies: [Movie] = [] {
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
    
    var movieQueryString: String!
    
    var userSelectedMovie: Movie?
    
    var df: DateFormatter! = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-mm-dd"
        return df
    }()
    
    var yearDF: DateFormatter! = {
        let df = DateFormatter()
        df.dateFormat = "yyyy"
        return df
    }()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeMovieListStackViewSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // getMovies()
    }

    // MARK: -Helpers
    func setup() {
        addDismissOnTap()
        self.textField.textfield.delegate = self
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
    
    func getMovies() {
        guard let queryString = self.movieQueryString else { return }
        print("get movie with: \(queryString)")
        let session = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=2f2ef9e67070291a465913478c8325ef&query=\(queryString)&page=1&include_adult=true")!
        let task = session.dataTask(with: url) { (data, response, error) in
            var movies = [Movie]()
            if let error = error {
                // Handle error
                return
            }
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let results = json["results"].arrayValue
                    var i = -1
                    var j = 0
                    let resultCount = results.count
                    switch resultCount {
                    case 7...:
                        i = 6
                    case 0:
                        i = -1
                    default:
                        i = resultCount - 1
                    }
                    while i >= 0 {
                        let result = results[j]
                        let title = result["title"].stringValue
                        let releaseDate = result["release_date"].stringValue
                        let date = self.df.date(from: releaseDate) ?? Date()
                        let year = Int(self.yearDF.string(from: date))!
                        let posterPath = result["poster_path"].stringValue
                        let movie = Movie(title: title, year: year, posterPath: posterPath)
                        movies.append(movie)
                        i -= 1
                        j += 1
                    }
                } catch let error {
                    // Handle error
                }
                DispatchQueue.main.async {
                    self.movies = movies
                }
            }
        }
        task.resume()
    }
    
    func updateMovieList() {
        removeMovieListStackViewSubviews()
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
    
    func removeMovieListStackViewSubviews() {
        let subviews = movieListStackView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}

extension AnswerMovieViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldString = textField.text! as NSString
        let newString = oldString.replacingCharacters(in: range, with: string)
        let length = textField.text!.count + string.count - range.length
        if length >= 2 {
            let str = newString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            self.movieQueryString = str
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.getMovies()
            }
        }
        return true
    }
}
