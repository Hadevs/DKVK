//
//  SecureStorageManager.swift
//  DKVK
//
//  Created by Антон Савинов on 24/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import Foundation
import Locksmith

final class SecureStorageManager {
	static let shared = SecureStorageManager()
	
	let myUserAccountIdentifier = "MyUserAccountIdentifier"
	
	private init() {}
	
	func save(email: String?, password: String?, completionHandler: ItemClosure<CustomErrors?>) {
		guard let email = email, let password = password else {
			completionHandler(CustomErrors.keychainError)
			return
		}
		let data = [Keys.email.rawValue: email,
								Keys.password.rawValue: password]
		do {
			try Locksmith.saveData(data: data, forUserAccount: myUserAccountIdentifier)
			completionHandler(nil)
		}
		catch {
			completionHandler(CustomErrors.keychainError)
		}
	}
	
	func eraseUserDataIfNeeded() {
		guard isLoggedIn() else {
			return
		}
		
		try? Locksmith.deleteDataForUserAccount(userAccount: myUserAccountIdentifier)
	}
	
	func loadEmailAndPassword() -> (email: String?, password: String?) {
		let dictionary = Locksmith.loadDataForUserAccount(userAccount: myUserAccountIdentifier)
		let email = dictionary?[Keys.email.rawValue] as? String ?? nil
		let password = dictionary?[Keys.password.rawValue] as? String ?? nil
		return (email: email, password: password)
	}
	
	func isLoggedIn() -> Bool {
		let credentials = loadEmailAndPassword()
		return credentials.email != nil && credentials.password != nil
	}
}

private extension SecureStorageManager {
	enum Keys: String {
		case email
		case password
	}
}
