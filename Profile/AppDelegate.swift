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

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()

        window?.rootViewController = ProfileViewController(viewModel: ProfileViewModel(model: ProfileModel()))

        return true
    }
}
