//
//  CreatePostViewController.swift
//  DKVK
//
//  Created by Hadevs on 30/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

final class CreatePostViewController: UIViewController {

    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var crossImageView: UIImageView!

    private let tapToAddPostImage = #imageLiteral(resourceName: "tap_button")

    override func viewDidLoad() {
        super.viewDidLoad()

        Decorator.decorate(vc: self)

        addTargets()
        addGestures()

        updatePostImageView(image: tapToAddPostImage)
    }
}

private extension CreatePostViewController {

    func addTargets() {
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }

    func addGestures() {
        let postImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(postImageClicked))
        postImageView.addGestureRecognizer(postImageTapGesture)

        let crossTapGesture = UITapGestureRecognizer(target: self, action: #selector(crossImageClicked))
        crossImageView.addGestureRecognizer(crossTapGesture)
    }

    @objc func postImageClicked() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    @objc func crossImageClicked() {
        updatePostImageView(image: tapToAddPostImage)
    }

    @objc func doneButtonClicked() {

        guard let user = AuthManager.shared.currentUser else {
            showAlert(with: "Error", and: "User not logged in")
            return
        }

        let postImage = postImageView.image != #imageLiteral(resourceName: "tap_button.png") ? postImageView.image : nil

        PostManager.shared.createPost(from: user, with: textView.text, image: postImage) { (result) in
            switch result {
            case .error(let textError):
                self.showAlert(with: "Error", and: textError)
            case .success:
                self.showAlert(with: "Success", and: "Post has been created")
            }
        }
    }

    func updatePostImageView(image: UIImage) {
        postImageView.image = image
        crossImageView.isHidden = image == tapToAddPostImage
    }
}

private extension CreatePostViewController {
    final class Decorator {
        static func decorate(vc: CreatePostViewController) {
            vc.postImageView.isUserInteractionEnabled = true
            vc.crossImageView.isUserInteractionEnabled = true
            vc.textView.placeholder = "Add post message..."
        }
    }
}

extension CreatePostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        updatePostImageView(image: image)
    }
}
