//
//  AppDelegate.swift
//  K.A.D.Devinda_cobsccomp191p-044
//
//  Created by dasun on 9/14/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        window = UIWindow()
        window?.makeKeyAndVisible()
       // window?.rootViewController = HomeViewController()
        window?.rootViewController = MainTabBarController()
        return true
    }

}
