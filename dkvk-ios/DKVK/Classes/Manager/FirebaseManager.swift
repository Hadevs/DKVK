//
//  FirebaseManager.swift
//  DKVK
//
//  Created by Hadevs on 30/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseManager {
	var sourceRef: DatabaseReference {
		return Database.database().reference()
	}
	
	var usersRef: DatabaseReference {
		return sourceRef.child("users")
	}
	
	var chatsRef: DatabaseReference {
		return sourceRef.child("chats")
	}
}
