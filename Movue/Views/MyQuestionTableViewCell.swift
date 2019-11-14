//
//  MyQuestionTableViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/26.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class MyQuestionTableViewCell: UITableViewCell {

    // MARK: -Variables
    var commentNumbers: Int! = 16
    var questionTitle: String! = "A black pianist and his Italian driver are going on a trip and they are extremely happy"
    var isAnswered: Bool! = true
    
    // MARK: -Subviews
    var numberLabel: TitleLabel!
    var questionTitleLabel: TitleLabel!
    var answeredLabel: RoundedLabel? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(commentNumbers: Int, questionTitle: String) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .customDimLightGrey
        self.selectedBackgroundView = backgroundView
        
        numberLabel = TitleLabel(frame: .zero, text: String(commentNumbers), color: .customDarkBlue, font: UIFont(name: PASSION_ONE.bold, size: 34)!)
        numberLabel.textAlignment = .center
        questionTitleLabel = TitleLabel(frame: .zero, text: questionTitle, color: .customLightBlue, font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 18)!)
        if isAnswered {
            answeredLabel = RoundedLabel(color: .customGreen, text: "answered")
            self.contentView.addSubview(answeredLabel!)
        }
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(questionTitleLabel)
        setupAutolayout()
        setupQuestionLabelAutolayout()
    }
    
    func setupAutolayout() {
        self.numberLabel.translatesAutoresizingMaskIntoConstraints = false
        self.numberLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25).isActive = true
        self.numberLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.numberLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        if let answeredLabel = answeredLabel {
            answeredLabel.translatesAutoresizingMaskIntoConstraints = false
            self.numberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
            answeredLabel.centerXAnchor.constraint(equalTo: self.numberLabel.centerXAnchor).isActive = true
            answeredLabel.topAnchor.constraint(equalTo: self.numberLabel.bottomAnchor, constant: 2).isActive = true
            answeredLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
            answeredLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        } else {
            self.numberLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        }
    }
    
    func setupQuestionLabelAutolayout() {
        self.questionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.questionTitleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.questionTitleLabel.leadingAnchor.constraint(equalTo: self.numberLabel.trailingAnchor, constant: 18).isActive = true
        self.questionTitleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 280 / 375).isActive = true
    }
    
}
