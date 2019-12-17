//
//  AskingPageViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AskQuestionPageViewController: UIPageViewController {
    
    // MARK: -Initializers
    init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil, questionTitle: String?, questionTime: String?, questionPlot: String?, questionLanguage: String?, questionCast: String?, questionSpoiler: Bool) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
        self.questionTitle = questionTitle
        self.questionTime = questionTime
        self.questionPlot = questionPlot
        self.questionLanguage = questionLanguage
        self.questionCast = questionCast
        self.questionSpoiler = questionSpoiler
    }
    
    convenience override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        self.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options, questionTitle: nil, questionTime: nil, questionPlot: nil, questionLanguage: nil, questionCast: nil, questionSpoiler: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Subviews
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let nextButton = UIButton()
    let prevButton = UIButton()
    lazy var doneButton: UIButton! = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Done", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue,
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 18)!
        ]), for: .normal)
        button.isHidden = true
        return button
    }()
    lazy var gestureIndicator: UIView! = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customLightGrey
        view.layer.cornerRadius = 3
        return view
    }()
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .customLightBlue
        spinner.isHidden = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: -Variables
    let initialPage = 0
    var questionTitle: String? = nil
    var questionTime: String? = nil
    var questionPlot: String? = nil
    var questionLanguage: String? = nil
    var questionCast: String? = nil
    var questionSpoiler: Bool! = false
    
    var isEditMode: Bool = false
    var uuid: String?
    
    // MARK: -Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtonsTarget()
        setup()
        addSubviews()
        setupPages()
        setupAutolayout()
        setupPageControl()
        setupButtons()
        setupTapGestureRecognizer()
    }
    
    // MARK: -Helpers
    func setup() {
        self.view.backgroundColor = .white
        self.delegate = self
        self.prevButton.isHidden = true
    }
    
    func addSubviews() {
        self.view.addSubview(self.pageControl)
        self.view.addSubview(nextButton)
        self.view.addSubview(prevButton)
        self.view.addSubview(gestureIndicator)
        self.view.addSubview(doneButton)
        self.view.addSubview(spinner)
    }
    
    func setupAutolayout() {
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        self.nextButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor).isActive = true
        self.nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        
        self.prevButton.translatesAutoresizingMaskIntoConstraints = false
        self.prevButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor).isActive = true
        self.prevButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        
        self.doneButton.translatesAutoresizingMaskIntoConstraints = false
        self.doneButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor).isActive = true
        self.doneButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45).isActive = true
        
        self.gestureIndicator.widthAnchor.constraint(equalToConstant: 120).isActive = true
        self.gestureIndicator.heightAnchor.constraint(equalToConstant: 6).isActive = true
        self.gestureIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.gestureIndicator.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.spinner.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
    }
    
    func setupPages() {
        let page1 = AskViewController(title: "1. Question Title", subtitle: "Please provide a title for your question. Your title should be the major plot of the film.", floatingTextfieldTitle: "Title",
                                      firstInstructionView: InstructionView(minorTitle: "Use Something Like...", majorTitle: "A black pianist and a Italian driver", titleColor: .customGreen),
                                      secondInstructionView: InstructionView(minorTitle: "Avoid...", majorTitle: "Can't remember this movie", titleColor: .customOrange))
        page1.textField?.textfield.delegate = self
        let page2 = AskViewController(title: "2. Time", subtitle: "Please provide the time you watch this movie. It maybe a specific time or just a rough time.", floatingTextfieldTitle: "Time",
                                      firstInstructionView: InstructionView(minorTitle: "Use Something Like...", majorTitle: "I think it's 2017", titleColor: .customGreen),
                                      secondInstructionView: InstructionView(minorTitle: "It may also be a rough time", majorTitle: "Around 5 years ago", titleColor: .customGreen))
        page2.textField?.textfield.delegate = self
        let page3 = AskViewController(title: "3. Language", subtitle: "Please provide the language the characters speak in the movie.", floatingTextfieldTitle: "Language",
                                      firstInstructionView: InstructionView(minorTitle: "Use Something Like...", majorTitle: "English, Chinese", titleColor: .customGreen),
                                      secondInstructionView: InstructionView(minorTitle: "You may also specify the accent like …", majorTitle: "English with Brtish accent", titleColor: .customGreen))
        page3.textField?.textfield.delegate = self
        let page4 = AskPlotViewController(title: "4. Plots", subtitle: "Please provide the plot of the movie. It may be a single plot or multiple plots.", floatingTitleTextView: FloatingTitleTextView(title: "Plots"))
        let page5 = AskViewController(title: "5. Casts", subtitle: "Please provide the casts starring in this movie", floatingTextfieldTitle: "Casts", firstInstructionView: InstructionView(minorTitle: "Use something like...", majorTitle: "Leonardo Dicappio", titleColor: .customGreen), secondInstructionView: InstructionView(minorTitle: "You can also use multiple casts...", majorTitle: "Leonardo Dicappio, Kate Winslet", titleColor: .customGreen))
        page5.textField?.textfield.delegate = self
        page5.textField?.textfield.returnKeyType = .done
        self.pages.append(page1)
        self.pages.append(page2)
        self.pages.append(page3)
        self.pages.append(page4)
        self.pages.append(page5)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        if let title = self.questionTitle, let time = self.questionTime, let language = self.questionLanguage, let plot = self.questionPlot, let cast = self.questionCast, let spoiler = self.questionSpoiler {
            page1.textField?.textfield.text = title
            page2.textField?.textfield.text = time
            page3.textField?.textfield.text = language
            page4.floatingTitleTextView.textView.text = plot
            page4.blueSwitch.setOn(spoiler, animated: false)
            page5.textField?.textfield.text = cast
        }
    }
    
    func setupPageControl() {
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.customDarkBlue
        self.pageControl.pageIndicatorTintColor = UIColor.customDimBlue
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = initialPage
    }
    
    func setupButtons() {
        self.nextButton.setAttributedTitle(NSAttributedString(string: "Next", attributes: [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 18)!,
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue
        ]), for: .normal)
        
        
        self.prevButton.setAttributedTitle(NSAttributedString(string: "Prev", attributes: [
            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 18)!,
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue
        ]), for: .normal)
    }
    
    func addButtonsTarget() {
        prevButton.addTarget(self, action: #selector(self.prevViewController(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(self.nextViewController(_:)), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(self.doneButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func prevViewController(_: UIButton!) {
        if let viewControllerIndex = self.pages.firstIndex(of: viewControllers![0]) {
            if viewControllerIndex == 0 {
                
            } else {
                setViewControllers([pages[viewControllerIndex - 1]], direction: .reverse, animated: true, completion: nil)
                if let viewControllerIndex = self.pages.firstIndex(of: viewControllers![0]) {
                    self.pageControl.currentPage = viewControllerIndex
                    if viewControllerIndex == 0 {
                        self.prevButton.isHidden = true
                    } else if viewControllerIndex == pages.count - 2 {
                        nextButton.isHidden = false
                        doneButton.isHidden = true
                    }
                }
            }
        }
    }
    
    func nextViewController() {
        if let viewControllerIndex = self.pages.firstIndex(of: viewControllers![0]) {
            if viewControllerIndex < self.pages.count - 1 {
                let nextViewController = pages[viewControllerIndex + 1]
                setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
                if let viewControllerIndex = self.pages.firstIndex(of: viewControllers![0]) {
                    self.pageControl.currentPage = viewControllerIndex
                    self.prevButton.isHidden = false
                    if viewControllerIndex == pages.count - 1 {
                        self.nextButton.isHidden = true
                        self.doneButton.isHidden = false
                    }
                }
            }
        }
    }
    
    @objc func nextViewController(_: UIButton!) {
        nextViewController()
    }
    
    func createQuestionPost() {
        spinner.startAnimating()
        updateQuestion { (uid, err) in
            let userEmail = Auth.auth().currentUser!.email!
            let date = Date()
            guard err == nil else { return }
            db.collection("posts").document(uid).setData([
                "question": db.collection("questions").document(uid),
                "comments": [],
                "user": userEmail,
                "createTime": Timestamp(date: date)
            ]) { (err) in
                if let err = err {
                    let alert = UIAlertController.errorAlert(withTitle: "Failed to create post", andError: err)
                    self.present(alert, animated: true, completion: nil)
                    self.spinner.stopAnimating()
                    return
                }
                self.spinner.stopAnimating()
                self.dismiss(animated: true) {
                    NotificationCenter.default.post(name: .didCreatePost, object: nil)
                }
            }
        }
    }
    
    func updateQuestionPost() {
        spinner.startAnimating()
        updateQuestion { (uid, err) in
            guard err == nil else { return }
            self.spinner.stopAnimating()
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: .didUpdateQuestion, object: nil)
            }
        }
    }
    
    func updateQuestion(completion: @escaping (String, Error?) -> ()) {
        var i = 0
        var title = ""
        var time = ""
        var languages = ""
        var plot = ""
        var casts = ""
        var isSpoiler = false
        let date = Date()
        let uuid = self.uuid ?? UUID().uuidString
        let userEmail = Auth.auth().currentUser!.email!
        while i < 5 {
            if i == 0 || i == 1 || i == 2 || i == 4 {
                let page = pages[i] as! AskViewController
                guard let text = page.textField?.textfield.text, text != "" else {
                    let allert = UIAlertController.errorAlert(withTitle: "Empty information", andMessage: "Please fill in all the information")
                    self.present(allert, animated: true, completion: nil)
                    return
                }
                switch i {
                case 0:
                    title = text
                case 1:
                    time = text
                case 2:
                    languages = text
                case 4:
                    casts = text
                default:
                    return
                }
            } else if i == 3 {
                let page = pages[i] as! AskPlotViewController
                let spoiler = page.blueSwitch.isOn
                guard let text = page.floatingTitleTextView.textView.text, text != "" else {
                    let allert = UIAlertController.errorAlert(withTitle: "Empty information", andMessage: "Please fill in all the information")
                    self.present(allert, animated: true, completion: nil)
                    return
                }
                plot = text
                isSpoiler = spoiler
            }
            i += 1
        }
        db.collection("questions").document(uuid).setData([
            "isSpoiler": isSpoiler,
            "languages": languages,
            "plot": plot,
            "title": title,
            "time": time,
            "user": userEmail,
            "casts": casts,
            "lastUpdate": Timestamp(date: date)
        ]) { (err) in
            if let err = err {
                let alert = UIAlertController.errorAlert(withTitle: "Failed to create post", andError: err)
                self.present(alert, animated: true, completion: nil)
                completion(uuid, err)
                return
            }
            completion(uuid, nil)
        }
    }
    
    @objc func doneButtonPressed(_: UIButton!) {
        if isEditMode {
            updateQuestionPost()
        } else {
            createQuestionPost()
        }
    }
    
    func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func dismissKeyboard(_: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

extension AskQuestionPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
}

extension AskQuestionPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == (self.pages[4] as! AskViewController).textField?.textfield {
            createQuestionPost()
            return true
        }
        nextViewController()
        return true
    }
}


