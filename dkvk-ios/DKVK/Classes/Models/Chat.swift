//
//  Chat.swift
//  DKVK
//
//  Created by Hadevs on 13/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import Foundation

class Chat: Codable {
	var id: String?
	var messages: [Message] = []
	var users: [DKUser] = []
	
	// for first chat
	init(id: String, users: [DKUser]) {
		self.id = id
		self.users = users
	}
	
	var oponent: DKUser? {
		return users.filter { UserManager.shared.currentUser?.id != $0.id }.first
	}
}
