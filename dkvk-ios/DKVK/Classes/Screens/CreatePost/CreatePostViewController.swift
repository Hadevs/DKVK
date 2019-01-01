//
//  CreatePostViewController.swift
//  DKVK
//
//  Created by Hadevs on 30/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

final class CreatePostViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        addTargets()
        addDelegations()

        textView.updatePlaceholder()
    }
}

private extension CreatePostViewController {

    func addTargets() {
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }

    func addDelegations() {
        textView.delegate = self
    }

    @objc func doneButtonClicked() {
        guard let text = textView.text, !text.isEmpty else {
            showAlert(with: "Error", and: "Text is empty")
            return
        }

        guard let user = AuthManager.shared.currentUser else {
            showAlert(with: "Error", and: "User not logged in")
            return
        }

        PostManager.shared.createPost(from: user, with: text) { (result) in
            switch result {
            case .error(let textError):
                self.showAlert(with: "Error", and: textError)
            case .success:
                self.showAlert(with: "Success", and: "Post has been created")
            }
        }
    }
}

extension CreatePostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.updatePlaceholder()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        textView.updatePlaceholder()
    }
}
