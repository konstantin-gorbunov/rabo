//
//  DetailsViewModelTests.swift
//  RaboTests
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import XCTest
@testable import Rabo

class DetailsViewModelTests: XCTestCase {

    func testBaseMapping() {
        let customer = Customer(
            firstName: "Fiona",
            surName: "de Vries",
            issueCount: 7,
            birthData: "1950-11-12T00:00:00"
        )
        let model = DetailsViewModel(customer: customer)
        XCTAssertEqual(model.name, "Fiona de Vries")
        XCTAssertEqual(model.text, "Issue count: 7")
        XCTAssertEqual(model.birthData, "1950-11-12T00:00:00")
    }

    func testEmptySurName() {
        let customer = Customer(
            firstName: "Fiona",
            surName: "",
            issueCount: 7,
            birthData: "1950-11-12T00:00:00"
        )
        let model = DetailsViewModel(customer: customer)
        XCTAssertEqual(model.name, "Fiona")
        XCTAssertEqual(model.text, "Issue count: 7")
        XCTAssertEqual(model.birthData, "1950-11-12T00:00:00")
    }
    
    func testNoIssues() {
        let customer = Customer(
            firstName: "Fiona",
            surName: "de Vries",
            issueCount: 0,
            birthData: "1950-11-12T00:00:00"
        )
        let model = DetailsViewModel(customer: customer)
        XCTAssertEqual(model.name, "Fiona de Vries")
        XCTAssertEqual(model.text, "No Issues")
        XCTAssertEqual(model.birthData, "1950-11-12T00:00:00")
    }
}
