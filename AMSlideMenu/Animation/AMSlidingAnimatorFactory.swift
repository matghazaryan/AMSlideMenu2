//
//  AMSlidingAnimatorFactory.swift
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

import Foundation

public class AMSlidingAnimatorFactory {
    
    public static func animator(options: AMSlidingAnimationOptions, duration: TimeInterval) -> AMSlidingAnimatorProtocol {
        var animators = [AMSlidingAnimatorProtocol]()

        if options.contains(.slidingMenu) {
            animators.append(AMSlidingStandardAnimator())
        }

        if options.contains(.blurBackground) {
            animators.append(AMSlidingBlurAnimator())
        }

        if options.contains(.menuShadow) {
            animators.append(AMSlidingShadowAnimator())
        }
        
        if options.contains(.dimmedBackground) {
            animators.append(AMSlidingDimmedBackgroundAnimator())
        }

		if options.contains(.content) {
            animators.append(AMSlidingContentAnimator())
        }

		if options.contains(.fixedMenu) {
            animators.append(AMSlidingFixedMenuAnimator())
        }

		if options.contains(.contentShadow) {
            animators.append(AMSlidingContentShadowAnimator())
        }
        
        animators.forEach({$0.duration = duration})        

		for option in AMSlidingAnimationOptions.customOptions {
			animators.append(option.animator!)
		}

        let animator = AMSlidingGroupAnimator()
        animator.addAnimators(animators)
        return animator
    }
}
