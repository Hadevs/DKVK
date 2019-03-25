//
//  DependencyProvider.swift
//  DKVK
//
//  Created by Hadevs on 24/03/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import Foundation

class DependencyProvider {
	func fetchMainRouter() -> Router {
		let router = Router()
		return router
	}
	
	func fetchStartRouter(mainRouter: Router) -> StartRouter {
		return StartRouter(mainRouter: mainRouter)
	}
	
	func fetchAuthManager() -> AuthManager {
		let authManager = AuthManager()
		return authManager
	}
	
	func fetchUserManager(authManager: AuthManager) -> UserManager {
		let userManager = UserManager(authManager: authManager)
		return userManager
	}
	
	func fetchRegisterViewController(authManager: AuthManager) -> RegisterViewController {
		let controller = RegisterController(authManager: authManager)
		let registerViewController = RegisterViewController(controller: controller)
		return registerViewController
	}
	
	func fetchStartViewController(startRouter: StartRouter) -> ViewController {
		let controller = StartController() // Бизнес логика
		controller.router = startRouter
		let viewController = ViewController(controller: controller) // UI
		controller.set(viewController: viewController)
		return viewController
	}
}
