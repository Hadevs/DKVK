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
}
