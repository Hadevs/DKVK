//
//  Extensions+UINavigationBar.swift
//  DKVK
//
//  Created by Hadevs on 27/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

extension UINavigationBar {
	func makeClear() {
		backgroundColor = .clear
		setBackgroundImage(UIImage(), for: .default)
		shadowImage = UIImage()
	}
}
