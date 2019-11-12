//
//  PosterViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/1.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class PosterViewController: UIViewController {
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, poster: UIImage) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.poster = poster
    }
    
    convenience init(poster: UIImage) {
        self.init(nibName: nil, bundle: nil, poster: poster)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var poster: UIImage!
    
    lazy var imageView: UIImageView! = {
        let view = UIImageView(image: self.poster)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var gestureIndicator: UIView! = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customLightGrey
        view.layer.cornerRadius = 3
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAutolayout()
    }
    
    func setup() {
        self.view.addSubview(imageView)
        self.view.addSubview(gestureIndicator)
    }
    
    func setupAutolayout() {
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 650).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        self.gestureIndicator.widthAnchor.constraint(equalToConstant: 120).isActive = true
        self.gestureIndicator.heightAnchor.constraint(equalToConstant: 6).isActive = true
        self.gestureIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.gestureIndicator.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
    }
}
