//
//  DKSegmentedControl.swift
//  DKVK
//
//  Created by Hadevs on 03/02/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

class DKSegmentedControl: UIControl {
	struct Item {
		var title: String
		var image: UIImage
	}
	
	private let stackView: UIStackView = UIStackView()
	private var items: [Item] = []
	
	private(set) var selectedIndex = 0 {
		didSet {
			sendActions(for: .valueChanged)
			selectAnimated(index: selectedIndex)
		}
	}
	
	convenience init(items: [Item]) {
		self.init()
		self.items = items
	}
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		addStackView()
		addViews()
		selectAnimated(index: selectedIndex)
	}
	
	private func addStackView() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 0
		stackView.distribution = .equalSpacing
		stackView.axis = .horizontal
		stackView.alignment = .leading
		addSubview(stackView)
		
		let constraints = NSLayoutConstraint.contraints(withNewVisualFormat: "H:|[v]|,V:|[v]|", dict: ["v": stackView])
		addConstraints(constraints)
	}
	
	private func selectAnimated(index: Int) {
		stackView.arrangedSubviews.enumerated().forEach { (i, view) in
			if let itemView = view as? DKSegmentItemView {
				i == index ? itemView.show() : itemView.hide()
			}
		}
	}
	
	private func addViews() {
		items.enumerated().forEach { (i, model) in
			let itemView = DKSegmentItemView()
			itemView.touched = {
				self.selectedIndex = i
			}
			itemView.configure(by: model)
			stackView.addArrangedSubview(itemView)
		}
	}
}
