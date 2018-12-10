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
	
	private let models: [HeaderModel] = [.info, .sex, .birthday]
	
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
	
	fileprivate enum HeaderModel: CellHeaderProtocol {
		typealias CellType = CellModel
		case sex
		case info
		case birthday
		
		var cellModels: [RegisterViewController.CellModel] {
			switch self {
			case .sex: return [.sex]
			case .info: return [.userInfo]
			case .birthday: return [.birthday]
			}
		}
	}
}

extension RegisterViewController {
	private static let tableViewTopInset: CGFloat = 16
	fileprivate class Decorator {
		static func decorate(vc: RegisterViewController) {
			vc.tableView.separatorColor = .clear
			vc.tableView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
			vc.navigationController?.navigationBar.prefersLargeTitles = true
			vc.tableView.contentInset = UIEdgeInsets(top: tableViewTopInset, left: 0, bottom: 0, right: 0)
		}
	}
}

extension RegisterViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let model = models[indexPath.section].cellModels[indexPath.row]
		switch model {
		case .userInfo:
			return 100
		default:
			return 0
		}
	}
}

extension RegisterViewController: UITableViewDataSource {
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
		case .sex:
			return 44
		default:
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = models[indexPath.section].cellModels[indexPath.row]
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
		return models[section].cellModels.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
}
