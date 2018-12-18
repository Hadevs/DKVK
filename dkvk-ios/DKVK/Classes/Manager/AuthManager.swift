//
//  AuthManager.swift
//  DKVK
//
//  Created by Hadevs on 16/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class AuthManager {
	static let shared = AuthManager()
	private init() {}
	
	private var sourceRef: DatabaseReference {
		return Database.database().reference()
	}
	
	private let auth = Auth.auth()
	
	func register(with model: RegisterModel, onSuccess: @escaping VoidClosure, onError: @escaping (_ errorMessage: String?) -> Void) {
		guard model.isFilled else { return }
		guard let email = model.email, let password = model.password	else { return }
		guard let user = self.auth.currentUser else { return }
		guard let imageData = model.photo?.jpegData(compressionQuality: 0.2) else { return }
		
		auth.createUser(withEmail: email, password: password) { (result, error) in
			
			if let error = error {
				print(error.localizedDescription)
			}
			
			let storageRef = Storage.storage().reference().child("profile_image").child(user.uid)
			let metadata = StorageMetadata()
			metadata.contentType = "image/jpg"

			storageRef.putData(imageData, metadata: metadata) { metadata, error in
				
				if let error = error {
					print(error.localizedDescription)
					return
				}
			
				else {
					storageRef.downloadURL { url, error in
						if let error = error {
							print(error.localizedDescription)
							return
						}
						
						if url != nil {
							
							user.sendEmailVerification(completion: nil)
							
							var dict = model.dict
							dict["photo"] = url?.absoluteString
							self.registerUserIntoDatabase(uid: user.uid, dict: dict, onSuccess: onSuccess)
							
						}
					}
				}
			}
		}
	}
	
	private func registerUserIntoDatabase(uid: String, dict: [String : Any], onSuccess: @escaping VoidClosure) {
		let userRef = self.sourceRef.child("users").child(uid)
		userRef.setValue(dict) { error, ref in
			if let error = error {
				print(error.localizedDescription)
				return
			}
			
			onSuccess()
			
		}
	}
}
