//
//  post.swift
//  DKVK
//
//  Created by Hadevs on 30/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import Foundation
import Firebase

class Post: Codable {
	enum `Type`: String, Codable {
		case text
		case textAndImage
		case image
	}
	var id: String
	var type: Type
	var text: String?
	var imageData: Data?
	var dateUnix: TimeInterval
	
	init() {
		self.id = UUID().uuidString
		self.dateUnix = Date().timeIntervalSince1970
		self.type = .text
	}
	
	convenience init(text: String) {
		self.init()
		self.type = .text
		self.text = text
	}
}
