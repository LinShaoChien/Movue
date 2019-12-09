//
//  MyQuestionTableViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/26.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class MyQuestionTableViewCell: UITableViewCell {
    
    // MARK: -Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let backgroundView = UIView()
        self.selectedBackgroundView = backgroundView
        backgroundView.backgroundColor = .customDimLightGrey
        
        numberLabel = TitleLabel(frame: .zero, text: " ", color: .customDarkBlue, font: UIFont(name: PASSION_ONE.bold, size: 34)!)
        numberLabel.textAlignment = .center
        questionTitleLabel = TitleLabel(frame: .zero, text: " ", color: .customLightBlue, font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 18)!)
        
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(questionTitleLabel)
        setupAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Subviews
    var questionTitleLabel = TitleLabel()
    var numberLabel = TitleLabel()
    var answeredLabel: RoundedLabel? = nil
    
    func setupAutolayout() {
        self.numberLabel.translatesAutoresizingMaskIntoConstraints = false
        self.numberLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25).isActive = true
        self.numberLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.numberLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.numberLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        self.questionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.questionTitleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.questionTitleLabel.leadingAnchor.constraint(equalTo: self.numberLabel.trailingAnchor, constant: 18).isActive = true
        self.questionTitleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 280 / 375).isActive = true
    }
    
    func update(questionTitle: String, numberLabel: Int) {
        self.questionTitleLabel.text = questionTitle
        let numberString = String(numberLabel)
        self.numberLabel.text = numberString
    }
}
