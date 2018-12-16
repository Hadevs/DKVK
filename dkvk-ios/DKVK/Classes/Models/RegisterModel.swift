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
	
	var isFilled: Bool {
		guard !(email ?? "").isEmpty, !(password ?? "").isEmpty, birthday != nil else {
			return false
		}
		
		return true
	}
}
