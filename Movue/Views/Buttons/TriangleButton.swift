//
//  TriangleButton.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/11/1.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class TriangleButton: UIButton {

    private var path: UIBezierPath!
    var isRegularTriangle: Bool!
    weak var delegate: TriangleButtonDelegate?
    
    init(frame: CGRect, regualrTriangle: Bool) {
        super.init(frame: frame)
        self.isRegularTriangle = regualrTriangle
        if isRegularTriangle {
            createRegularTrianglePath()
        } else {
            createInvertedTranglePath()
        }
        addMask()
    }
    
    convenience init(regularTriangle: Bool) {
        self.init(frame: .zero, regualrTriangle: regularTriangle)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func createRegularTrianglePath() {
        self.path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width/2, y: 0.0))
        path.close()
    }
    
    private func createInvertedTranglePath() {
        self.path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        path.close()
    }
    
    func addMask() {
        let mask = CAShapeLayer()
        mask.path = self.path.cgPath
        self.layer.mask = mask
        self.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.didTapButton(button: self)
    }

}

protocol TriangleButtonDelegate: AnyObject {
    func didTapButton(button: TriangleButton)
}
