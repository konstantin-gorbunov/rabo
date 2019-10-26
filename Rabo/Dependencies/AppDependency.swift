//
//  AppDependency.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import CoreData

protocol Dependency {
    var dataProvider: DataProvider { get }
}

class AppDependency: Dependency {

    let dataProvider: DataProvider = LocalCustomerDataProvider()
}
