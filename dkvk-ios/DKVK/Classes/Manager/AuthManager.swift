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
		
		let usersRef = sourceRef.child("users")
		let id = UUID.init().uuidString
		auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let _ = result {
                // TODO: use result if need
                var dict = model.dict
                dict["id"] = id
                usersRef.child(id).setValue(dict)
                completion(.success(()))
            } else {
                completion(.failure(CustomErrors.unknownError))
            }
			
		}
	}
}

// did not create new files for eazy checking


typealias ResultHandler<Value> = (Result<Value>) -> Void

/// better use own that alamofire one
enum Result<Value> {
    case success(Value)
    case failure(Error)
}

/// can be created ApiErrors and etc.
enum CustomErrors {
    case invalidEmail
    case unknownError
    case serverError
}
extension CustomErrors: LocalizedError {
    /// can be created extension for String
    /// errorDescription is used in Error.localizedDescription
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return NSLocalizedString("email_is_not_valid", comment: "")
        case .unknownError:
            /// we will use server_error key to display user internal error
            return NSLocalizedString("server_error", comment: "")
        case .serverError:
            return NSLocalizedString("server_error", comment: "")
        }
    }
}

enum Validators {
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
