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
    static func mockCustomer(firstName: String = "Theo", surName: String = "Jansen", issueCount: Int64 = 5, birthDate: String = "1978-01-02T00:00:00") -> Customer? {
        let data = """
        "First name","Sur name","Issue count","Date of birth"
        "\(firstName)","\(surName)",\(issueCount),"\(birthDate)"
        """
        let decoder = CSVDecoder()
        do {
            let realCustomer = try decoder.decode(Customer.self, from: data)
            return realCustomer
        }
        catch {
            return nil
        }
    }
    
    static func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }
}
