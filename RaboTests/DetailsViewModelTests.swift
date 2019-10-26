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
        guard let customer = Customer.mockCustomer(firstName: "Fiona", surName: "de Vries", issueCount: 7, birthDate: "1950-11-12T00:00:00") else {
            XCTFail("Can't create mock customer")
            return
        }
        let model = DetailsViewModel(customer: customer)
        XCTAssertEqual(model.name, "Fiona de Vries")
        XCTAssertEqual(model.text, "Issue count: 7")
        XCTAssertEqual(model.birthDate, "12 nov. 1950")
    }

    func testEmptySurName() {
        guard let customer = Customer.mockCustomer(firstName: "Fiona", surName: "", issueCount: 7, birthDate: "1950-11-12T00:00:00") else {
            XCTFail("Can't create mock customer")
            return
        }
        let model = DetailsViewModel(customer: customer)
        XCTAssertEqual(model.name, "Fiona")
        XCTAssertEqual(model.text, "Issue count: 7")
        XCTAssertEqual(model.birthDate, "12 nov. 1950")
    }
    
    func testNoIssues() {
        guard let customer = Customer.mockCustomer(firstName: "Fiona", surName: "de Vries", issueCount: 0, birthDate: "1950-11-12T00:00:00") else {
            XCTFail("Can't create mock customer")
            return
        }
        let model = DetailsViewModel(customer: customer)
        XCTAssertEqual(model.name, "Fiona de Vries")
        XCTAssertEqual(model.text, "No Issues")
        XCTAssertEqual(model.birthDate, "12 nov. 1950")
    }
    
    func testWrongDate() {
        guard let customer = Customer.mockCustomer(firstName: "Fiona", surName: "de Vries", issueCount: 0, birthDate: "1950-13-12T00:00:00") else {
            XCTFail("Can't create mock customer")
            return
        }
        let model = DetailsViewModel(customer: customer)
        XCTAssertEqual(model.name, "Fiona de Vries")
        XCTAssertEqual(model.text, "No Issues")
        XCTAssertEqual(model.birthDate, "No Birthday Date")
    }
}
