//
//  TextFieldTableViewCell.swift
//  DKVK
//
//  Created by Hadevs on 10/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, NibLoadable {
	
	@IBOutlet weak var textField: UITextField!
	
	var textChanged: ItemClosure<String>?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		addTargets()
	}
	
	private func addTargets() {
		textField.addTarget(self, action: #selector(textFieldChanged(sender:)), for: .editingChanged)
	}
	
	@objc private func textFieldChanged(sender: UITextField) {
		textChanged?(sender.text ?? "")
	}
	
}
