//
//  DependencyProviderTests.swift
//  DKVKTests
//
//  Created by Hadevs on 24/03/2019.
//  Copyright © 2019 Hadevs. All rights reserved.
//

import XCTest
@testable import DKVK

class DependencyProviderTests: XCTestCase {
	func testRouterFetching() {
		let dependencyProvider = DependencyProvider()
		let firstFetchedRouter = dependencyProvider.fetchMainRouter()
		let secondFetchedRouter = dependencyProvider.fetchMainRouter()
		XCTAssertNotEqual(firstFetchedRouter, secondFetchedRouter)
	}
}
