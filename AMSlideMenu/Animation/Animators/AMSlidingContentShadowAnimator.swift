//
//  AMSlidingContentShadowAnimator.swift
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

open class AMSlidingContentShadowAnimator: AMSlidingAnimatorProtocol {
    open var duration: TimeInterval = 0.25

    open func animate(leftMenuView: UIView, contentView: UIView, progress: CGFloat, animated: Bool, completion: (() -> Void)?) {
        contentView.layer.shadowColor = UIColor(red: 8/255.0, green: 46/255.0, blue: 88/255.0, alpha: 0.28).cgColor
        contentView.layer.shadowOffset = CGSize(width: 1, height: 0)
        contentView.layer.shadowRadius = 5
		contentView.layer.masksToBounds = false

        UIView.animate(withDuration: animated ? duration : 0, animations: {
            contentView.layer.shadowOpacity = Float(progress)
        }) { (_) in
            completion?()
        }
    }

	open func animate(rightMenuView: UIView, contentView: UIView, progress: CGFloat = 1, animated: Bool = true, completion: (() -> Void)? = nil) {
		contentView.layer.shadowColor = UIColor(red: 8/255.0, green: 46/255.0, blue: 88/255.0, alpha: 0.28).cgColor
        contentView.layer.shadowOffset = CGSize(width: 1, height: 0)
        contentView.layer.shadowRadius = 5
		contentView.layer.masksToBounds = false
		
        UIView.animate(withDuration: animated ? duration : 0, animations: {
            contentView.layer.shadowOpacity = Float(progress)
        }) { (_) in
            completion?()
        }
	}
}
