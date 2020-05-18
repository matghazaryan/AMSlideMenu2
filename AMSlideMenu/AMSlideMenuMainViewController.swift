
//
//  AMSlideMenuMainViewController.swift
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

internal extension UIWindow {
	static var keyWindow: UIWindow? {
		return UIApplication.shared.windows.filter({$0.isKeyWindow}).first
	}

	var width: CGFloat {
		#if targetEnvironment(macCatalyst)
			return frame.width
		#else
			let isPortrait = UIDevice.current.orientation.isPortrait || !UIDevice.current.orientation.isValidInterfaceOrientation
			return isPortrait ? min(frame.width, frame.height) : max(frame.width, frame.height)
		#endif
	}

	var height: CGFloat {
		#if targetEnvironment(macCatalyst)
		return frame.height
		#else
			let isPortrait = UIDevice.current.orientation.isPortrait || !UIDevice.current.orientation.isValidInterfaceOrientation
			return isPortrait ? max(frame.width, frame.height) : min(frame.width, frame.height)
		#endif
	}
}

public protocol AMSlideMenuDelegate: class {
    func leftMenuWillShow()
    func leftMenuDidShow()
    func leftMenuWillHide()
    func leftMenuDidHide()

    func rightMenuWillShow()
    func rightMenuDidShow()
    func rightMenuWillHide()
    func rightMenuDidHide()
}

//Making the protocol methods optional
public extension AMSlideMenuDelegate {
	func leftMenuWillShow() {}
	func leftMenuDidShow() {}
	func leftMenuWillHide() {}
	func leftMenuDidHide() {}

	func rightMenuWillShow() {}
	func rightMenuDidShow() {}
	func rightMenuWillHide() {}
	func rightMenuDidHide() {}
}

@IBDesignable
open class AMSlideMenuMainViewController: UIViewController {

    public private(set) var leftMenuVC: UIViewController?
	public private(set) var rightMenuVC: UIViewController?
    public weak private(set) var contentVC: UIViewController?

	@IBInspectable public var leftMenuSegueName: String?
	@IBInspectable public var rightMenuSegueName: String?
	@IBInspectable public var contentSegueName: String?

	private var menuWidthDefaultMultiplier: CGFloat {
		#if targetEnvironment(macCatalyst)
		return 0.201
		#else
		return 0.801
		#endif
	}
	@IBInspectable open var leftMenuWidth: CGFloat = 0
	@IBInspectable open var rightMenuWidth: CGFloat = 0

    open var animationDuration = TimeInterval(0.25)
	open var animationOptions: AMSlidingAnimationOptions = [.slidingMenu, .dimmedBackground, .menuShadow, .blurBackground]
    
    open var leftMenuPanGestureRecognizer: UIPanGestureRecognizer!
	open var rightMenuPanGestureRecognizer: UIPanGestureRecognizer!
    open var contentPanGestureRecognizer:  UIPanGestureRecognizer!
    open var contentTapGestureRecognizer:  UITapGestureRecognizer!
    
    open var panGestureWorkingAreaPercent: Float = 50
    
    open var menuState: MenuState = .closed {
        didSet {
            overlayView.isUserInteractionEnabled = menuState != .closed
            if menuState == .closed {
                contentView.addGestureRecognizer(contentPanGestureRecognizer)
            } else {
                overlayView.addGestureRecognizer(contentPanGestureRecognizer)
            }
        }
    }
    open weak var delegate: AMSlideMenuDelegate?

    private var _animator:AMSlidingAnimatorProtocol?
    var animator: AMSlidingAnimatorProtocol {
        if _animator == nil {
            _animator = AMSlidingAnimatorFactory.animator(options: animationOptions, duration: animationDuration)
        }
        return _animator!
    }
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.isUserInteractionEnabled = false
		view.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
		view.tag = 1000
        return view
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
		NotificationCenter.default.addObserver(self,
											   selector: #selector(AMSlideMenuMainViewController.handleShowLeftMenuNote),
											   name: .showLeftMenu,
											   object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(AMSlideMenuMainViewController.handleShowRightMenuNote),
											   name: .showRightMenu,
											   object: nil)

