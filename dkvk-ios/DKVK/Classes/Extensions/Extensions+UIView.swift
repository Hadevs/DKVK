//
//  Extensions+UIView.swift
//  DKVK
//
//  Created by Hadevs on 02/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

extension UIView {
	func round() {
		layer.cornerRadius = frame.height / 2
	}
}

extension UIView {
	enum SeparatorPosition: Int {
		case top = 5
		case bottom = 10
	}
	
	func addSeparator(on position: SeparatorPosition, insets: UIEdgeInsets = .zero) {
		let tag = 0x123578 * position.rawValue
		
		guard self.viewWithTag(tag) == nil else {
			return
		}
		
		let separatorView = UIView()
		separatorView.backgroundColor = #colorLiteral(red: 0.7333333333, green: 0.7607843137, blue: 0.7921568627, alpha: 1)
		separatorView.translatesAutoresizingMaskIntoConstraints = false
		let height = 0.5
		let verticalFormat = position == .top ? "|[separatorView(\(height))]" : "[separatorView(\(height))]|"
		addSubview(separatorView)
		let constraints = NSLayoutConstraint.contraints(withNewVisualFormat: "H:|-(\(insets.left))-[separatorView]-(\(insets.right))-|,V:\(verticalFormat)", dict: ["separatorView": separatorView])
		addConstraints(constraints)
	}
}
