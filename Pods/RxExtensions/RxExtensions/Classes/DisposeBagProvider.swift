//
//  DisposeBagProvider.swift
//  Pods
//
//  Created by Patryk on 05.07.2017.
//
//

import Foundation
import RxSwift

private struct AssociatedKeys {
    static var DisposeBagKey = "DisposeBagKey"
}

public protocol DisposeBagProvider: class {
    
    /// A `DisposeBag` that can be used to dispose observations and bindings.
    var disposeBag: DisposeBag { get set }
}

extension DisposeBagProvider {
    
    /// Use this bag to dispose disposables upon the deallocation of the receiver.
    public var disposeBag: DisposeBag {
        get {
            if let disposeBag = objc_getAssociatedObject(self, &AssociatedKeys.DisposeBagKey) as? DisposeBag {
                return disposeBag
            } else {
                let disposeBag = DisposeBag()
                objc_setAssociatedObject(self, &AssociatedKeys.DisposeBagKey, disposeBag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return disposeBag
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.DisposeBagKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension NSObject: DisposeBagProvider { }
