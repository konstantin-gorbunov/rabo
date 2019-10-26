//
//  DetailsCoordinator.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

protocol DetailsDelegate: class {
    func onDetailsFlowFinished<T>(_ coordinator: Coordinator<T>)
}

/// Customer Details Coordinator
class DetailsCoordinator<T: Dependency>: Coordinator<T> {

    private let navigationController: UINavigationController
    private let customer: Customer

    weak var delegate: DetailsDelegate?

    private(set) lazy var detailViewController = DetailsViewController(nibName: nil, bundle: nil)

    init(dependency: T, navigation: UINavigationController, customer: Customer) {
        self.navigationController = navigation
        self.customer = customer
        super.init(dependency: dependency)
    }

    override func start() {
        super.start()
        detailViewController.delegate = self
        detailViewController.viewModel = DetailsViewModel(
            customer: customer
        )
        navigationController.pushViewController(detailViewController, animated: true)
    }

    override func stop() {
        delegate?.onDetailsFlowFinished(self)
        super.stop()
    }
}

extension DetailsCoordinator: DetailsViewDelegate {

    func onDetailsViewFinished(_ viewController: UIViewController) {
        stop()
    }
}
