//
//  MenuChooserViewController.swift
//  AMSlideMenuExample
//
//  Created by Artur Mkrtchyan on 5/20/20.
//  Copyright © 2020 Artur Mkrtchyan. All rights reserved.
//

import UIKit
import AMSlideMenu

class MenuChooserViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let mainContainerVC = segue.destination as? MainContainerViewController else { return }
		if segue.identifier == "slidingMenues" {
			mainContainerVC.animationOptions = [.slidingMenu, .menuShadow, .blurBackground, .dimmedBackground]
		} else {
			mainContainerVC.animationOptions = [.fixedMenu, .content, .contentShadow, .dimmedBackground]
		}
	}
}
