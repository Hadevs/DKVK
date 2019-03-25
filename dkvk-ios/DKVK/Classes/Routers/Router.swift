//
//  Router.swift
//  DKVK
//
//  Created by Hadevs on 02/12/2018.
//  Copyright © 2018 Hadevs. All rights reserved.
//

import UIKit

final class Router {
	private var usersViewController: UsersViewController?
	
	func set(usersViewController: UsersViewController) {
		self.usersViewController = usersViewController
	}
	
	func root(_ window: inout UIWindow?, rootViewController: UIViewController) {
    let frame = UIScreen.main.bounds
    window = UIWindow(frame: frame)
    window?.makeKeyAndVisible()
		
		let vc = SecureStorageManager.shared.isLoggedIn() ? startControllerAfterAuth : rootViewController
		
    window?.rootViewController = UINavigationController(rootViewController: vc)
  }
	
	var startControllerAfterAuth: UIViewController {
		let createPostVC = CreatePostViewController()
		let createPostNC = UINavigationController(rootViewController: createPostVC)
		let createPostTabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
		createPostNC.tabBarItem = createPostTabBarItem
		
		let chatsVC = ChatsViewController()
		let chatsNC = UINavigationController.init(rootViewController: chatsVC)
		let chatsTabbarItem = UITabBarItem(tabBarSystemItem: .history, tag: 3)
		chatsNC.tabBarItem = chatsTabbarItem
		
		let feedVC = FeedViewController()
		let feedNC = UINavigationController(rootViewController: feedVC)
		let feedTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		feedNC.tabBarItem = feedTabBarItem
        
		let searchVC = SearchUserViewController()
		let searchNC = UINavigationController(rootViewController: searchVC)
		let searchTabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
		searchNC.tabBarItem = searchTabBarItem
		
		let tabBarVC = UITabBarController()
		
		var tabBarViewControllers = [feedNC, searchNC, chatsNC, createPostNC]
		
		if let usersViewController = self.usersViewController {
			let usersVC = usersViewController
			let usersNC = UINavigationController.init(rootViewController: usersVC)
			let usersTabbarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 4)
			usersNC.tabBarItem = usersTabbarItem
			tabBarViewControllers.insert(usersNC, at: 2)
		}
		
		tabBarVC.setViewControllers(tabBarViewControllers, animated: true)
		return tabBarVC
	}
}
