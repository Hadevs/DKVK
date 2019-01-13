//
//  AppDelegate.swift
//  DKVK
//
//  Created by Hadevs on 02/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Router.shared.root(&window)
		FirebaseApp.configure()
		AuthManager.shared.signInIfNeeded { _ in
			UserManager.shared.fetchCurrentUser()
		}
		
    return true
  }
}

