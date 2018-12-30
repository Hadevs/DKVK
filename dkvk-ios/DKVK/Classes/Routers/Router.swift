//
//  Router.swift
//  DKVK
//
//  Created by Hadevs on 02/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

final class Router {
  static let shared = Router()
  
  private init() {}
  
  func root(_ window: inout UIWindow?) {
    let frame = UIScreen.main.bounds
    window = UIWindow(frame: frame)
    window?.makeKeyAndVisible()
		
		let vc = SecureStorageManager.shared.isLoggedIn() ? startControllerAfterAuth : ViewController()
		
    window?.rootViewController = UINavigationController(rootViewController: vc)
  }
	
	var startControllerAfterAuth: UIViewController {
		let createPostVC = CreatePostViewController()
		let createPostNC = UINavigationController(rootViewController: createPostVC)
		let createPostTabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
		createPostNC.tabBarItem = createPostTabBarItem
		
		let feedVC = FeedViewController()
		let feedNC = UINavigationController(rootViewController: feedVC)
		let feedTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		feedNC.tabBarItem = feedTabBarItem
		
		let tabBarVC = UITabBarController()
		tabBarVC.setViewControllers([feedNC, createPostNC], animated: true)
		return tabBarVC
	}
}
