//
//  AllQuestionTableViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/27.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AllQuestionTableViewCell: UITableViewCell {

    // MARK: -Variables
    var commentNumbers: Int! = 16
    var questionTitle: String! = "A black pianist and his Italian driver are going on a trip and they are extremely happy"
    var questionContent: String! = "A black pianist and his italian driver were on the road trip to the southern United States."
    var isSpoiler: Bool! = true
    
    // MARK: -Subviews
    var numberLabel: TitleLabel!
    var questionTitleLabel: TitleLabel!
    var spoilerLabel: RoundedLabel? = nil
    var questionContentLabel: TitleLabel!
    var stackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        return stackView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .customDimBlue
        self.selectedBackgroundView = backgroundView
        
        numberLabel = TitleLabel(frame: .zero, text: String(commentNumbers), color: .customDarkBlue, font: UIFont(name: PASSION_ONE.bold, size: 34)!)
        numberLabel.textAlignment = .center
        questionTitleLabel = TitleLabel(frame: .zero, text: questionTitle, color: .customDarkBlue, font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 20)!)
        questionContentLabel = TitleLabel(frame: .zero, text: questionContent, color: .customLightBlue, font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 12)!)
               questionContentLabel.numberOfLines = 1
        if isSpoiler {
            spoilerLabel = RoundedLabel(color: .customOrange, text: "spoiler")
            self.contentView.addSubview(spoilerLabel!)
        }
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(questionTitleLabel)
        setupAutolayout()
        setupStackView()
    }
    
    func setupAutolayout() {
        self.numberLabel.translatesAutoresizingMaskIntoConstraints = false
        self.numberLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25).isActive = true
        self.numberLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.numberLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        if let spoilerLabel = spoilerLabel {
            spoilerLabel.translatesAutoresizingMaskIntoConstraints = false
            self.numberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
            spoilerLabel.centerXAnchor.constraint(equalTo: self.numberLabel.centerXAnchor).isActive = true
            spoilerLabel.topAnchor.constraint(equalTo: self.numberLabel.bottomAnchor, constant: 2).isActive = true
            spoilerLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
            spoilerLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        } else {
            self.numberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        }
        self.questionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.questionTitleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.questionContentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.questionContentLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setupStackView() {
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(questionTitleLabel)
        stackView.addArrangedSubview(questionContentLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.numberLabel.trailingAnchor, constant: 18).isActive = true
    }
    
}
