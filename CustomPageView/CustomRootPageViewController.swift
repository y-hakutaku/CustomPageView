//
//  CustomRootPageViewController.swift
//  CustomPageView
//
//  Created by Hakutaku on 2018/09/24.
//  Copyright © 2018年 Hakutaku. All rights reserved.
//

import UIKit

class CustomRootPageViewController: UIViewController, UIScrollViewDelegate  {

    var pageViewController: UIPageViewController?
    
    var tabMenuViewController: PageMenuViewController?

    var pageViewContentViewControllers = [UIViewController]()
    
    var customPageMenu = [CustomPageMenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = childViewControllers.compactMap{$0 as? UIPageViewController}.first
        pageViewController!.dataSource = self
        pageViewController!.delegate = self
        pageViewController!.didMove(toParentViewController: self)
        
        tabMenuViewController = childViewControllers.compactMap{$0 as? PageMenuViewController}.first
        tabMenuViewController!.didMove(toParentViewController: self)
    }
    
    func setUpPageViewContentViews() {
        for _ in 0..<PageItem.titles.count {
            pageViewContentViewControllers.append(storyboard!.instantiateViewController(withIdentifier: "TableView"))
        }
        // 初期設定時に渡すviewControllerは1つ
        pageViewController!.setViewControllers([pageViewContentViewControllers.first!], direction: .forward, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension CustomRootPageViewController: UIPageViewControllerDelegate {

    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let viewController: UIViewController = pendingViewControllers.last {
            if let index = pageViewContentViewControllers.index(of: viewController) {
                if index != tabMenuViewController!.currentIndex {
                    tabMenuViewController!.willMoveMenuBar(at: index)
                }
            }
        }
    }

    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewController: UIViewController = pageViewController.viewControllers?.last {
            guard let index = pageViewContentViewControllers.index(of: viewController) else {
                return
            }
            if (completed) {
                tabMenuViewController!.currentIndex = index
            }
            else {
                tabMenuViewController!.willMoveMenuBar(at: index)
            }
        }
    }
}

extension CustomRootPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = self.pageViewContentViewControllers.index(of: viewController) {
            if index != 0 && index != NSNotFound {
                return self.pageViewContentViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = self.pageViewContentViewControllers.index(of: viewController) {
            let count: Int = self.pageViewContentViewControllers.count
            if index != NSNotFound && index + 1 < count {
                return self.pageViewContentViewControllers[index + 1]
            }
        }
        return nil
    }
}
