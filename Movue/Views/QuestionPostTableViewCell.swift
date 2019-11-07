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
    var titleText: String! = "A Black man and his driver"
    var timeText: String! = "4 years ago"
    var languageText: String! = "english"
    var plotText: String! = "A black pianist and his italian driver were on the road trip to the southern United States. I remember they ate Kentucky Fried Chicken on the road and threw the bones outside the window."
    var castText: String! = "Viggo Mortenson"
    var isSpoiler: Bool! = true
    
    var nicknameText: String! = "Aaron Lin"
    var time: String! = "2019/9/11_09:12"
    var avatarColor: UIColor! = UIColor.AvatarColors[0]
    var avatarGlyph: UIImage! = UIImage(named: "white-glyph-1.png")!
    weak var delegate: QuestionPostTableViewCellDelegate?
    
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
    
    lazy var stackView: UIStackView! = {
        let stackView = UIStackView(arrangedSubviews: [
            self.headerView,
            self.timeView,
            self.seperator1,
            self.languageView,
            self.seperator2,
            self.plotView,
            self.seperator3,
            self.castView,
            self.seperator4,
            self.signatureView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 15
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var timeView: QuestionAnswerView! = {
        let timeView = QuestionAnswerView(question: "When did i watch this movie", answer: self.timeText)
        timeView.translatesAutoresizingMaskIntoConstraints = false
        return timeView
    }()
    lazy var languageView: QuestionAnswerView! = {
        let languageView = QuestionAnswerView(question: "The language of this movie", answer: self.languageText)
        languageView.translatesAutoresizingMaskIntoConstraints = false
        return languageView
    }()
    lazy var plotView: QuestionAnswerView! = {
        let plotView = QuestionAnswerView(question: "Plots of this movie", answer: self.plotText)
        plotView.translatesAutoresizingMaskIntoConstraints = false
        return plotView
    }()
    lazy var castView: QuestionAnswerView! = {
        let castView = QuestionAnswerView(question: "Casts of this movie", answer: self.castText)
        castView.translatesAutoresizingMaskIntoConstraints = false
        return castView
    }()
    lazy var signatureView: SignatureView! = {
        let signatureView = SignatureView(frame: .zero, nickname: nicknameText, time: time, avatarColor: avatarColor, avatarGlyph: avatarGlyph)
        return signatureView
    }()
    
    var footerView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var editButton: EditButton! = {
        let view = EditButton()
        view.addTarget(self, action: #selector(self.editButtonTap(_:)), for: .touchUpInside)
        return view
    }()
    
    // MARK: -Helpers
    func configure() {
        self.contentView.backgroundColor = .customDimLightGrey
        addSubview()
        setupAutolayout()
    }

    func addSubview() {
        self.contentView.addSubview(stackView)
        self.contentView.addSubview(footerView)
        self.contentView.addSubview(editButton)
    }
    
    @objc func editButtonTap(_: EditButton!) {
        if let delegate = self.delegate {
            delegate.didTapEditButton(cell: self)
        }
    }
    
    func setupAutolayout() {
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true

        timeView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -30).isActive = true
        languageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -30).isActive = true
        plotView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -30).isActive = true
        castView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -30).isActive = true
        
        seperator1.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        seperator1.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        seperator2.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        seperator2.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        seperator3.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        seperator3.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        seperator4.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        seperator4.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        footerView.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        footerView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        footerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        editButton.widthAnchor.constraint(equalToConstant: 53).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        editButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 25).isActive = true
        editButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
    }
}

protocol QuestionPostTableViewCellDelegate: AnyObject {
    func didTapEditButton(cell: QuestionPostTableViewCell)
}
