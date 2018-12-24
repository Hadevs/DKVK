//
//  SecureStorageManager.swift
//  DKVK
//
//  Created by Антон Савинов on 24/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import Foundation
import Locksmith

final class SecureStorageManager {
    static let shared = SecureStorageManager()

    private init() {}

    func save(email: String, password: String, completionHandler: ItemClosure<CustomErrors?>) {
        let data = [Keys.email.rawValue: email,
                    Keys.password.rawValue: password]
        do {
            try Locksmith.saveData(data: data, forUserAccount: email)
            completionHandler(nil)
        }
        catch {
            completionHandler(CustomErrors.keychainError)
        }
    }

    func loadPasswordBy(email: String) -> String? {
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: email)
        let password = dictionary?[Keys.password.rawValue] as? String ?? nil
        return password
    }
}

private extension SecureStorageManager {
    enum Keys: String {
        case email
        case password
    }
}
