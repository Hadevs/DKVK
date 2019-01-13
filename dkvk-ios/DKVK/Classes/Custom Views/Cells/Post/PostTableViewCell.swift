//
//  PostTableViewCell.swift
//  DKVK
//
//  Created by Hadevs on 30/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell, NibLoadable {
	
	@IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var imageViewHeightConstraint: NSLayoutConstraint!

	override func awakeFromNib() {
		super.awakeFromNib()
	}
}

extension PostTableViewCell {
    func setup(with post: Post) {
        textView.text = post.text ?? ""
        if let imageData = post.imageData {
            postImageView.image = UIImage(data: imageData)
            imageViewHeightConstraint.constant = Sizes.postImageHeight
        } else {
            imageViewHeightConstraint.constant = Sizes.zero
        }
    }
}

private extension PostTableViewCell {
    enum Sizes {
        static let zero: CGFloat = 0
        static let postImageHeight: CGFloat = 300
    }
}
