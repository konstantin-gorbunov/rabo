//
//  DetailsViewModel.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

struct DetailsViewModel {
    let name: String
    let birthData: String
    let text: String

    init(customer: Customer) {
        birthData = customer.birthData
        let nameFormat = NSLocalizedString("%@ %@", comment: "Full name")
        name = String.localizedStringWithFormat(nameFormat, customer.firstName, customer.surName).trimmingCharacters(in: .whitespaces)
        if customer.issueCount > 0 {
            let issueFormat = NSLocalizedString("Issue count: %u", comment: "Issue count")
            text = String.localizedStringWithFormat(issueFormat, customer.issueCount)
        } else {
            text = NSLocalizedString("No Issues", comment: "No Issues value")
        }
    }
}
