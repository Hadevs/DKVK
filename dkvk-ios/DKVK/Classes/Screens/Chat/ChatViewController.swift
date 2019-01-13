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
	@IBOutlet weak var textField: UITextField!
	
	private var user: DKUser?
	private var chat: Chat?
	private lazy var controller = ChatController.init(viewController: self, chat: chat)
	
	convenience init(user: DKUser, chat: Chat) {
		self.init()
		self.user = user
		self.chat = chat
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		controller.viewDidLoad()
		tableView.separatorColor = .clear
	}
	
	@IBAction func sendClicked() {
		let text = textField.text
		controller.sendButtonClicked(with: text)
	}
}
