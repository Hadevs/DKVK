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
	private let dependencyProvider = DependencyProvider()
	
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		configureExternalFrameworks()
		let router = dependencyProvider.fetchMainRouter()
		let authManager = dependencyProvider.fetchAuthManager()
		
		let startRouter = dependencyProvider.fetchStartRouter(mainRouter: router)
		let registerViewController = dependencyProvider.fetchRegisterViewController(authManager: authManager)
		startRouter.set(registerViewController: registerViewController)
		
		let rootViewController = dependencyProvider.fetchStartViewController(startRouter: startRouter)
		
		router.root(&window, rootViewController: rootViewController)
		
		
		let userManager = dependencyProvider.fetchUserManager(authManager: authManager)
		authManager.signInIfNeeded { _ in
			userManager.fetchCurrentUser()
		}
		
    return true
  }
	
	private func configureExternalFrameworks() {
		FirebaseApp.configure()
	}
}

