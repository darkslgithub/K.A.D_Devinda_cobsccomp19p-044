//
//  MainTabBarController.swift
//  K.A.D.Devinda_cobsccomp191p-044
//
//  Created by dasun on 9/4/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //tabBar.barTintColor = UIColor(red: 38/255, green: 196/255, blue: 133/255, alpha:1)
        tabBar.barTintColor = .maintabcolor
        tabBar.tintColor = .green
        tabBar.unselectedItemTintColor = .black
        setupTabBar()
    }
    
    func setupTabBar(){
        let homeController = UINavigationController(rootViewController: HomeViewController())
       // homeController.tabBarItem.image = UIImage(systemName: "house")
        homeController.tabBarItem.image = UIImage(named:"home")
        homeController.tabBarItem.title = "Home"
        
        let plusController = UINavigationController(rootViewController: UpdateViewController())
        plusController.tabBarItem.image = UIImage(systemName: "plus")
        plusController.tabBarItem.title = "plus"
        
        let settinngController = UINavigationController(rootViewController: SettingsViewController())
        settinngController.tabBarItem.image = UIImage(systemName: "gear")
        settinngController.tabBarItem.title = "setting"

        viewControllers = [homeController, plusController, settinngController]
    }
    

    
}
