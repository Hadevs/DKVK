//
//  InfoUserTableViewCell.swift
//  DKVK
//
//  Created by Hadevs on 02/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

class InfoUserTableViewCell: UITableViewCell, StaticCellProtocol {
	
	@IBOutlet private weak var backgroundFieldsView: UIView!
	@IBOutlet private weak var photoView: PhotoView!

	static var height: CGFloat {
		return 100
	}
	
	var photoViewClicked: VoidClosure?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		
		Decorator.decorate(cell: self)
		photoView.clicked = photoViewClicked
	}
}

extension InfoUserTableViewCell {
	fileprivate class Decorator {
		static func decorate(cell: InfoUserTableViewCell) {
			cell.selectionStyle = .none
			cell.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
			cell.backgroundFieldsView.layer.borderColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
			cell.backgroundFieldsView.layer.borderWidth = 0.5
		}
	}
}
