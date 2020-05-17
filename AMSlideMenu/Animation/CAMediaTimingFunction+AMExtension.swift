//
//  CAMediaTimingFunction+Extension.swift
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

public extension CAMediaTimingFunction {
	enum AM {
		// default
		static let `default` = CAMediaTimingFunction(name: .default)
		static let linear = CAMediaTimingFunction(name: .linear)
		static let easeIn = CAMediaTimingFunction(name: .easeIn)
		static let easeOut = CAMediaTimingFunction(name: .easeOut)
		static let easeInEaseOut = CAMediaTimingFunction(name: .easeInEaseOut)

		// custom
		static let easeInSine = CAMediaTimingFunction(controlPoints: 0.47, 0, 0.745, 0.715)
		static let easeOutSine = CAMediaTimingFunction(controlPoints: 0.39, 0.575, 0.565, 1)
		static let easeInOutSine = CAMediaTimingFunction(controlPoints: 0.445, 0.05, 0.55, 0.95)
		static let easeInQuad = CAMediaTimingFunction(controlPoints: 0.55, 0.085, 0.68, 0.53)
		static let easeOutQuad = CAMediaTimingFunction(controlPoints: 0.25, 0.46, 0.45, 0.94)
		static let easeInOutQuad = CAMediaTimingFunction(controlPoints: 0.455, 0.03, 0.515, 0.955)
		static let easeInCubic = CAMediaTimingFunction(controlPoints: 0.55, 0.055, 0.675, 0.19)
		static let easeOutCubic = CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1)
		static let easeInOutCubic = CAMediaTimingFunction(controlPoints: 0.645, 0.045, 0.355, 1)
		static let easeInQuart = CAMediaTimingFunction(controlPoints: 0.895, 0.03, 0.685, 0.22)
		static let easeOutQuart = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
		static let easeInOutQuart = CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
		static let easeInQuint = CAMediaTimingFunction(controlPoints: 0.755, 0.05, 0.855, 0.06)
		static let easeOutQuint = CAMediaTimingFunction(controlPoints: 0.23, 1, 0.32, 1)
		static let easeInOutQuint = CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)
		static let easeInExpo = CAMediaTimingFunction(controlPoints: 0.95, 0.05, 0.795, 0.035)
		static let easeOutExpo = CAMediaTimingFunction(controlPoints: 0.19, 1, 0.22, 1)
		static let easeInOutExpo = CAMediaTimingFunction(controlPoints: 1, 0, 0, 1)
		static let easeInCirc = CAMediaTimingFunction(controlPoints: 0.6, 0.04, 0.98, 0.335)
		static let easeOutCirc = CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.165, 1)
		static let easeInOutCirc = CAMediaTimingFunction(controlPoints: 0.785, 0.135, 0.15, 0.86)
		static let easeInBack = CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
		static let easeOutBack = CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
		static let easeInOutBack = CAMediaTimingFunction(controlPoints: 0.68, -0.55, 0.265, 1.55)
	}
}
