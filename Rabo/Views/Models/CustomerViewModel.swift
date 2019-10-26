//
//  CardViewModel.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

struct CustomerViewModel {
    let name: String
    let borderSides: BorderLayer.Side
    
    init(customer: Customer, borderSides: BorderLayer.Side) {
        let nameFormat = NSLocalizedString("%@ %@", comment: "Full name")
        name = String.localizedStringWithFormat(nameFormat, customer.firstName, customer.surName)
        self.borderSides = borderSides
    }
}
