//
//  ViewController.swift
//  AMSlideMenuExample
//
//  Created by Artur Mkrtchyan on 5/17/20.
//  Copyright © 2020 Artur Mkrtchyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func backToRoot(_ sender: Any) {
		slideMenuMainVC?.navigationController?.popToRootViewController(animated: true)
	}

}

