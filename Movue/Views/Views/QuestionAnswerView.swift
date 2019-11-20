//
//  QuestionAnswerView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/29.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class QuestionAnswerView: UIView {

    init(frame: CGRect, question: String, answer: String) {
        super.init(frame: frame)
        self.questionText = question
        self.answerText = answer
        setupSubviews()
        setupAutolayout()
    }
    
    convenience init(question: String, answer: String) {
        self.init(frame: .zero, question: question, answer: answer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var questionText: String!
    var answerText: String!
    
    var questionLabel: UILabel! = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var answerLabel: UILabel! = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupSubviews() {
        self.addSubview(questionLabel)
        self.addSubview(answerLabel)
        
        questionLabel.attributedText = NSAttributedString(string: questionText, attributes: [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 12)!,
            NSAttributedString.Key.foregroundColor: UIColor.customLightBlue
        ])
        
        answerLabel.attributedText = NSAttributedString(string: answerText, attributes: [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 18)!,
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue
        ])
    }
    
    func setupAutolayout() {
        questionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        questionLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        answerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 10).isActive = true
        answerLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        answerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
