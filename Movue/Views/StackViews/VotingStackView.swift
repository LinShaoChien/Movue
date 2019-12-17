//
//  VotingStackView.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/30.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

enum VoteStatus {
    case up
    case down
    case none
}

class VotingStackView: UIStackView {

    // MARK: -Initializers
    init(frame: CGRect, voteNumber: Int, status: VoteStatus) {
        super.init(frame: frame)
        self.voteNumber = voteNumber
        setupStackView()
        setupAutoLayout()
    }
    
    convenience init(voteNumber: Int, status: VoteStatus) {
        self.init(frame: .zero, voteNumber: voteNumber, status: status)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Variables
    var voteNumber: Int!
    var voteStatus: VoteStatus!
    
    // MARK: -Subviews
    lazy var upvoteButton: TriangleButton! = {
        let view = TriangleButton(frame: CGRect(x: 0, y: 0, width: 30, height: 17), regualrTriangle: true)
        switch self.voteStatus {
        case .up:
            view.backgroundColor = .customGreen
        default:
            view.backgroundColor = .white
        }
        view.addMask()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var downVoteButton: TriangleButton! = {
        let view = TriangleButton(frame: CGRect(x: 0, y: 0, width: 30, height: 17), regualrTriangle: false)
        switch self.voteStatus {
        case .down:
            view.backgroundColor = .customOrange
        default:
            view.backgroundColor = .white
        }
        view.addMask()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var voteLabel: TitleLabel! = {
        let label = TitleLabel(frame: .zero, text: String(self.voteNumber), color: UIColor.customDarkBlue, font: UIFont(name: PASSION_ONE.bold, size: 28)!)
        label.textAlignment = .center
        label.sizeToFit()
        label.backgroundColor = .clear
        return label
    }()
    
    // MARK: -Helpers
    func setupStackView() {
        self.addArrangedSubview(upvoteButton)
        self.addArrangedSubview(voteLabel)
        self.addArrangedSubview(downVoteButton)
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.spacing = 5
        self.alignment = .center
    }
    
    func setupAutoLayout() {
        upvoteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        upvoteButton.heightAnchor.constraint(equalToConstant: 17).isActive = true
        downVoteButton.heightAnchor.constraint(equalToConstant: 17).isActive = true
        downVoteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func changeButtonBackgroundColor(withStatus status: VoteStatus) {
        self.voteStatus = status
        switch status {
        case .up:
            upvoteButton.backgroundColor = .customOrange
            downVoteButton.backgroundColor = .white
        case .down:
            upvoteButton.backgroundColor = .white
            downVoteButton.backgroundColor = .customGreen
        case .none:
            upvoteButton.backgroundColor = .white
            downVoteButton.backgroundColor = .white
        }
    }

}

