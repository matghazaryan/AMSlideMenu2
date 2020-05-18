//
//  UIViewController+AMExtension.swift
//  AMSlideMenu
//
// The MIT License (MIT)
//
// Created by : arturdev
// Copyright (c) 2020 arturdev. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

import UIKit

fileprivate struct AssociationKeys {
    static var slideMenuMainVCKey = "slideMenuMainVCKey"
}

public extension UIViewController {
    
    weak var slideMenuMainVC: AMSlideMenuMainViewController? {
        get {
            let vc = objc_getAssociatedObject(self, &AssociationKeys.slideMenuMainVCKey) as? AMSlideMenuMainViewController
            if vc == nil && parent != nil {
                return parent?.slideMenuMainVC
            }
            return vc
        }
        set {
            objc_setAssociatedObject(self, &AssociationKeys.slideMenuMainVCKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    @objc func showLeftMenu(animated: Bool = true, completion handler: (()->Void)? = nil) {
        guard !(self is AMSlideMenuMainViewController) else { return }
        slideMenuMainVC?.showLeftMenu(animated: animated, completion: handler)
    }

    @objc func hideLeftMenu(animated: Bool = true, completion handler: (()->Void)? = nil) {
        guard !(self is AMSlideMenuMainViewController) else { return }
        slideMenuMainVC?.hideLeftMenu(animated: animated, completion: handler)
    }

    @objc func showRightMenu(animated: Bool = true, completion handler: (()->Void)? = nil) {
        guard !(self is AMSlideMenuMainViewController) else { return }
        slideMenuMainVC?.showRightMenu(animated: animated, completion: handler)
    }

    @objc func hideRightMenu(animated: Bool = true, completion handler: (()->Void)? = nil) {
        guard !(self is AMSlideMenuMainViewController) else { return }
        slideMenuMainVC?.hideRightMenu(animated: animated, completion: handler)
    }
}
