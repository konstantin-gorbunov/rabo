//
//  DetailsViewController.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

protocol DetailsViewDelegate: class {
    func onDetailsViewFinished(_ viewController: UIViewController)
}

class DetailsViewController: UIViewController {

    @IBOutlet weak var mainTitle: UILabel?
    @IBOutlet weak var subTitle: UILabel?
    @IBOutlet weak var birthdayTitle: UILabel?

    weak var delegate: DetailsViewDelegate?

    var viewModel: DetailsViewModel? {
        didSet {
            loadViewIfNeeded()
            mainTitle?.text = viewModel?.name
            subTitle?.text = viewModel?.text
            birthdayTitle?.text = viewModel?.birthDate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            delegate?.onDetailsViewFinished(self)
        }
    }
}
