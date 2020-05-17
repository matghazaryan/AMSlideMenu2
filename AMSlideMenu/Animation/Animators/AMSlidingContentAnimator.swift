//
//  AMSlidingContentAnimator.swift
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

open class AMSlidingContentAnimator: AMSlidingAnimatorProtocol {

    open var duration: TimeInterval = 0.25

    open func animate(leftMenuView: UIView, contentView: UIView, progress: CGFloat, animated: Bool, completion: (() -> Void)?) {
		let leftMenuWidth = leftMenuView.frame.width
		var frame = contentView.frame
        let prg = max(0, min(progress, 1))
        frame.origin.x = leftMenuWidth * prg

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }
        CATransaction.setAnimationDuration(CFTimeInterval(duration))
		CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.AM.easeOutCubic)
        UIView.animate(withDuration: duration) {
            contentView.frame = frame
        }

        CATransaction.commit()
    }

	open func animate(rightMenuView: UIView, contentView: UIView, progress: CGFloat = 1, animated: Bool = true, completion: (() -> Void)? = nil) {
		let rightMenuWidth = rightMenuView.frame.width
		var frame = contentView.frame
        let prg = max(0, min(progress, 1))
        frame.origin.x = -rightMenuWidth * prg

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }
        CATransaction.setAnimationDuration(CFTimeInterval(duration))
		CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.AM.easeOutCubic)
        UIView.animate(withDuration: duration) {
            contentView.frame = frame
        }

        CATransaction.commit()
	}
}
