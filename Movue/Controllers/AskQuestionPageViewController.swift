//
//  AskingPageViewController.swift
//  Movue
//
//  Created by Shao-Chien Lin on 2019/10/24.
//  Copyright © 2019 l.shaochien. All rights reserved.
//

import UIKit

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
    lazy var gestureIndicator: UIView! = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customLightGrey
        view.layer.cornerRadius = 3
        return view
    }()
    
    // MARK: -Variables
    let initialPage = 0
    var questionTitle: String? = nil
    var questionTime: String? = nil
    var questionPlot: String? = nil
    var questionLanguage: String? = nil
    var questionCast: String? = nil
    var questionSpoiler: Bool! = false
    
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
        self.dataSource = self
        self.prevButton.isHidden = true
    }
    
    func addSubviews() {
        self.view.addSubview(self.pageControl)
        self.view.addSubview(nextButton)
        self.view.addSubview(prevButton)
        self.view.addSubview(gestureIndicator)
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
        
        self.gestureIndicator.widthAnchor.constraint(equalToConstant: 120).isActive = true
        self.gestureIndicator.heightAnchor.constraint(equalToConstant: 6).isActive = true
        self.gestureIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.gestureIndicator.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
    }
    
    func setupPages() {
        let page1 = AskViewController(title: "1. Question Title", subtitle: "Please provide a title for your question. Your title should be the major plot of the film.", floatingTextfieldTitle: "Title",
                                      firstInstructionView: InstructionView(minorTitle: "Use Something Like...", majorTitle: "A black pianist and a Italian driver", titleColor: .customGreen),
                                      secondInstructionView: InstructionView(minorTitle: "Avoid...", majorTitle: "Can't remember this movie", titleColor: .customOrange))
        let page2 = AskViewController(title: "2. Time", subtitle: "Please provide the time you watch this movie. It maybe a specific time or just a rough time.", floatingTextfieldTitle: "Time",
                                      firstInstructionView: InstructionView(minorTitle: "Use Something Like...", majorTitle: "I think it's 2017", titleColor: .customGreen),
                                      secondInstructionView: InstructionView(minorTitle: "It may also be a rough time", majorTitle: "Around 5 years ago", titleColor: .customGreen))
        let page3 = AskViewController(title: "3. Language", subtitle: "Please provide the language the characters speak in the movie.", floatingTextfieldTitle: "Language",
                                      firstInstructionView: InstructionView(minorTitle: "Use Something Like...", majorTitle: "English, Chinese", titleColor: .customGreen),
                                      secondInstructionView: InstructionView(minorTitle: "You may also specify the accent like …", majorTitle: "English with Brtish accent", titleColor: .customGreen))
        let page4 = AskPlotViewController(title: "4. Plots", subtitle: "Please provide the plot of the movie. It may be a single plot or multiple plots.", floatingTitleTextView: FloatingTitleTextView(title: "Plots"))
        let page5 = AskViewController(title: "5. Casts", subtitle: "Please provide the casts starring in this movie", floatingTextfieldTitle: "Casts", firstInstructionView: InstructionView(minorTitle: "Use something like...", majorTitle: "Leonardo Dicappio", titleColor: .customGreen), secondInstructionView: InstructionView(minorTitle: "You can also use multiple casts...", majorTitle: "Leonardo Dicappio, Kate Winslet", titleColor: .customGreen))
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
                        nextButton.setAttributedTitle(NSAttributedString(string: "Next", attributes: [
                            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 18)!,
                            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue
                        ]), for: .normal)
                    }
                }
            }
        }
    }
    
    @objc func nextViewController(_: UIButton!) {
        if let viewControllerIndex = self.pages.firstIndex(of: viewControllers![0]) {
            if viewControllerIndex < self.pages.count - 1 {
                setViewControllers([pages[viewControllerIndex + 1]], direction: .forward, animated: true, completion: nil)
                if let viewControllerIndex = self.pages.firstIndex(of: viewControllers![0]) {
                    self.pageControl.currentPage = viewControllerIndex
                    self.prevButton.isHidden = false
                    if viewControllerIndex == pages.count - 1 {
                        self.nextButton.setAttributedTitle(NSAttributedString(string: "Done", attributes: [
                            NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 18)!,
                            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue
                        ]), for: .normal)
                    }
                }
            }
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

extension AskQuestionPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                self.prevButton.isHidden = true
                return nil
            } else {
                nextButton.setAttributedTitle(NSAttributedString(string: "Next", attributes: [
                    NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 18)!,
                    NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue
                ]), for: .normal)
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
            
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            self.prevButton.isHidden = false
            if viewControllerIndex == self.pages.count - 1 {
                self.nextButton.setAttributedTitle(NSAttributedString(string: "Done", attributes: [
                    NSAttributedString.Key.font: UIFont(name: APPLE_SD_GOTHIC_NEO.bold, size: 18)!,
                    NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue
                ]), for: .normal)
            }
            if viewControllerIndex < self.pages.count - 1 {
                return self.pages[viewControllerIndex + 1]
            } else {
                return nil
            }
        }
        return nil
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
