//
//  AppDelegate.swift
//  News
//
//  Created by Phạm Thanh Hải on 2/5/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        // HOME
        let homeVC = HomeViewController()
        let homeNavi = BaseNavigationController(rootViewController: homeVC)
        homeNavi.tabBarItem = UITabBarItem(title: "Trang chủ", image: UIImage(named: "house"), tag: 0)
        
        // VIDEO
        let videoVC = VideoViewController()
        let videoNavi = BaseNavigationController(rootViewController: videoVC)
        videoNavi.tabBarItem = UITabBarItem(title: "Video", image: UIImage(named: "play"), tag: 1)
        
        // tabbar controller
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [homeNavi, videoNavi]
        
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        
        return true
    }
}


