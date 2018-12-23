//
//  StorageManager.swift
//  DKVK
//
//  Created by Hadevs on 23/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit
import FirebaseStorage

class StorageManager {
	static let shared = StorageManager()
	
	private init() {}
	
	private let sourceRef = Storage.storage().reference()
	
	func upload(photo: UIImage, by model: RegisterModel, closure: VoidClosure? = nil) {
		guard let data = photo.jpegData(compressionQuality: 0.5) else {
			return
		}
		sourceRef.child(Keys.avatars.rawValue).child(model.userId).putData(data, metadata: nil) { (metadata, error) in
			closure?()
		}
	}
	
	func loadAvatarUrl(for model: RegisterModel, closure: @escaping OptionalItemClosure<URL>) {
		sourceRef.child(Keys.avatars.rawValue).child(model.userId).downloadURL { (url, error) in
			closure(url)
		}
	}
}

extension StorageManager {
	private enum Keys: String {
		case avatars
	}
}