		DispatchQueue.main.async {
			self.leftMenuWidth == 0 ? (self.leftMenuWidth = (UIWindow.keyWindow?.width ?? 0) * self.menuWidthDefaultMultiplier) : nil
			self.rightMenuWidth == 0 ? (self.rightMenuWidth = (UIWindow.keyWindow?.width ?? 0) * self.menuWidthDefaultMultiplier) : nil
		}
    }

	deinit {
		NotificationCenter.default.removeObserver(self,
												  name: .showLeftMenu,
												  object: nil)
		NotificationCenter.default.removeObserver(self,
												  name: .showRightMenu,
												  object: nil)
	}

	open override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.backgroundColor = .clear
		label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
		label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
		label.minimumScaleFactor = 0.5
		label.textColor = .white
		label.text = "AMSlideMenuContainer"
		view.addSubview(label)
	}
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGestures()
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLeftMenu()
		setupRightMenu()
        addGestures()
    }

	open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		let shouldUpdateLeftMenuWidth = leftMenuWidth == view.bounds.width * menuWidthDefaultMultiplier
		let shouldUpdateRightMenuWidth = rightMenuWidth == view.bounds.width * menuWidthDefaultMultiplier
		super.viewWillTransition(to: size, with: coordinator)

		let updateBlock = { (_: Any) in
			shouldUpdateLeftMenuWidth ? (self.leftMenuWidth = (UIWindow.keyWindow?.width ?? 0) * self.menuWidthDefaultMultiplier) : nil
			shouldUpdateRightMenuWidth ? (self.rightMenuWidth = (UIWindow.keyWindow?.width ?? 0) * self.menuWidthDefaultMultiplier) : nil
			self.updateLeftMenuFrame()
			self.updateRightMenuFrame()
		}
		coordinator.animate(alongsideTransition: updateBlock, completion: updateBlock)
	}

    @objc open override func showLeftMenu(animated: Bool, completion handler: (()->Void)? = nil) {
        guard let leftMenuVC = leftMenuVC else { return }
        if menuState == .leftOpened {
            handler?()
            return
        }
		hideRightMenu(animated: false, completion: nil)
        delegate?.leftMenuWillShow()
        animator.animate(leftMenuView: leftMenuVC.view, contentView: contentView, progress: 1, animated: animated, completion: {
            self.menuState = .leftOpened
            self.delegate?.leftMenuDidShow()
            handler?()
        })
    }

    @objc open override func showRightMenu(animated: Bool, completion handler: (()->Void)? = nil) {
        guard let rightMenuVC = rightMenuVC else { return }
        if menuState == .rightOpened {
            handler?()
            return
        }
		hideLeftMenu(animated: false, completion: nil)
        delegate?.rightMenuWillShow()
        animator.animate(rightMenuView: rightMenuVC.view, contentView: contentView, progress: 1, animated: animated, completion: {
            self.menuState = .rightOpened
            self.delegate?.rightMenuDidShow()
            handler?()
        })
    }
    
    @objc open override func hideLeftMenu(animated: Bool, completion handler: (()->Void)? = nil) {
        guard let leftMenuVC = leftMenuVC else { return }
        if menuState == .closed {
            handler?()
            return
        }
        self.delegate?.leftMenuWillHide()
        animator.animate(leftMenuView: leftMenuVC.view, contentView: contentView, progress: 0, animated: animated, completion: {
            self.menuState = .closed
            self.delegate?.leftMenuDidHide()
            handler?()
        })
    }

	@objc open override func hideRightMenu(animated: Bool, completion handler: (()->Void)? = nil) {
        guard let rightMenuVC = rightMenuVC else { return }
        if menuState == .closed {
            handler?()
            return
        }
        self.delegate?.rightMenuWillHide()
        animator.animate(rightMenuView: rightMenuVC.view, contentView: contentView, progress: 0, animated: animated, completion: {
            self.menuState = .closed
            self.delegate?.rightMenuDidHide()
            handler?()
        })
    }
    
    open func switchContentTo(vc: UIViewController, animated: Bool = true) {
        UIView.setAnimationsEnabled(animated)
        let segue = AMContentSegue(identifier: "content", source: self, destination: vc)
        segue.perform()
        UIView.setAnimationsEnabled(true)
    }
    
    //MARK: - Internal
    func setLeftMenu(_ leftMenuVC: UIViewController) {
        self.leftMenuVC = leftMenuVC		
    }

    func setRightMenu(_ rightMenuVC: UIViewController) {
        self.rightMenuVC = rightMenuVC
    }

    func setContentVC(_ contentVC: UIViewController) {
        self.contentVC = contentVC
    }
    
    func setupContent() {
		guard let segueName = contentSegueName else { return }
        contentView.frame = view.bounds
        view.addSubview(contentView)
        
        performSegue(withIdentifier: segueName, sender: self)
    }
    
    func setupLeftMenu() {
		guard let segueName = leftMenuSegueName else { return }
        overlayView.frame = contentView.bounds
        contentView.addSubview(overlayView)
        performSegue(withIdentifier: segueName, sender: self)
    }

    func setupRightMenu() {
		guard let segueName = rightMenuSegueName else { return }
        overlayView.frame = contentView.bounds
        contentView.addSubview(overlayView)
        performSegue(withIdentifier: segueName, sender: self)
    }

	func updateLeftMenuFrame() {
		guard let window = UIWindow.keyWindow else {return}
		let x = menuState == .leftOpened ? 0 : -leftMenuWidth
        leftMenuVC?.view.frame = CGRect(x: x, y: 0, width: leftMenuWidth, height: window.height)
	}

	func updateRightMenuFrame() {
		guard let window = UIWindow.keyWindow else {return}
		let x = menuState == .rightOpened ? (window.width - rightMenuWidth) : window.width
		rightMenuVC?.view.frame = CGRect(x: x, y: 0, width: rightMenuWidth, height: window.height)
	}

    func setupGestures() {
        contentPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        contentPanGestureRecognizer.delegate = self
        
        contentTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        leftMenuPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        leftMenuPanGestureRecognizer.delegate = self

        rightMenuPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        rightMenuPanGestureRecognizer.delegate = self
    }
    
    func addGestures() {
        contentView.addGestureRecognizer(contentPanGestureRecognizer)
        overlayView.addGestureRecognizer(contentTapGestureRecognizer)
        leftMenuVC?.view.addGestureRecognizer(leftMenuPanGestureRecognizer)
		rightMenuVC?.view.addGestureRecognizer(rightMenuPanGestureRecognizer)
    }

	@objc func handleShowLeftMenuNote(_ note: Notification) {
		showLeftMenu(animated: true, completion: nil)
	}

	@objc func handleShowRightMenuNote(_ note: Notification) {
		showRightMenu(animated: true, completion: nil)
	}

    @objc func handleTap(_ tap: UITapGestureRecognizer) {
        if tap == self.contentTapGestureRecognizer {
			if menuState == .leftOpened {
				hideLeftMenu(animated: true)
			} else if menuState == .rightOpened {
				hideRightMenu(animated: true)
			}
        }
    }
    
    @objc func handlePan(_ pan: UIPanGestureRecognizer) {
        guard pan == self.leftMenuPanGestureRecognizer || pan == self.rightMenuPanGestureRecognizer || pan == self.contentPanGestureRecognizer else {
            return
        }

		enum PanIntentMenu {
			case left
			case right
		}

        struct Holder {
            static var firstNonZeroHorizontalVelocity: CGFloat = 0
            static var lastNonZeroHorizontalVelocity: CGFloat = 0
        }

		//guard let leftMenuVC = leftMenuVC, let leftMenuView = leftMenuVC.view else { return }

		var panIntentMenu: PanIntentMenu = .left

        let leftMenuView = leftMenuVC?.view
		let rightMenuView = rightMenuVC?.view

        let panningView = pan.view
        let translation = pan.translation(in: panningView)

        let velocity = pan.velocity(in: view)
        if velocity.x != 0 {
            Holder.lastNonZeroHorizontalVelocity = velocity.x

			if Holder.firstNonZeroHorizontalVelocity == 0 {
				Holder.firstNonZeroHorizontalVelocity = velocity.x
			}
        }

		if menuState == .closed {
			panIntentMenu = Holder.firstNonZeroHorizontalVelocity < 0 ? .right : .left
		} else if menuState == .leftOpened {
			panIntentMenu = .left
		} else if menuState == .rightOpened {
			panIntentMenu = .right
		}

        if pan.state == .began {
            if self.menuState == .closed {
                if velocity.x > 0 {

					self.updateLeftMenuFrame()
                    self.delegate?.leftMenuWillShow()
                } else {
					self.updateRightMenuFrame()
					self.delegate?.rightMenuWillShow()
                }
            } else {
				if velocity.x < 0, menuState == .leftOpened {
                    self.delegate?.leftMenuWillHide()
				} else if velocity.x > 0, menuState == .rightOpened {
					self.delegate?.rightMenuWillHide()
				}
            }
            pan.setTranslation(.zero, in: panningView)
		} else if pan.state == .ended || pan.state == .cancelled || pan.state == .failed {

			if panIntentMenu == .left, let leftMenuView = leftMenuView {
				let progressToAnimate: CGFloat = Holder.lastNonZeroHorizontalVelocity > 0 ? 1 : 0
				animator.animate(leftMenuView: leftMenuView, contentView: contentView, progress: progressToAnimate, animated: true) {
					if progressToAnimate == 0 {
						//Closed
						self.menuState = .closed
						self.delegate?.leftMenuDidHide()
					} else {
						//Opened
						self.menuState = .leftOpened
						self.delegate?.leftMenuDidShow()
					}
				}
			} else if panIntentMenu == .right, let rightMenuView = rightMenuView {
				let progressToAnimate: CGFloat = Holder.lastNonZeroHorizontalVelocity < 0 ? 1 : 0
				animator.animate(rightMenuView: rightMenuView, contentView: contentView, progress: progressToAnimate, animated: true) {
					if progressToAnimate == 0 {
						//Closed
						self.menuState = .closed
						self.delegate?.rightMenuDidHide()
					} else {
						//Opened
						self.menuState = .rightOpened
						self.delegate?.rightMenuDidShow()
					}
				}
			}

			Holder.firstNonZeroHorizontalVelocity = 0
        } else {
			var progress: CGFloat = 0

			if panIntentMenu == .left, let leftMenuView = leftMenuView {
				if menuState == .closed {
					progress = translation.x / leftMenuWidth
				} else {
					progress = 1 + translation.x / leftMenuWidth
				}

				animator.animate(leftMenuView: leftMenuView,
								 contentView: contentView,
								 progress: progress,
								 animated: false,
								 completion: nil)
			} else if panIntentMenu == .right, let rightMenuView = rightMenuView {
				if menuState == .closed {
					progress = -translation.x / rightMenuWidth
				} else {
					progress = 1 - translation.x / rightMenuWidth
				}
				animator.animate(rightMenuView: rightMenuView,
								 contentView: contentView,
								 progress: progress,
								 animated: false,
								 completion: nil)
			}
        }
    }
}

