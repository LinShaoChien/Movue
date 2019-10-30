//
//  QuestionTableViewCell.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/27.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class QuestionPostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // MARK: -Variables
    var timeText: String! = "4 years ago"
    var languageText: String! = "english"
    var plotText: String! = "A black pianist and his italian driver were on the road trip to the southern United States. I remember they ate Kentucky Fried Chicken on the road and threw the bones outside the window."
    var castText: String! = "Viggo Mortenson"
    
    var nicknameText: String! = "Aaron Lin"
    var time: String! = "2019/9/11_09:12"
    var avatarColor: UIColor! = UIColor.AvatarColors[0]
    var avatarGlyph: UIImage! = UIImage(named: "white-glyph-1.png")!
    
    // MARK: -Subviews
    var headerView = UIView()
    
    var seperator1: SeperatorView! = {
        let view = SeperatorView.white()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var seperator2: SeperatorView! = {
        let view = SeperatorView.white()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var seperator3: SeperatorView! = {
        let view = SeperatorView.white()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var seperator4: SeperatorView! = {
        let view = SeperatorView.white()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var stackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 15
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var timeView: QuestionAnswerView!
    var languageView: QuestionAnswerView!
    var plotView: QuestionAnswerView!
    var castView: QuestionAnswerView!
    var signatureView: SignatureView!
    
    var footerView = UIView()
    
    // MARK: -Helpers
    func configure() {
        self.contentView.backgroundColor = UIColor(displayP3Red: 237 / 256, green: 237 / 256, blue: 237 / 256, alpha: 100)
        addSubview()
        setupSubviews()
        setupStackView()
        setupAutolayout()
    }
    
    func setupSubviews() {
        timeView = QuestionAnswerView(question: "When did i watch this movie", answer: self.timeText)
        languageView = QuestionAnswerView(question: "The language of this movie", answer: self.languageText)
        plotView = QuestionAnswerView(question: "Plots of this movie", answer: self.plotText)
        castView = QuestionAnswerView(question: "Casts of this movie", answer: self.castText)
        signatureView = SignatureView(frame: .zero, nickname: nicknameText, time: time, avatarColor: avatarColor, avatarGlyph: avatarGlyph)
    }
    
    func addSubview() {
        self.contentView.addSubview(stackView)
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(timeView)
        stackView.addArrangedSubview(seperator1)
        stackView.addArrangedSubview(languageView)
        stackView.addArrangedSubview(seperator2)
        stackView.addArrangedSubview(plotView)
        stackView.addArrangedSubview(seperator3)
        stackView.addArrangedSubview(castView)
        stackView.addArrangedSubview(seperator4)
        stackView.addArrangedSubview(signatureView)
        stackView.addArrangedSubview(footerView)

        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
    
    func setupAutolayout() {
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -30).isActive = true
        languageView.translatesAutoresizingMaskIntoConstraints = false
        languageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -30).isActive = true
        plotView.translatesAutoresizingMaskIntoConstraints = false
        plotView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -30).isActive = true
        castView.translatesAutoresizingMaskIntoConstraints = false
        castView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -30).isActive = true
        
        seperator1.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        seperator1.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        seperator2.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        seperator2.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        seperator3.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        seperator3.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        seperator4.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        seperator4.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
    }
}
