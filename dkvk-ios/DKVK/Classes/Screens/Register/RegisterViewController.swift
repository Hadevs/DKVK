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
	
	private var models: [CellModel] = [.userInfo]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Регистрация"
		
		Decorator.decorate(vc: self)
		registerCells()
		delegating()
	}
	
	private func delegating() {
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	private func registerCells() {
		tableView.register(InfoUserTableViewCell.nib, forCellReuseIdentifier: InfoUserTableViewCell.name)
	}
}

extension RegisterViewController {
	fileprivate enum CellModel {
		case userInfo
		case sex
		case birthday
	}
}

extension RegisterViewController {
	fileprivate class Decorator {
		static func decorate(vc: RegisterViewController) {
			vc.navigationController?.navigationBar.prefersLargeTitles = true
		}
	}
}

extension RegisterViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let model = models[indexPath.row]
		switch model {
		case .userInfo:
			return 100
		default:
			return 0
		}
	}
}

extension RegisterViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = models[indexPath.row]
		switch model {
		case .userInfo:
			if let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserTableViewCell.name, for: indexPath) as? InfoUserTableViewCell {
				return cell
			}
		default: break
		}
		
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models.count
	}
}
