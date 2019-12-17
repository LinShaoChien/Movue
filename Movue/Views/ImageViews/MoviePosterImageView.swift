//
//  MoviePosterImageView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/1.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class MoviePosterImageView: UIImageView {

    var imageURL: URL!
    var poster: UIImage?
    weak var delegate: MoviePosterImageViewDelegate?
    
    init(frame: CGRect, posterURL url: URL) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(posterURL url: URL) {
        self.init(frame: CGRect(x: 0, y: 0, width: 46, height: 82), posterURL: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getImage(withURL url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.poster = UIImage(data: data)
                guard let poster = self.poster else { return }
                self.image = poster
            }
        }.resume()
    }
    
    func setup() {
        self.backgroundColor = .gray
        self.contentMode = .scaleAspectFill
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.examinePoster(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func examinePoster(_: UITapGestureRecognizer) {
        guard let delegate = self.delegate, let poster = self.poster else { return }
        delegate.didTapPoster(poster: poster)
    }
    
}

protocol MoviePosterImageViewDelegate: AnyObject {
    func didTapPoster(poster: UIImage)
}
