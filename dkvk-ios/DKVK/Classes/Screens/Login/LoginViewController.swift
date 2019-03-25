//
//  LoginViewController.swift
//  DKVK
//
//  Created by Hadevs on 23/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	private let models: [CellModel] = [.email, .password]
	private var loginModel: LoginModel = LoginModel()
	override func viewDidLoad() {
		super.viewDidLoad()
		addRightButton()
//		addTargets()
		
		addHeaderView()
		addFooterView()
		Decorator.decorate(self)
		registerCells()
		delegating()
	}
	
	private func delegating() {
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	private func registerCells() {
		tableView.register(DetailFieldTableViewCell.nib, forCellReuseIdentifier: DetailFieldTableViewCell.name)
	}
	
	private func addHeaderView() {
		let headerView = TitleHeaderView.loadFromNib()
		let height: CGFloat = 100
		let width = view.frame.size.width
		headerView.frame.size = CGSize(width: width, height: height)
		tableView.tableHeaderView = headerView
	}
	
	private func addFooterView() {
		let footerView = TextFooterView.loadFromNib()
		footerView.frame.size.width = view.frame.width
		footerView.set(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut pretium pretium tempor. Ut eget")
		tableView.tableFooterView = footerView
	}
	
	private func addRightButton() {
		let button = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(rightButtonClicked))
		navigationItem.rightBarButtonItem = button
	}
	
	@objc private func rightButtonClicked() {
		let email = loginModel.email ?? ""
		let password = loginModel.password ?? ""

		guard !email.isEmpty && !password.isEmpty else {
			showAlert(with: "Ошибка", and: "Заполните все поля")
			return
		}

		self.performLogin(email: email, password: password)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	func textChanged(with model: CellModel, and text: String) {
		switch model {
		case .email: loginModel.email = text
		case .password: loginModel.password = text
		}
	}
}

extension LoginViewController {
	enum CellModel {
		case email
		case password
		
		var placeholder: String? {
			switch self {
			case .email: return "Your email"
			case .password: return "Your password"
			}
		}
		
		
		var title: String? {
			switch self {
			case .email: return "Email"
			case .password: return "Password"
			}
		}
	}
}

extension LoginViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return DetailFieldTableViewCell.height
	}
}

extension LoginViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DetailFieldTableViewCell.name, for: indexPath) as! DetailFieldTableViewCell
		let model = models[indexPath.row]
		cell.adjustWidth(by: models.map{$0.title ?? ""})
		cell.set(placeholder: model.placeholder)
		cell.set(title: model.title)
		let insets = UIEdgeInsets.init(top: 0, left: 30, bottom: 0, right: 30)
		switch model {
		case .email:
			cell.addSeparator(on: .top, insets: insets)
			cell.set(secure: false)
			cell.activeTextField()
		case .password:
			cell.addSeparator(on: .bottom, insets: insets)
			cell.set(secure: true)
		}
		
		cell.textChanged = {
			text in
			self.textChanged(with: model, and: text)
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models.count
	}
}

private extension LoginViewController {
	final class Decorator {
		static func decorate(_ vc: LoginViewController) {
			vc.navigationController?.navigationBar.makeClear()
			
//			let biometricType = BiometricAuthManager.shared.biometricType()
//			switch biometricType {
//			case .touchID:
//				vc.authButton.setImage(#imageLiteral(resourceName: "touch_id"), for: .normal)
//			case .faceID:
//				vc.authButton.setImage(#imageLiteral(resourceName: "face_id"), for: .normal)
//			case .none:
//				vc.authButton.setImage(#imageLiteral(resourceName: "touch_id"), for: .normal)
//				vc.authButton.isEnabled = false
//			}
		}
	}
}

private extension LoginViewController {
//	func addTargets() {
////		authButton.addTarget(self, action: #selector(authButtonClicked), for: .touchUpInside)
//	}
	
	func performLogin(email: String?, password: String?) {
		AuthManager.shared.signIn(with: email, and: password) { (result) in
			switch result {
			case .success: break
//				StartRouter.shared.routeAfterSuccessAuth(from: self)
			case .error(let error):
				self.showAlert(with: "Ошибка", and: error)
			}
		}
	}
	
	@objc func authButtonClicked() {
		BiometricAuthManager.shared.authenticateUser { (error) in
			if let error = error {
				self.showAlert(with: "Ошибка", and: error.errorDescription ?? "Unexpected result")
				return
			}
			let userInfo = SecureStorageManager.shared.loadEmailAndPassword()
			self.performLogin(email: userInfo.email, password: userInfo.password)
		}
	}
}
