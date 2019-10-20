//
//  AvatarViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/9/21.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

class AvatarViewController: UIViewController {

    // MARK: - Subviews
    var titleLabel = SmallLightBlueTitleLabel(text: "Please choose an avatar")
    var avatarImage = AvatarView()
    var segmentedControl = AvatarSegmentedControl()
    var avatarColorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var avatarGlyphCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var doneButton = BigButton(frame: .zero, text: "Done")
    
    // MARK: - Variables
    var selectedColorItem = 1
    var avatarColorCell = "AvatarColorCell"
    var avatarGlyphCell = "AvatarGlyphCell"
    weak var delegate: AvatarViewControllerDelegate?
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupAutolayout()
        configureAvatarColorCollectionView()
        configureAvatarGlyphCollectionView()
        configureSegmentedControl()
        addButtonTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectInitialItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setInitialItemSelectedIndicator()
    }
    
    // MARK: - Helpers
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(avatarImage)
        view.addSubview(segmentedControl)
        view.addSubview(avatarColorCollectionView)
        view.addSubview(avatarGlyphCollectionView)
        view.addSubview(doneButton)
    }
    
    func setupAutolayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if UIScreen.main.bounds.height == 667 {
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        } else {
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        }
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.widthAnchor.constraint(equalToConstant: 176).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: avatarImage.frame.width).isActive = true
        avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if UIScreen.main.bounds.height == 667 {
            avatarImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        } else {
            avatarImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
        }
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if UIScreen.main.bounds.height == 667 {
            segmentedControl.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 30).isActive = true
        } else {
            segmentedControl.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 50).isActive = true
        }
        
        avatarColorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        avatarColorCollectionView.widthAnchor.constraint(equalToConstant: 292).isActive = true
        avatarColorCollectionView.heightAnchor.constraint(equalToConstant: 192).isActive = true
        avatarColorCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if UIScreen.main.bounds.height == 667 {
            avatarColorCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30).isActive = true
        } else {
            avatarColorCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 50).isActive = true
        }
        
        avatarGlyphCollectionView.translatesAutoresizingMaskIntoConstraints = false
        avatarGlyphCollectionView.widthAnchor.constraint(equalToConstant: 292).isActive = true
        avatarGlyphCollectionView.heightAnchor.constraint(equalToConstant: 192).isActive = true
        avatarGlyphCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if UIScreen.main.bounds.height == 667 {
            avatarGlyphCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30).isActive = true
        } else {
            avatarGlyphCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 50).isActive = true
        }
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 284 / 375).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if UIScreen.main.bounds.height == 667 {
            doneButton.topAnchor.constraint(equalTo: avatarColorCollectionView.bottomAnchor, constant: 30).isActive = true
        } else {
            doneButton.topAnchor.constraint(equalTo: avatarColorCollectionView.bottomAnchor, constant: 50).isActive = true
        }
    }
    
    func configureAvatarColorCollectionView() {
        avatarColorCollectionView.delegate = self
        avatarColorCollectionView.dataSource = self
        avatarColorCollectionView.allowsMultipleSelection = false
        avatarColorCollectionView.backgroundColor = .white
        avatarColorCollectionView.register(AvatarColorCollectionViewCell.self, forCellWithReuseIdentifier: avatarColorCell)
    }
    
    func configureAvatarGlyphCollectionView() {
        avatarGlyphCollectionView.delegate = self
        avatarGlyphCollectionView.dataSource = self
        avatarGlyphCollectionView.allowsMultipleSelection = false
        avatarGlyphCollectionView.backgroundColor = .white
        avatarGlyphCollectionView.isHidden = true
        avatarGlyphCollectionView.register(AvatarGlyphCollectionViewCell.self, forCellWithReuseIdentifier: avatarGlyphCell)
    }
    
    func setInitialItemSelectedIndicator() {
        let colorCell = avatarColorCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! AvatarColorCollectionViewCell
        let glyphCell = avatarGlyphCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! AvatarGlyphCollectionViewCell
        colorCell.selectedIndicator.isHidden = false
        glyphCell.selectedIndicator.isHidden = false
    }
    
    func selectInitialItem() {
        avatarColorCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        avatarGlyphCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    func configureSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(self.indexChanged(_:)), for: .valueChanged)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            avatarColorCollectionView.isHidden = false
            avatarGlyphCollectionView.isHidden = true
        case 1:
            avatarColorCollectionView.isHidden = true
            avatarGlyphCollectionView.isHidden = false
        default:
            break
        }
    }
    
    func addButtonTarget() {
        doneButton.addTarget(self, action: #selector(self.dismissAvatarViewController(_:)), for: .touchUpInside)
    }
    
    @objc func dismissAvatarViewController(_ viewController: AvatarViewController) {
        guard let delegate = delegate else { return }
        delegate.willDismissAvatarViewController(self)
    }
}

extension AvatarViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case avatarColorCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: avatarColorCell, for: indexPath) as! AvatarColorCollectionViewCell
            cell.setup(at: indexPath)
            return cell
        case avatarGlyphCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: avatarGlyphCell, for: indexPath) as! AvatarGlyphCollectionViewCell
            cell.setup(at: indexPath)
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
    
}

extension AvatarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case avatarColorCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! AvatarColorCollectionViewCell
            cell.selectedIndicator.isHidden = false
            avatarImage.backgroundColor = cell.colorView.backgroundColor
        case avatarGlyphCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! AvatarGlyphCollectionViewCell
            cell.selectedIndicator.isHidden = false
            avatarImage.imageView.image = UIImage(named: "white-glyph-\(indexPath.item + 1).png")
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView {
        case avatarColorCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! AvatarColorCollectionViewCell
            cell.selectedIndicator.isHidden = true
        case avatarGlyphCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! AvatarGlyphCollectionViewCell
            cell.selectedIndicator.isHidden = true
        default:
            break
        }
    }
}

extension AvatarViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 44, height: 44)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

protocol AvatarViewControllerDelegate: AnyObject {
    func willDismissAvatarViewController(_ viewController: AvatarViewController)
}
