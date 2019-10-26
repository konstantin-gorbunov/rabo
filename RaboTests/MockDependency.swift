//
//  MockDependency.swift
//  RaboTests
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import CoreData
@testable import Rabo

class MockDataProvider: DataProvider {

    var onFetch: ((DataProvider.FetchCustomerCompletion) -> Void)?

    func fetchCustomerList(_ completion: @escaping DataProvider.FetchCustomerCompletion) {
        onFetch?(completion)
    }
}

class MockDependency: Dependency {
    
    let dataProvider: DataProvider = MockDataProvider()
}

extension Customer {
    static func mockCustomer(firstName: String = "firstName", surName: String = "surName", issueCount: Int64 = 0, birthData: String = "1970-01-01T00:00:00") -> Customer {
        return Customer(
            firstName: firstName,
            surName: surName,
            issueCount: issueCount,
            birthData: birthData
        )
    }
}
