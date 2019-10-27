//
//  AllQuestionTableViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/27.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AllQuestionTableViewCell2: MyQuestionTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var questionContent: String! = "A black pianist and his italian driver were on the road trip to the southern United States."
    var isSpoiler: Bool! = true
    
    // MARK: -Subviews
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
    
    override func configureCell() {
        isAnswered = false
        super.configureCell()
        if isSpoiler {
            spoilerLabel = RoundedLabel(color: .customOrange, text: "spoiler")
            self.contentView.addSubview(spoilerLabel!)
        }
        questionContentLabel = TitleLabel(frame: .zero, text: questionContent, color: .customLightBlue, font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 10)!)
        questionContentLabel.numberOfLines = 1
        self.contentView.addSubview(questionTitleLabel)
        setupStackView()
    }
    
    override func setupAutolayout() {
        if let spoilerLabel = answeredLabel {
            spoilerLabel.translatesAutoresizingMaskIntoConstraints = false
            self.numberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
            spoilerLabel.centerXAnchor.constraint(equalTo: self.numberLabel.centerXAnchor).isActive = true
            spoilerLabel.topAnchor.constraint(equalTo: self.numberLabel.bottomAnchor, constant: 2).isActive = true
            spoilerLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
            spoilerLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        } else {
            self.numberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        }
        
    }
    
    
    func setupStackView() {
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(questionTitleLabel)
        stackView.addArrangedSubview(questionContentLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.numberLabel.trailingAnchor, constant: 18).isActive = true
    }
    
    override func setupQuestionLabelAutolayout() {
        return
    }
}
