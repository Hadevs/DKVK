//
//  CreatePostModel.swift
//  DKVK
//
//  Created by Hadevs on 08/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

final class CreatePostModel {
	private(set) var text: String?
	private(set) var image: UIImage?
	
	func set(text: String?) {
		self.text = text
	}
	
	func set(image: UIImage?) {
		self.image = image
	}
	
	var imageData: Data? {
		return image?.jpegData(compressionQuality: 0.5)
	}
	
	var isFilled: Bool {
		return text != nil || image != nil
	}
}
