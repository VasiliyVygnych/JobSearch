//
//  AppDelegate.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 08.11.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        let coordinator = MainCoordinator(navigationController: navController)
        coordinator.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}