extension AMSlideMenuMainViewController: UIGestureRecognizerDelegate {
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == leftMenuPanGestureRecognizer || gestureRecognizer == rightMenuPanGestureRecognizer || gestureRecognizer == contentPanGestureRecognizer {
            if let pan = gestureRecognizer as? UIPanGestureRecognizer {
                let velocity = pan.velocity(in: pan.view)
                let isHorizontalGesture = abs(velocity.y) < abs(velocity.x)
                
                if !isHorizontalGesture {
                    return false
                }
                
                if menuState != .closed {
                    return true
                }

				let point = pan.location(in: contentView)

                if velocity.x > 0 {
					if let rightMenuFrame = rightMenuVC?.view.layer.presentation()?.frame, rightMenuFrame.origin.x < contentView.bounds.width {
						print(rightMenuFrame)
						return false
					}
                    return point.x <= contentView.bounds.width * CGFloat(panGestureWorkingAreaPercent) / 100
				} else {
					if let leftMenuFrame = leftMenuVC?.view.layer.presentation()?.frame, leftMenuFrame.maxX > 0 {
						return false
					}
					return point.x > contentView.bounds.width * (1 - CGFloat(panGestureWorkingAreaPercent) / 100)
				}
            }
        }
        return true
    }
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == self.contentPanGestureRecognizer else {return true}
        
        let velocity = self.contentPanGestureRecognizer.velocity(in: self.contentPanGestureRecognizer.view)
        let isHorizontalGesture = abs(velocity.y) < abs(velocity.x)
        
        if otherGestureRecognizer.view is UITableView {
            if isHorizontalGesture {
                let directionIsLeft = velocity.x < 0
                if directionIsLeft {
                    if menuState == .closed {
                        contentPanGestureRecognizer.isEnabled = false
                        contentPanGestureRecognizer.isEnabled = true
                        return true
                    }
                } else {
                    let tableView = otherGestureRecognizer.view as! UITableView
                    let point = otherGestureRecognizer.location(in: tableView)
                    if let indexPath = tableView.indexPathForRow(at: point), let cell = tableView.cellForRow(at: indexPath) {
                        if (cell.isEditing) {
                            contentPanGestureRecognizer.isEnabled = false
                            contentPanGestureRecognizer.isEnabled = true
                            return true
                        }
                    }
                }
            }
        } else {
            if let c = NSClassFromString("UITableViewCellScrollView"), otherGestureRecognizer.view?.isKind(of: c) ?? false {
                return true
            }
        }
        
        return false
    }
}

extension AMSlideMenuMainViewController {
    public enum MenuState {
        case closed
        case leftOpened
		case rightOpened
    }
}

extension NSNotification.Name {
	public static let showLeftMenu = NSNotification.Name("showLeftMenu")
	public static let showRightMenu = NSNotification.Name("showRightMenu")
}
