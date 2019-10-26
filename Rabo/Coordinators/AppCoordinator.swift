//
//  AppCoordinator.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

/// Main App Coordinator
class AppCoordinator<T: Dependency>: Coordinator<T>, RootViewProvider {

    lazy var rootViewController: UIViewController = {
        return navigationViewController
    }()

    private let window = UIWindow(frame: UIScreen.main.bounds)
    private(set) lazy var navigationViewController = UINavigationController()

    override func start() {
        let homeCoordinator = HomeCoordinator(
            dependency: dependency,
            navigation: navigationViewController
        )
        add(childCoordinator: homeCoordinator)
        homeCoordinator.start()

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
