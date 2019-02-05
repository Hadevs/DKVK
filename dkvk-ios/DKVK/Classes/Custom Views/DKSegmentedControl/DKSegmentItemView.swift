//
//  DKSegmentItemVIew.swift
//  DKVK
//
//  Created by Hadevs on 03/02/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

class DKSegmentItemView: UIView {
	// MARK: Configuration - private constrants
	private let animateDuration: TimeInterval = 0.25
	private let titleTrailingContant: CGFloat = -14
	
	// MARK: Configurable model
	private var model: DKSegmentedControl.Item?
	
	// MARK: Internal views
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.tintColor = .white
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
		label.textColor = .white
		return label
	}()
	
	// MARK: Dynamic constraints
	private lazy var labelWidthConstraint = titleLabel.widthAnchor.constraint(equalToConstant: 70)
	private lazy var labelTrailingConstraint = titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: titleTrailingContant)
	
	var touched: VoidClosure?
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		addImageView()
		addTitleView()
		backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		touched?()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = 9
	}
	
	func configure(by model: DKSegmentedControl.Item) {
		self.model = model
		imageView.image = model.image
		titleLabel.text = model.title
		adjustLabelWidth(by: model)
	}
	
	private func adjustLabelWidth(by model: DKSegmentedControl.Item) {
		let validWidthForLabel = ContentWidth(content: model.title, copyLabel: titleLabel).width
		labelWidthConstraint.constant = validWidthForLabel
		labelTrailingConstraint.constant = titleTrailingContant
	}
	
	func show() {
		guard let model = self.model else {
			return
		}
		
		UIView.animate(withDuration: animateDuration) {
			self.adjustLabelWidth(by: model)
			self.imageView.tintColor = .white
			self.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
			self.layoutIfNeeded()
		}
	}
	
	func hide() {
		UIView.animate(withDuration: animateDuration) {
			self.labelWidthConstraint.constant = 0
			self.labelTrailingConstraint.constant = 0
			self.imageView.tintColor = .black
			self.backgroundColor = .clear
			self.layoutIfNeeded()
		}
	}
	
	private func addImageView() {
		addSubview(imageView)
		let verticalHorizontalConstraints = NSLayoutConstraint.contraints(withNewVisualFormat: "H:|-12-[imageView],V:|-8-[imageView(17)]-8-|", dict: ["imageView": imageView])
		let aspectRatioConstraints = [NSLayoutConstraint.quadroAspect(on: imageView)]
		addConstraints(verticalHorizontalConstraints + aspectRatioConstraints)
	}
	
	private func addTitleView() {
		addSubview(titleLabel)
		
		let verticalHorizontalConstraints = NSLayoutConstraint.contraints(withNewVisualFormat: "H:[imageView]-12-[label],V:|-8-[label]-8-|", dict: ["imageView": imageView, "label": titleLabel])
		addConstraints(verticalHorizontalConstraints)
		labelWidthConstraint.isActive = true
		labelTrailingConstraint.isActive = true
	}
}
