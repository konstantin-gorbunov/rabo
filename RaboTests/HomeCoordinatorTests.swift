//
//  HomeCoordinatorTests.swift
//  RaboTests
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import XCTest
@testable import Rabo

class HomeCoordinatorTests: XCTestCase {

    var dependency: MockDependency?
    var coordinator: HomeCoordinator<MockDependency>?

    override func setUp() {
        super.setUp()
        
        let navigation = UINavigationController(rootViewController: UIViewController())
        let localDependency = MockDependency()
        dependency = localDependency
        coordinator = HomeCoordinator(
            dependency: localDependency,
            navigation: navigation
        )
    }

    override func tearDown() {
        coordinator = nil
        dependency = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(dependency)
        XCTAssertNotNil(coordinator)
    }

    func testLoadingScreen() {
        let expectation = self.expectation(description: "Data Fetched")
        let customer = Customer.mockCustomer()
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.success([customer]))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        coordinator?.start()
        let firstVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(firstVisible is LoadingViewController)
        wait(for: [expectation], timeout: 2)
        let secondVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(secondVisible is CustomerCollectionViewController)
    }

    func testErrorScreen() {
        let expectation = self.expectation(description: "Data Fetched")
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.success([]))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        coordinator?.start()
        let firstVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(firstVisible is LoadingViewController)
        wait(for: [expectation], timeout: 2)
        let secondVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(secondVisible is ErrorViewController)
    }

    func testShowDetails() {
        let expectation = self.expectation(description: "Data Fetched")
        let customer = Customer.mockCustomer()
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.success([customer]))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        coordinator?.start()
        wait(for: [expectation], timeout: 5)
        guard let collectionController = coordinator?.navigationViewController.visibleViewController as? UICollectionViewController else {
            XCTFail()
            return
        }
        collectionController.collectionView(collectionController.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(coordinator?.childCoordinators.first(where: { $0 is DetailsCoordinator }))
    }
}
