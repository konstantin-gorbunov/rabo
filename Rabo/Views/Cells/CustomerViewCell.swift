//
//  CardViewCell.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

class CustomerViewCell: UICollectionViewCell, NibInstantiatable {

    @IBOutlet private weak var borderedView: BorderedView? {
        didSet {
            borderedView?.borderColor = UIColor.blue.cgColor
        }
    }

    @IBOutlet private weak var titleLabel: UILabel?

    var viewModel: CustomerViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            titleLabel?.text = viewModel.name
            borderedView?.borderSides = viewModel.borderSides
        }
    }
}
