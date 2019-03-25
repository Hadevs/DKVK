//
//  RegisterViewController.swift
//  DKVK
//
//  Created by Hadevs on 02/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!

	let datePickerView: UIDatePicker = {
		let picker = UIDatePicker()
		picker.maximumDate = Date()
		return picker
	}()
	
	private var controller: RegisterController?
	
	convenience init(controller: RegisterController) {
		self.init()
		self.controller = controller
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Регистрация"
		
		Decorator.decorate(vc: self)
		registerCells()
		configureDatePickerView()
		addRightBarButton()
		addHeaderView()
	}
	
	private func addHeaderView() {
		let headerView = TitleHeaderView.loadFromNib()
		headerView.set(text: "New Account")
		let height: CGFloat = 100
		let width = view.frame.size.width
		headerView.frame.size = CGSize(width: width, height: height)
		tableView.tableHeaderView = headerView
	}
	
	private func addRightBarButton() {
		let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightBarButtonClicked(sender:)))
		navigationItem.rightBarButtonItem = barButton
	}
	
	@objc private func rightBarButtonClicked(sender: UIBarButtonItem) {
		controller?.rightBarButtonClicked()
	}
	
	private func configureDatePickerView() {
		datePickerView.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
	}
	
	@objc private func datePickerChanged(sender: UIDatePicker) {
		let date = sender.date
		controller?.datePickerChanged(with: date)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	private func photoViewClicked() {
		let imagePickerController = UIImagePickerController()
		imagePickerController.delegate = self
		imagePickerController.sourceType = .photoLibrary
		present(imagePickerController, animated: true, completion: nil)
	}
	
	private func registerCells() {
		tableView.register(SegmenterTableViewCell.nib, forCellReuseIdentifier: SegmenterTableViewCell.name)
		tableView.register(TextFieldTableViewCell.nib, forCellReuseIdentifier: TextFieldTableViewCell.name)
	}
}

extension RegisterViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		picker.dismiss(animated: true, completion: nil)
		guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
			return
		}
		
		controller?.imagePickerClosed(with: image)
	}
}

extension RegisterViewController {
	private static let tableViewTopInset: CGFloat = 16
	fileprivate class Decorator {
		static func decorate(vc: RegisterViewController) {
			vc.tableView.separatorColor = .clear
			vc.tableView.keyboardDismissMode = .onDrag
			vc.tableView.backgroundColor = .white
			vc.navigationController?.navigationBar.makeClear()
			vc.navigationController?.navigationBar.prefersLargeTitles = true
			vc.tableView.contentInset = UIEdgeInsets(top: tableViewTopInset, left: 0, bottom: 0, right: 0)
		}
	}
}
