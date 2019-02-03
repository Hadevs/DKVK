//
//  DKUser.swift
//  DKVK
//
//  Created by Hadevs on 08/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import Foundation

class DKUser: Codable, Searchable {
    var parameter: String {
        return "\(id)\(birthday)\(email)\(password)\(sex)"
    }
    
	var id: String?
	var birthday: TimeInterval?
	var email: String?
	var password: String?
	var sex: String?
}
