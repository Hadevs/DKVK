//
//  UserHeaderView.swift
//  DKVK
//
//  Created by Hadevs on 23/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

class UserHeaderView: UIView, NibLoadable {
	
	@IBOutlet private weak var avatarView: UIImageView!
	@IBOutlet private weak var usernameLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		avatarView.round()
	}
}
