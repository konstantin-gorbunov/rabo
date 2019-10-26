//
//  CSVDecoderTests.swift
//  CSVDecoderTests
//
//  Created by Red Davis on 15/02/2019.
//  Copyright © 2019 Red Davis. All rights reserved.
//

import XCTest
@testable import Rabo

class CSVDecoderTests: XCTestCase {
    
    func testDecoding() {
        let data = """
        name,age,city,postcode,birthplace
        _why,45,Bath,BA15NF,
        """
        let decoder = CSVDecoder()
        do {
            let customer = try decoder.decode(FakeCustomer.self, from: data)
            XCTAssertEqual(customer.name, "_why")
            XCTAssertEqual(customer.age, 45)
            XCTAssertEqual(customer.city, "Bath")
            XCTAssertEqual(customer.postcode, "BA15NF")
            XCTAssertNil(customer.birthplace)
        }
        catch {
            print(error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDecodingArray() {
        let data = """
        name,age,city,postcode,birthplace
        _why,45,Bath,,London
        Red,15,Bath,BA15NF,London
        """
        let decoder = CSVDecoder()
        do {
            let customers = try decoder.decode([FakeCustomer].self, from: data)
            XCTAssertEqual(customers.count, 2)
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testKeyNotExisting() {
        let data = """
        error,age,city,postcode,birthplace
        _why,45,Bath,BA15NF,London
        """
        let decoder = CSVDecoder()
        do {
            _ = try decoder.decode(FakeCustomer.self, from: data)
            XCTFail()
        }
        catch let error as DecodingError {
            switch error {
            case .keyNotFound(let key, _):
                XCTAssertEqual(key.stringValue, "name")
            default:
                XCTFail("Incorrect error \(error)")
            }
        }
        catch {
            XCTFail("Incorrect error \(error)")
        }
    }
    
    func testRealCustomerDecoding() {
        let data = """
        "First name","Sur name","Issue count","Date of birth"
        "Theo","Jansen",5,"1978-01-02T00:00:00"
        """
        let decoder = CSVDecoder()
        do {
            let realCustomer = try decoder.decode(Customer.self, from: data)
            XCTAssertEqual(realCustomer.firstName, "Theo")
            XCTAssertEqual(realCustomer.surName, "Jansen")
            XCTAssertEqual(realCustomer.issueCount, 5)
            XCTAssertEqual(realCustomer.birthData, "1978-01-02T00:00:00")
        }
        catch {
            print(error)
            XCTFail(error.localizedDescription)
        }
    }
}


// MARK: Customer

fileprivate struct FakeCustomer: Decodable {
    let name: String
    let age: Int
    let city: String
    let postcode: String?
    let birthplace: String?
    
    // MARK: Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case name
        case age
        case city
        case postcode
        case birthplace
    }
}
