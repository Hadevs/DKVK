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
  
  private let rootViewController: UIViewController = ViewController()
  
  func root(_ window: inout UIWindow?) {
    let frame = UIScreen.main.bounds
    window = UIWindow(frame: frame)
    window?.makeKeyAndVisible()
    
    window?.rootViewController = UINavigationController(rootViewController: rootViewController)
  }
}
