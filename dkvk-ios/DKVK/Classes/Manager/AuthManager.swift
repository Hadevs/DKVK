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
	var currentUser: User?
	static let shared = AuthManager()
	private init() {}
	
	private var sourceRef: DatabaseReference {
		return Database.database().reference()
	}
	
	private var usersRef: DatabaseReference {
		return sourceRef.child("users")
	}
	
	private let auth = Auth.auth()
	
	func signIn(with email: String, and password: String, completion: @escaping ItemClosure<AuthResult>) {
        guard let storedPassword = SecureStorageManager.shared.loadPasswordBy(email: email),
            password == storedPassword else {
                completion(AuthResult.error("Wrong password, please try again"))
            return
        }
		auth.signIn(withEmail: email, password: password) { (result, error) in
			if let error = error {
				completion(AuthResult.error(error.localizedDescription))
				return
			}
			
			guard let user = result?.user else {
				completion(AuthResult.error("User not exist"))
				return
			}
			
			self.currentUser = user
			completion(AuthResult.success)
		}
	}
	
	func register(with model: RegisterModel, completion: @escaping ResultHandler<Void>) {
		guard model.isFilled else {
			completion(.failure(CustomErrors.unknownError))
			return
		}
		guard let email = model.email, let password = model.password else {
			completion(.failure(CustomErrors.unknownError))
			return
		}
		
		/// eazy validation for @ and dot localy. other ones are on the server
		guard Validators.isSimpleEmail(email) else {
			completion(.failure(CustomErrors.invalidEmail))
			return
		}
		
		let id = model.userId
		auth.createUser(withEmail: email, password: password) { (result, error) in
			if let error = error {
				completion(.failure(error))
                return
			}

            guard let _ = result else {
                completion(.failure(CustomErrors.unknownError))
                return
            }

            // TODO: use result if need
            var dict = model.dict
            dict["id"] = id
            self.usersRef.child(id).setValue(dict, withCompletionBlock: { (error, reference) in
                self.saveToSecureStorage(email: email, password: password)
                self.addAvatarUrlIfNeeded(for: model)
                completion(.success(()))
            })
		}
	}
	
	func addAvatarUrlIfNeeded(for model: RegisterModel) {
		StorageManager.shared.loadAvatarUrl(for: model) { (url) in
			guard let url = url else {
				return
			}
			
			self.usersRef.child(model.userId).child("avatarUrl").setValue(url.absoluteString)
		}
	}

    func saveToSecureStorage(email: String, password: String) {
        SecureStorageManager.shared.save(email: email, password: password, completionHandler: { (error) in
            if let error = error {
                print(String(describing: error.errorDescription))
            }
        })
    }
}
