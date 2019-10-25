//
//  FloatingTitleTextView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/25.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class FloatingTitleTextView: UIView {
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        self.titleText = title
        setup()
    }
    
    convenience init(title: String) {
        self.init(frame: .zero, title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleText: String!
    var titleLabel: UILabel!
    var textView: UITextView!

    func setup() {
        textView = UITextView(frame: .zero, textContainer: nil)
        addSubview(textView)
        textView.textAlignment = .left
        textView.isEditable = true
        textView.typingAttributes = [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 14)!,
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue,
            NSAttributedString.Key.kern: 1.5
        ]
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 10, bottom: 10, right: 10)
        textView.showsVerticalScrollIndicator = false
        textView.layer.borderWidth = 2.0
        textView.layer.borderColor = UIColor.customLightBlue.cgColor
        textView.layer.backgroundColor = UIColor.clear.cgColor
        textView.layer.cornerRadius = 8.0
        textView.layer.masksToBounds = true
        
        titleLabel = UILabel()
        addSubview(titleLabel)
        
        titleLabel.text = "  " + titleText + "  "
        titleLabel.frame = CGRect(x: 0, y: 0, width: titleLabel.intrinsicContentSize.width, height: titleLabel.intrinsicContentSize.height)
        titleLabel.textColor = UIColor.customDarkBlue
        titleLabel.font = UIFont(name: APPLE_SD_GOTHIC_NEO.medium, size: 14.0)
        titleLabel.backgroundColor = UIColor.white

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 24).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
