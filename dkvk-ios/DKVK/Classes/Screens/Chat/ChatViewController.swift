//
//  ChatViewController.swift
//  DKVK
//
//  Created by Hadevs on 08/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		delegating()
	}
	
	private func delegating() {
		tableView.delegate = self
		tableView.dataSource = self
	}
}

extension ChatViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44
	}
}

extension ChatViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
}
