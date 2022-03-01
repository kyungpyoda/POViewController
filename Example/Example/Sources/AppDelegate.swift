//
//  AppDelegate.swift
//  Example
//
//  Created by 홍경표 on 2022/02/06.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let mainVC = MainViewController()
        let navi = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navi
        
        return true
    }
    
}
