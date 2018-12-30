//
//  PostTableViewCell.swift
//  DKVK
//
//  Created by Hadevs on 30/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell, NibLoadable {
	
	@IBOutlet weak var textView: UITextView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
}
