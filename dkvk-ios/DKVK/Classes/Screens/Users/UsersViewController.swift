//
//  UsersViewController.swift
//  DKVK
//
//  Created by Hadevs on 13/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!

	private var controller: UsersController?
	
	convenience init(controller: UsersController) {
		self.init()
		self.controller = controller
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		controller?.viewDidLoad()
	}
}
