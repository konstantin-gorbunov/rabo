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
    let birthDate: String
    let text: String
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "nl_NL")
        return formatter
    }()

    init(customer: Customer) {
        if let date = customer.birthDate() {
            birthDate = dateFormatter.string(from: date)
        } else {
            birthDate = NSLocalizedString("No Birthday Date", comment: "No Birthday Date")
        }
        
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
