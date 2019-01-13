//
//  ChatDataProvider.swift
//  DKVK
//
//  Created by Hadevs on 13/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import Foundation

final class ChatDataProvider {
	private var messages: [Message] = []
	
	func set(messages: [Message]) {
		self.messages = messages
	}
	
	func numberOfRows() -> Int {
		return messages.count
	}
	
	func message(by indexPath: IndexPath) -> Message {
		return messages[indexPath.row]
	}
}
