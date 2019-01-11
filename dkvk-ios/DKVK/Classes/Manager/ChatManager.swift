//
//  ChatManager.swift
//  DKVK
//
//  Created by Hadevs on 08/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import Foundation

final class ChatManager: FirebaseManager {
	static let shared = ChatManager()
	
	func send(message: Message) {
		guard let dict = message.dictionary else {
			return
		}
		
		sourceRef.child(message.id).setValue(dict)
	}
}
