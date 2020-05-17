//
//  AMSlidingFixedMenuAnimator.swift
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

open class AMSlidingFixedMenuAnimator: AMSlidingAnimatorProtocol {

    open var duration: TimeInterval = 0.25

    open func animate(leftMenuView: UIView, contentView: UIView, progress: CGFloat, animated: Bool, completion: (() -> Void)?) {
        var frame = leftMenuView.frame
        let prg = max(0, min(progress, 1))
        frame.origin.x = 0

		leftMenuView.superview?.sendSubviewToBack(leftMenuView)
        if prg > 0 {
            leftMenuView.isHidden = false
        }

		leftMenuView.frame = frame
		completion?()
		if prg == 0 {
			leftMenuView.isHidden = true
			frame.origin.x = -frame.width
			leftMenuView.frame = frame
		}
    }

	open func animate(rightMenuView: UIView, contentView: UIView, progress: CGFloat = 1, animated: Bool = true, completion: (() -> Void)? = nil) {
		let contentFrame = contentView.frame
        var frame = rightMenuView.frame
        let prg = max(0, min(progress, 1))
		frame.origin.x = contentFrame.width - frame.size.width

		rightMenuView.superview?.sendSubviewToBack(rightMenuView)
        if prg > 0 {
            rightMenuView.isHidden = false
        }
		rightMenuView.frame = frame
		completion?()
		if prg == 0 {
			rightMenuView.isHidden = true
			frame.origin.x = contentFrame.width
			rightMenuView.frame = frame
		}
	}
}
