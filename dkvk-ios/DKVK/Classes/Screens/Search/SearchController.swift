//
//  SearchController.swift
//
//  Created by Danil Detkin on 18/08/2018.
//  Copyright © 2018 App's ID. All rights reserved.
//

import UIKit

// inherit models from this porotocol, wich can be searched
protocol Searchable {
	var parameter: String { get }
}

class SearchController<T: Searchable> {
	private(set) var items: [T]
	private var caseSensitive: Bool
	
	init(_ items: [T], caseSensitive: Bool = false) {
		self.items = items
		self.caseSensitive = caseSensitive
	}
	
	func search(by text: String?) -> [T] {
		guard !(text?.isEmpty ?? true) else {
			return items
		}
		return self.items.filter({ (item) -> Bool in
			if caseSensitive {
				return item.parameter.contains(text ?? "")
			} else {
				return item.parameter.lowercased().contains((text ?? "").lowercased())
			}
		})
	}
}

