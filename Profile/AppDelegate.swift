//
//  AppDelegate.swift
//  Profile
//
//  Created by Ielena R. on 1/25/21.
//

import UIKit

@main
class AppDelegate: UIResponder,
                   UIApplicationDelegate {
    var window: UIWindow?
    var profileCoordinator: ProfileCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()

        let rootNavigationController = UINavigationController()
        profileCoordinator = ProfileCoordinator(navigationController: rootNavigationController)
        profileCoordinator?.start()

        window?.rootViewController = rootNavigationController

        return true
    }
}
