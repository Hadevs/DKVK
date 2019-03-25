//
//  StartRouter.swift
//  DKVK
//
//  Created by Hadevs on 02/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

final class StartRouter {
	private weak var mainRouter: Router?
	
	private var registerViewController: RegisterViewController?
	
	init(mainRouter: Router) {
		self.mainRouter = mainRouter
	}
	
	func set(registerViewController: RegisterViewController) {
		self.registerViewController = registerViewController
	}
	
	func goToRegisterScreen(from source: UIViewController) {
		guard let registerViewController = registerViewController else {
			return
		}
		source.navigationController?.pushViewController(registerViewController, animated: true)
	}
	
	func goToLoginScreen(from source: UIViewController) {
		let vc = LoginViewController()
		source.navigationController?.pushViewController(vc, animated: true)
	}
	
	func routeAfterSuccessAuth(from source: UIViewController) {
		guard let vc = mainRouter?.startControllerAfterAuth else {
			return
		}
		source.present(vc, animated: true, completion: nil)
	}
}
