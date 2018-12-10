//
//  ViewController.swift
//  DKVK
//
//  Created by Hadevs on 02/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var logoView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Decorator.decorate(self)
		addTargets()
  }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	private func addTargets() {
		signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
		signInButton.addTarget(self, action: #selector(signinButtonClicked), for: .touchUpInside)
	}
	
	@objc private func signinButtonClicked() {
		
	}
	
	@objc private func signUpButtonClicked() {
		StartRouter.shared.goToRegisterScreen(from: self)
	}
}

extension ViewController {
  fileprivate class Decorator {
    static let buttonCornerRadius: CGFloat = 4
    private init() {}
    
    static func decorate(_ vc: ViewController) {
      vc.signUpButton.layer.cornerRadius = buttonCornerRadius
      vc.signUpButton.layer.borderColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
    }
  }
}
