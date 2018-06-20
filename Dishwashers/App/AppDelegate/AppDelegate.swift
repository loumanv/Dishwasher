//
//  AppDelegate.swift
//  Dishwashers
//
//  Created by Vasileios Loumanis on 18/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = AppNavigationController(rootViewController: DishwashersViewController())
        self.window?.makeKeyAndVisible()

        return true
    }
}
