//
//  UserManager.swift
//  DKVK
//
//  Created by Hadevs on 08/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import Firebase

final class UserManager: FirebaseManager {
	static let shared = UserManager()
	
	func loadingUsers(completion: @escaping ItemClosure<[DKUser]>) {
		usersRef.observe(.value) { (snapshot) in
			if let dict = (snapshot.value as? [String: [String: Any]]) {
				completion(dict.map({ (userDict) -> DKUser in
					return try! DKUser(from: userDict.value)
				}))
			}
		}
	}
}
