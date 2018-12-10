//
//  CellHeaderProtocol.swift
//  DKVK
//
//  Created by Hadevs on 10/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import Foundation

protocol CellHeaderProtocol {
	associatedtype CellType
	
	var cellModels: [CellType] { get }
}
