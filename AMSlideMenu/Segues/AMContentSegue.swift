//
//  AMInitialContentSegue.swift
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

open class AMContentSegue: UIStoryboardSegue {
    override open func perform() {
        var mainVC:AMSlideMenuMainVC?
        if let sourceVC = self.source as? AMSlideMenuMainVC {
            mainVC = sourceVC
        } else if let sourceVC = self.source.slideMenuMainVC {
            mainVC = sourceVC
			mainVC?.prepare(for: self, sender: self)
        }
        guard let slideMenuMainVC = mainVC else { return }
        
        slideMenuMainVC.children.forEach({$0.removeFromParent()})
		slideMenuMainVC.contentView.subviews.filter({$0 != slideMenuMainVC.overlayView}).forEach({$0.removeFromSuperview()})
        slideMenuMainVC.children.forEach({$0.didMove(toParent: nil)})
        
        destination.slideMenuMainVC = slideMenuMainVC
        slideMenuMainVC.setContentVC(destination)
        
        slideMenuMainVC.addChild(destination)
        slideMenuMainVC.contentView.addSubview(destination.view)
        destination.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        destination.view.frame = slideMenuMainVC.contentView.bounds
        destination.didMove(toParent: slideMenuMainVC)

		slideMenuMainVC.contentView.bringSubviewToFront(slideMenuMainVC.overlayView)
		if slideMenuMainVC.menuState == .leftOpened {
			slideMenuMainVC.hideLeftMenu(animated: UIView.areAnimationsEnabled)
		} else if slideMenuMainVC.menuState == .rightOpened {
			slideMenuMainVC.hideRightMenu(animated: UIView.areAnimationsEnabled)
		}
    }
}
