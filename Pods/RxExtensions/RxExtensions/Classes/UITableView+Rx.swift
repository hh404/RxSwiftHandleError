//
//  UITableView+Rx.swift
//  Pods
//
//  Created by Patryk on 05.07.2017.
//
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    public var itemSelected: ControlEvent<(UITableView, IndexPath)> {
        let source = self.delegate.methodInvoked(#selector(UITableViewDelegate.tableView(_:didSelectRowAt:)))
            .map { a in
                return (a[0] as! UITableView, a[1] as! IndexPath)
        }
        
        return ControlEvent(events: source)
    }
}
