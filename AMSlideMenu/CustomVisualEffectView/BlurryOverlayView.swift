//
//  BlurryOverlayView.swift
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

class BlurryOverlayView: UIVisualEffectView {
    private var animator: UIViewPropertyAnimator!
    private var delta: CGFloat = 0 // The amount to change fractionComplete for each tick
    private var target: CGFloat = 0 // The fractionComplete we're animating to
    private var displayLink: CADisplayLink!
    private var isBluringUp = false
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    // Common init
    
    private func prepare() {
        effect = nil // Starts out with no blur
        isHidden = true // Enables user interaction through the view
        
        // The animation to add an effect
        animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.effect = UIBlurEffect(style: .light)
        }
        if #available(iOS 11.0, *) {
            animator.pausesOnCompletion = true // Fixes background bug
        }
        
        // Using a display link to animate animator.fractionComplete
        displayLink = CADisplayLink(target: self, selector: #selector(tick))
        displayLink.isPaused = true        
        displayLink.add(to: .main, forMode: RunLoop.Mode.common)
    }
    
    func blur(amount: CGFloat = 0.2, duration: TimeInterval = 0.3) {
        isHidden = false // Disable user interaction
        
        if target == amount { //already blured
            return
        }
        
        isBluringUp = amount > target
        
        if duration == 0 {
            delta = (amount - target)
        } else {
            delta = (amount - target) / (60 * CGFloat(duration)) // Assuming 60hz refresh rate
        }
        target = amount
        
        // Start animating fractionComplete
        displayLink.isPaused = false
    }
    
    @objc private func tick() {
        animator.fractionComplete += delta
        
        if animator.fractionComplete <= 0 {
            // Done blurring out
            isHidden = true
            displayLink.isPaused = true
        } else if animator.fractionComplete >= 1 {
            // Done blurring in
            displayLink.isPaused = true
        } else {
            if isBluringUp {
                if animator.fractionComplete >= target {
                    // Done blurring in
                    displayLink.isPaused = true
                }
            } else {
                if animator.fractionComplete <= target {
                    // Done blurring out
                    displayLink.isPaused = true
                }
            }
        }
    }
}
