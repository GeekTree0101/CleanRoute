//
//  AppDelegate.swift
//  CleanRoute
//
//  Created by Hyeon su Ha on 20/09/2019.
//  Copyright © 2019 Geektree0101. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    window = UIWindow(frame: UIScreen.main.bounds)
    if let window = window {
      let vc = ShowViewController.init()
      vc.router?.dataStore?.content = "Hello world"
      window.rootViewController = UINavigationController.init(rootViewController: vc)
      window.makeKeyAndVisible()
    }
    
    return true
  }

}

