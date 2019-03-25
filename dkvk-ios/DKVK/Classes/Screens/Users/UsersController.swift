//
//  UsersController.swift
//  DKVK
//
//  Created by Hadevs on 24/03/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

class UsersController: NSObject, Lifecycable {
	
	weak var usersViewController: UsersViewController?
	weak var userManager: UserManager?
	
	init(userManager: UserManager) {
		self.userManager = userManager
	}
	
	func set(viewController: UsersViewController) {
		self.usersViewController = viewController
	}
	
	var tableView: UITableView? {
		return usersViewController?.tableView
	}
	
	private var users: [DKUser] = [] {
		didSet {
			tableView?.reloadData()
		}
	}
	
	func viewDidLoad() {
		userManager?.loadingUsers {
			users in
			self.users = users
		}
		
		delegating()
	}
	
	private func delegating() {
		tableView?.delegate = self
		tableView?.dataSource = self
	}
}


extension UsersController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let currentUser = userManager?.currentUser else {
			return
		}
		
		let user = users[indexPath.row]
		let chat = Chat.init(id: UUID().uuidString, users: [currentUser, user])
		ChatManager.shared.startChatIfNeeded(chat: chat) {
			self.usersViewController?.showAlert(with: "Готово", and: "Чат создан!")
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44
	}
}

extension UsersController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		let user = users[indexPath.row]
		cell.textLabel?.text = user.email ?? user.id
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}
}

