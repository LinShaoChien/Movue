//
//  TitleNYearButton.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class TitleNYearButton: UIButton {

    // MARK: -Variables
    var movie: Movie!
    
    // MARK: -Inits
    init(frame: CGRect, movie: Movie) {
        super.init(frame: frame)
        self.movie = movie
        setup()
    }
    
    convenience init(movie: Movie) {
        self.init(frame: .zero, movie: movie)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Subviews
    lazy var stackView: TitleNYearHorizontalStackView = {
        let view = TitleNYearHorizontalStackView(movie: self.movie)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    // MARK: -Helpers
    func setup() {
        addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
