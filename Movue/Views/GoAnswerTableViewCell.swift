//
//  GoAnswerTableViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/14.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class GoAnswerTableViewCell: UITableViewCell {

    var answerButton: BigButton! = {
        let button = BigButton(frame: .zero, text: "I got an answer")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    func configure() {
        self.contentView.addSubview(answerButton)
        self.answerButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 280 / 375).isActive = true
        self.answerButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        self.answerButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.answerButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
}
