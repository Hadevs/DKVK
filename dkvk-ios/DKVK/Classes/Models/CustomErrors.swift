//
//  CustomErrors.swift
//  DKVK
//
//  Created by Hadevs on 23/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import Foundation

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
    case keychainError
    case biometricAuthError(String)
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
        case .keychainError:
            /// generally, user shouldn't know about this error
            /// because it is secure storage
            return NSLocalizedString("keychain_error", comment: "")
        case .biometricAuthError(let error):
            return error
        }
    }
}
