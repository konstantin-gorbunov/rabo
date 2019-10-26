//
//  CustomerCollectionViewController.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

protocol CustomersCollectionViewDelegate: class {
    func didSelectCustomer(_ customer: Customer)
}

class CustomerCollectionViewController: BaseCollectionViewController {

    private let viewModel: CustomerListViewModel
    weak var delegate: CustomersCollectionViewDelegate?

    init(viewModel: CustomerListViewModel, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureCell(_ cell: CustomerViewCell, at indexPath: IndexPath) {
        let customer = viewModel.customers[indexPath.row]
        cell.viewModel = CustomerViewModel(
            customer: customer,
            borderSides: BorderLayer.Side.border(at: indexPath)
        )
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.customers.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCustomer(viewModel.customers[indexPath.row])
    }
}
