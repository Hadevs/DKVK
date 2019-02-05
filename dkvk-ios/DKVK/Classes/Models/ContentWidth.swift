//
//  ContentWidth.swift
//  DKVK
//
//  Created by Hadevs on 03/02/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

class ContentWidth {
	let width: CGFloat
	
	init(content: String, copyLabel: UILabel) {
		let label = UILabel()
		label.numberOfLines = copyLabel.numberOfLines
		label.font = copyLabel.font
		label.text = content
		label.sizeToFit()
		self.width = label.frame.width
	}
}
