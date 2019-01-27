//
//  TextFooterView.swift
//  DKVK
//
//  Created by Hadevs on 27/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

class TextFooterView: UIView, NibLoadable {
	
	@IBOutlet private weak var textView: UITextView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func set(text: String?) {
		textView.text = text
	}
}
