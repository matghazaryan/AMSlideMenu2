//
//  MainContainerViewController.swift
//  AMSlideMenuExample
//
//  Created by Artur Mkrtchyan on 5/20/20.
//  Copyright © 2020 Artur Mkrtchyan. All rights reserved.
//

import UIKit
import AMSlideMenu

class MainContainerViewController: AMSlideMenuMainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}
}
