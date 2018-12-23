//
//  RegisterModel.swift
//  DKVK
//
//  Created by Hadevs on 16/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

class RegisterModel {
	var photo: UIImage?
	var email: String?
	var password: String?
	var sex: Sex = .male
	var birthday: Date?
	var userId: String
	
	var isFilled: Bool {
		guard !(email ?? "").isEmpty, !(password ?? "").isEmpty, birthday != nil else {
			return false
		}
		
		return true
	}
	
	var dict: [String: Any] {
		return [
			"email": email ?? "",
			"password": password ?? "",
			"sex": sex.rawValue,
			"birthday": (birthday ?? Date()).timeIntervalSince1970 // 1010101212010
		]
	}
	
	init() {
		self.userId = UUID.init().uuidString
	}
}
