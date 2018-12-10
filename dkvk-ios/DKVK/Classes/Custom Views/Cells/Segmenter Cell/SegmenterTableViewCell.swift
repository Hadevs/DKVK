//
//  SegmenterTableViewCell.swift
//  DKVK
//
//  Created by Hadevs on 10/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

class SegmenterTableViewCell: UITableViewCell, NibLoadable {
	
	@IBOutlet private weak var segmentControl: UISegmentedControl!
	
	var indexChanged: ItemClosure<Int>?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		selectionStyle = .none
		
		addTargets()
	}
	
	private func addTargets() {
		segmentControl.addTarget(self, action: #selector(segmentControlChangedIndex(sender:)), for: .valueChanged)
	}
	
	@objc private func segmentControlChangedIndex(sender: UISegmentedControl) {
		indexChanged?(sender.selectedSegmentIndex)
	}
}
