//
//  Lifecycable.swift
//  DKVK
//
//  Created by Hadevs on 13/01/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import Foundation

protocol Lifecycable {
	func viewDidAppear()
	func viewDidLoad()
	func viewWillAppear()
}
