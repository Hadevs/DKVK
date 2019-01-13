//
//  Message.swift
//  DKVK
//
//  Created by Hadevs on 08/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import Foundation

final class Message: Codable {
	var id: String
	var senderId: String? // id of sender user
	var text: String?
	var time: TimeInterval?
	
	init() {
		id = UUID().uuidString
	}
	
	var isSenderOponent: Bool {
		return senderId != UserManager.shared.currentUser?.id
	}
	
	convenience init(text: String) {
		self.init()
		self.senderId = UserManager.shared.currentUser?.id
		self.text = text
		self.time = Date().timeIntervalSince1970
	}
	
	func getText() -> String {
		return text ?? ""
	}
	
	func getFormattedTime() -> String {
		if let time = time {
			let date = Date.init(timeIntervalSince1970: time)
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "HH:mm"
			return dateFormatter.string(from: date)
		} else {
			return "???"
		}
	}
}
