//
//  AddPhotoTableViewCell.swift
//  DKVK
//
//  Created by Hadevs on 03/02/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

class AddPhotoTableViewCell: UITableViewCell, NibLoadable {
	
	@IBOutlet private weak var circleBackground: UIView!
	@IBOutlet private weak var cameraImageView: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		circleBackground.layer.cornerRadius = circleBackground.frame.height / 2
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
