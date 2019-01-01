//
//  Extensions+UITextView.swift
//  DKVK
//
//  Created by Антон Савинов on 01/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit

extension UITextView {
    func updatePlaceholder() {
        if text.isEmpty {
           text = "Placeholder"
           textColor = .lightGray
        } else if textColor == .lightGray {
            text = nil
            textColor = .black
        }
    }
}
