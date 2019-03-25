//
//  RegisterController.swift
//  DKVK
//
//  Created by Hadevs on 24/03/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import UIKit
import ARSLineProgress

class RegisterController: NSObject, Lifecycable {
	
	weak var authManager: AuthManager?
	
	init(authManager: AuthManager) {
		self.authManager = authManager
	}
	
	weak var viewController: RegisterViewController?
	
	func set(viewController: RegisterViewController) {
		self.viewController = viewController
	}
	
	private let models: [HeaderModel] = [.info, .sex, .birthday]
	private let sexModels: [Sex] = [.male, .female]
	private var registerModel = RegisterModel()
	
	private func updateDoneButtonStatus() {
		viewController?.navigationItem.rightBarButtonItem?.isEnabled = registerModel.isFilled
	}
	
	var tableView: UITableView? {
		return viewController?.tableView
	}
	
	func viewDidLoad() {
		updateDoneButtonStatus()
		delegating()
	}
	
	private func delegating() {
		viewController?.tableView.delegate = self
		viewController?.tableView.dataSource = self
	}
	
	func imagePickerClosed(with image: UIImage) {
		registerModel.photo = image
		updateDoneButtonStatus()
		tableView?.reloadData()
		ARSLineProgress.show()
		StorageManager.shared.upload(photo: image, by: registerModel) {
			ARSLineProgress.hide()
		}
	}
	
	func datePickerChanged(with date: Date) {
		registerModel.birthday = date
		updateDoneButtonStatus()
	}
	
	func rightBarButtonClicked() {
		ARSLineProgress.show()
		authManager?.register(with: registerModel) { result in
			ARSLineProgress.hide()
			switch result {
			case .success(_):
				//                StartRouter.shared.routeAfterSuccessAuth(from: self)
				SecureStorageManager.shared.save(email: self.registerModel.email, password: self.registerModel.password) { (error) in
					if let error = error {
						print(String(describing: error.errorDescription))
					}
				}
			case .failure(let error):
				self.viewController?.showAlert(with: "Ошибка", and: error.localizedDescription)
			}
		}
	}
}


extension RegisterController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let model = models[indexPath.section].cellModels[indexPath.row]
		switch model {
		case .userInfo:
			return 100
		case .sex, .birthday:
			return 44
		}
	}
}

extension RegisterController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerModel = models[section]
		switch headerModel {
		case .sex:
			let view = HeaderTitleView.loadFromNib()
			view.set(title: "Ваш пол:")
			return view
		default: return nil
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		let headerModel = models[section]
		switch headerModel {
		case .sex, .birthday:
			return 44
		default: return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = models[indexPath.section].cellModels[indexPath.row]
		switch model {
		case .userInfo:
			return UITableViewCell()
		case .sex:
			if let cell = tableView.dequeueReusableCell(withIdentifier: SegmenterTableViewCell.name, for: indexPath) as? SegmenterTableViewCell {
				cell.set(titles: sexModels.map{ $0.rawValue.capitalized } )
				cell.indexChanged = {
					index in
					
					let sex = self.sexModels[index]
					self.registerModel.sex = sex
					self.updateDoneButtonStatus()
				}
				return cell
			}
		case .birthday:
			if let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.name, for: indexPath) as? TextFieldTableViewCell {
				cell.textField.inputView = viewController?.datePickerView
				return cell
			}
		}
		
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models[section].cellModels.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return models.count
	}
}


extension RegisterController {
	fileprivate enum CellModel {
		case userInfo
		case sex
		case birthday
	}
	
	fileprivate enum HeaderModel: CellHeaderProtocol {
		typealias CellType = CellModel
		case sex
		case info
		case birthday
		
		var cellModels: [RegisterController.CellModel] {
			switch self {
			case .sex: return [.sex]
			case .info: return [.userInfo]
			case .birthday: return [.birthday]
			}
		}
	}
}
