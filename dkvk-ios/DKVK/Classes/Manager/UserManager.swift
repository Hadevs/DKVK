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
	
	var currentUser: DKUser?
	
	func fetchCurrentUser(callback: VoidClosure? = nil) {
		guard let currentUserId = AuthManager.shared.currentUser?.uid else {
			return
		}
		
		usersRef.child(currentUserId).observeSingleEvent(of: .value) { (snapshot) in
			if let dict = snapshot.value as? [String: Any] {
				self.currentUser = try? DKUser.init(from: dict)
				callback?()
			}
		}
	}
	
	func loadingUsers(completion: @escaping ItemClosure<[DKUser]>) {
		usersRef.observe(.value) { (snapshot) in
			if let dict = (snapshot.value as? [String: [String: Any]]) {
				completion(dict.map({ (userDict) -> DKUser in
					return try! DKUser(from: userDict.value)
				}).filter { $0.id != self.currentUser?.id })
			}
		}
	}
}
