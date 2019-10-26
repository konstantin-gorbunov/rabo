//
//  Instantiatable.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

protocol NibInstantiatable {
    static var nibIdentifier: String { get }
}

extension NibInstantiatable {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}

extension NibInstantiatable where Self: UICollectionViewCell {
    static func dequeue(in collectionView: UICollectionView, at indexPath: IndexPath) -> Self {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nibIdentifier, for: indexPath) as? Self else {
                fatalError("Can't dequeue \(self) with \(collectionView) at \(indexPath)!")
        }
        return cell
    }
}

extension UICollectionView {
    func register(_ instantiatable: NibInstantiatable.Type) {
        self.register(
            UINib(nibName: instantiatable.nibIdentifier, bundle: nil),
            forCellWithReuseIdentifier: instantiatable.nibIdentifier
        )
    }

    func dequeue<T: NibInstantiatable>(at indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return T.dequeue(in: self, at: indexPath)
    }
}
