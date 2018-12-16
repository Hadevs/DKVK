//
//  Extensions+UIViewController.swift
//  DKVK
//
//  Created by Hadevs on 16/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

extension UIViewController {
	func showAlert(with title: String, and message: String) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		alertController.addAction(okAction)
		present(alertController, animated: true, completion: nil)
	}
}
