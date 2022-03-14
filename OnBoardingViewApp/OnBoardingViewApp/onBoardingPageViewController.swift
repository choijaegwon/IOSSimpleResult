//
//  onBoardingPageViewController.swift
//  OnBoardingViewApp
//
//  Created by Jae kwon Choi on 2022/01/01.
//

import UIKit

class onBoardingPageViewController: UIPageViewController {

    var pages = [UIViewController]()
    //밑에버튼
    var bottomButtomMargin: NSLayoutConstraint?
    var pageControl = UIPageControl()
    let startIndex = 0
    var currentIndex = 0 {
        didSet{
            pageControl.currentPage = currentIndex
        }
    }
    
    func makePageVC(){
        let itemVC1 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC1.mainText = "첫번째"
        itemVC1.topImage = UIImage(named: "onboarding1")
        itemVC1.subText = "사진1"
        
        let itemVC2 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC2.mainText = "두번째"
        itemVC2.topImage = UIImage(named: "onboarding2")
        itemVC2.subText = "사진2"
        
        let itemVC3 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC3.mainText = "세번째"
        itemVC3.topImage = UIImage(named: "onboarding3")
        itemVC3.subText = "사진3"
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        
        //처음에 보여줄껄 설정하는것
        setViewControllers([itemVC1], direction: .forward, animated: true, completion: nil)
        
        // 반드시 구현해야 한다.
        self.delegate = self
        self.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.makePageVC()
        
        //버튼
        self.makeBottomButton()
        
        //검은점3개
        self.makePageControl()
    }
    
    func makeBottomButton() {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.addTarget(self, action: #selector(dismissPageVC), for: .touchUpInside)
        
        //화면에 버튼 올리기
        self.view.addSubview(button)
        //오토레이아웃을 사용하려면 이 설정을 해줘야 한다.
        button.translatesAutoresizingMaskIntoConstraints = false
        //아래쪽에붙이기
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomButtomMargin = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomButtomMargin?.isActive = true
        hideButton()
        
    }
    
    func makePageControl() {
        self.view?.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = startIndex
        
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
    }
    
    @objc func pageControlTapped(sender: UIPageControl) {
        
        if sender.currentPage > self.currentIndex {
            self.setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        } else {
            self.setViewControllers([pages[sender.currentPage]], direction: .reverse, animated: true, completion: nil)
        }
        
        self.currentIndex = sender.currentPage
        
        buttonPresentationStyle()
    }
    
    @objc func dismissPageVC(){
        self.dismiss(animated: true, completion: nil)
    }


}

extension onBoardingPageViewController: UIPageViewControllerDataSource {
    
    //현재페이지에서 전페이지로가면어디로
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //현재 페이지를 가져오는 개념
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        self.currentIndex = currentIndex
        
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
        
    }
    
    //현재페이지에서 다음페이지로가면어디로
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        //현재 페이지를 가져오는 개념
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        self.currentIndex = currentIndex
        
        if currentIndex == pages.count - 1 {
            return pages.first
        } else {
            return pages[currentIndex + 1]
        }
    }
}

extension onBoardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let currentVC = pageViewController.viewControllers?.first else {
            return
        }
        
        guard let currentIndex = pages.firstIndex(of: currentVC) else {
            return
        }
        
        self.currentIndex = currentIndex
                
        buttonPresentationStyle()
        
    }
    
    func buttonPresentationStyle(){
        if currentIndex == pages.count - 1 {
            self.showButton()
        } else {
            self.hideButton()
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func showButton() {
        bottomButtomMargin?.constant = 0
    }
    
    func hideButton() {
        bottomButtomMargin?.constant = 100
    }
    
}
