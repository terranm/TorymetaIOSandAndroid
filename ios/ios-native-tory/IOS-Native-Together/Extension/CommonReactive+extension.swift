//
//  CommonReactive+extension.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import PanModal

extension Reactive where Base: UIViewController {

    func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) -> Binder<UITapGestureRecognizer> {
        Binder(base) { [weak base] _, _ in
            base?.dismiss(animated: animated, completion: completion)
        }
    }

    func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) -> Binder<Void> {
        Binder(base) { [weak base] _, _ in
            base?.dismiss(animated: animated, completion: completion)
        }
    }

    func endEditing(force: Bool = true) -> Binder<UITapGestureRecognizer> {
        Binder(base) { [weak base] _, _ in
            base?.view.endEditing(force)
        }
    }
}

extension Reactive where Base: UICollectionView {
    func reloadData<T: Collection>() -> Binder<T> {
        Binder(base) { collectionView, data in
            if !data.isEmpty {
                collectionView.reloadData()
            }
        }
    }
}

extension Reactive where Base: UIImageView {
    var imageURLString: Binder<String> {
        Binder(base) { _, data in
            base.kf.setImage(with: URL(string: data))
        }
    }

    var imageURL: Binder<URL?> {
        Binder(base) { _, data in
            base.kf.setImage(with: data)
        }
    }
}
