//
//  SignatureView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/29.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class SignatureView: UIView {

    var avatarColor: UIColor!
    var avatarGlyph: UIImage!
    var nicknameText: String!
    var timeText: String!
    
    init(frame: CGRect, nickname: String, time: String, avatarColor: UIColor, avatarGlyph: UIImage) {
        super.init(frame: frame)
        
        self.avatarColor = avatarColor
        self.avatarGlyph = avatarGlyph
        self.nicknameText = nickname
        self.timeText = time
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var avatarView: AvatarView!
    var nicknameLabel: UILabel!
    var timeLabel: UILabel!
    
    func setup() {
        avatarView = AvatarView(frame: CGRect(x: 0, y: 0, width: 26, height: 26), color: avatarColor, image: avatarGlyph)
        nicknameLabel = UILabel()
        nicknameLabel.attributedText = NSAttributedString(string: nicknameText, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue,
            NSAttributedString.Key.font: UIFont(name: PASSION_ONE.bold, size: 14)!
        ])
        timeLabel = UILabel()
        timeLabel.attributedText = NSAttributedString(string: timeText, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue,
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 12)!,
            NSAttributedString.Key.kern: NSNumber(value: 1.0)
        ])
        self.addSubview(avatarView)
        self.addSubview(nicknameLabel)
        self.addSubview(timeLabel)
        setupAutolayout()
    }
    
    func setupAutolayout() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        avatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        nicknameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nicknameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 10).isActive = true
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 3).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: nicknameLabel.leadingAnchor).isActive = true
        
        self.translatesAutoresizingMaskIntoConstraints = true
    }
}
