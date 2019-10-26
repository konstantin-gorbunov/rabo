//
//  Customer.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 26/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

struct Customer: Decodable {
    
    let firstName: String
    let surName: String
    let issueCount: Int64
    let birthData: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "\"First name\""
        case surName = "\"Sur name\""
        case issueCount = "\"Issue count\""
        case birthData = "\"Date of birth\""
    }
}
