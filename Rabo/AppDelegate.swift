//
//  AppDelegate.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 22/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var dependency = AppDependency()
    lazy var appCoordinator = AppCoordinator(dependency: dependency)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator.start()
        return true
    }
}
