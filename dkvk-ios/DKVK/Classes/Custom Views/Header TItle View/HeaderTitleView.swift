//
//  HeaderTitleView.swift
//  DKVK
//
//  Created by Hadevs on 10/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

class HeaderTitleView: UIView, NibLoadable {
	@IBOutlet private weak var label: UILabel!
	
	func set(title: String) {
		label.text = title
	}
}
