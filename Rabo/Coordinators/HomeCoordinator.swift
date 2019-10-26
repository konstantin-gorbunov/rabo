//
//  HomeCoordinator.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit
    
/// Home (Customer List) Coordinator
class HomeCoordinator<T: Dependency>: Coordinator<T> {
    
    let navigationViewController: UINavigationController
    private let title = NSLocalizedString("Customers", comment: "Customers")
    
    init(dependency: T, navigation: UINavigationController) {
        self.navigationViewController = navigation
        super.init(dependency: dependency)
    }

    override func start() {
        super.start()

        let loadingViewController = LoadingViewController(nibName: nil, bundle: nil)
        navigationViewController.viewControllers = [loadingViewController]
        loadingViewController.title = title

        dependency.dataProvider.fetchCustomerList { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.processResults(result)
            }
        }
    }

    fileprivate func processResults(_ result: DataProvider.FetchCustomerResult) {
        guard case .success(let customers) = result, customers.isEmpty == false else {
            let errorViewController = ErrorViewController(nibName: nil, bundle: nil)
            errorViewController.title = title
            navigationViewController.viewControllers = [errorViewController]
            return
        }

        let customerViewController = CustomerCollectionViewController(
            viewModel: CustomerListViewModel(customers: customers),
            layout: UICollectionViewFlowLayout()
        )
        customerViewController.title = title
        customerViewController.delegate = self
        navigationViewController.viewControllers = [customerViewController]
    }
}

extension HomeCoordinator: CustomersCollectionViewDelegate {

    func didSelectCustomer(_ customer: Customer) {
        let detailsCoordinator = DetailsCoordinator(
            dependency: dependency,
            navigation: navigationViewController,
            customer: customer
        )
        add(childCoordinator: detailsCoordinator)
        detailsCoordinator.start()
    }
}
