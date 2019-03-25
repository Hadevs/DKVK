//
//  ViewController.swift
//  DKVK
//
//  Created by Hadevs on 02/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var logoView: UIImageView!
	
	private var controller: StartController?
	
	convenience init(controller: StartController) {
		self.init()
		self.controller = controller
	}
	
  override func viewDidLoad() {
    super.viewDidLoad()
		controller?.viewDidLoad()
    Decorator.decorate(self)
		addSegmentedControl()сти
  }
	
	private func addSegmentedControl() {
		let item = DKSegmentedControl.Item(title: "Мужской", image: UIImage(named: "mars")!)
		let item1 = DKSegmentedControl.Item(title: "Женский", image: UIImage(named: "female")!)
		let segmentedControl = DKSegmentedControl(items: [item, item1])
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(segmentedControl)
		
		let constraints = NSLayoutConstraint.contraints(withNewVisualFormat: "V:|-150-[v(55)],H:|[v]", dict: ["v": segmentedControl])
		self.view.addConstraints(constraints)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
}

extension ViewController {
  fileprivate class Decorator {
    static let buttonCornerRadius: CGFloat = 4
    private init() {}
    
    static func decorate(_ vc: ViewController) {
      vc.signUpButton.layer.cornerRadius = buttonCornerRadius
      vc.signUpButton.layer.borderColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
    }
  }
}
