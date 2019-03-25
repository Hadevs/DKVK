//
//  StartController.swift
//  DKVK
//
//  Created by Hadevs on 24/03/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import Foundation

class StartController: Lifecycable {
	private weak var viewController: ViewController?
	weak var router: StartRouter?
	
	func set(viewController: ViewController) {
		self.viewController = viewController
	}
	
	func viewDidLoad() {
			addTargets()
	}
	
	private func addTargets() {
		viewController?.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
		viewController?.signInButton.addTarget(self, action: #selector(signinButtonClicked), for: .touchUpInside)
	}
	
	@objc private func signinButtonClicked() {
		if let viewController = self.viewController {
			router?.goToLoginScreen(from: viewController)
		}
	}
	
	@objc private func signUpButtonClicked() {
		if let viewController = self.viewController {
			router?.goToRegisterScreen(from: viewController)
		}
	}

}
