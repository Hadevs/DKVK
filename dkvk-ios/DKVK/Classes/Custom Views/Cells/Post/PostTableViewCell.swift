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
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code

        textView.sizeToFit()
        textView.isScrollEnabled = false
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
