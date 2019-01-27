//
//  TitleHeaderView.swift
//  DKVK
//
//  Created by Hadevs on 27/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

class TitleHeaderView: UIView, NibLoadable {
	@IBOutlet private weak var label: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func set(text: String?) {
		label.text = text
	}
}
