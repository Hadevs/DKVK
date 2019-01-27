//
//  DetailFieldTableViewCell.swift
//  DKVK
//
//  Created by Hadevs on 27/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

class DetailFieldTableViewCell: UITableViewCell, NibLoadable, HeightContainable {
	@IBOutlet weak private var label: UILabel!
	@IBOutlet weak private var textField: UITextField!
	@IBOutlet weak private var labelWidthConstraint: NSLayoutConstraint!
	
	static var height: CGFloat {
		return 54
	}
	
	var textChanged: ItemClosure<String>?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
		selectionStyle = .none
		label.textAlignment = .right
		addTargets()
	}
	
	private func addTargets() {
		textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
	}
	
	func activeTextField() {
		textField.becomeFirstResponder()
	}
	
	@objc private func textFieldChanged() {
		let text = textField.text ?? ""
		textChanged?(text)
	}
	
	func set(secure: Bool) {
		textField.isSecureTextEntry = secure
	}
	
	func set(title: String?) {
		label.text = title
	}
	
	func adjustWidth(by titles: [String]) {
		var width: CGFloat = 0
		for title in titles {
			let label = UILabel()
			label.numberOfLines = self.label.numberOfLines
			label.font = self.label.font
			label.text = title
			label.sizeToFit()
			width = max(width, label.frame.width)
		}
		labelWidthConstraint.constant = width
	}
	
	func set(placeholder: String?) {
		textField.placeholder = placeholder
	}
}
