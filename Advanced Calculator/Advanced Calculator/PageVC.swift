//
//  PageVC.swift
//  Calculator
//
//  Created by Sirak Berhane on 2018-06-01.
//  Copyright © 2018 Sirak Berhane. All rights reserved.
//

import UIKit

// Page View Controller 
class PageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    lazy var VCArr: [UIViewController] = {
        return [self.VCInstance(name: "firstFunctionPage"),
                self.VCInstance(name: "secondFunctionPage"),
                self.VCInstance(name: "thirdFunctionPage")]}()

    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstFunctionPage = VCArr.first {
            setViewControllers([firstFunctionPage], direction: .forward, animated: false, completion: nil)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return VCArr.last
        }

        guard VCArr.count > previousIndex else {
            return nil
        }

        return VCArr[previousIndex]
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < VCArr.count else {
            return VCArr.first
        }

        guard VCArr.count > nextIndex else {
            return nil
        }

        return VCArr[nextIndex]
    }

    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArr.count
    }

    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = VCArr.index(of: firstViewController) else {
                return 0
        }

        return firstViewControllerIndex
    }
}
