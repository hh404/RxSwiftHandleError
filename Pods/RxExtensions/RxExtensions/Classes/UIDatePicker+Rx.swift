//
//  UIDatePicker+Rx.swift
//  Pods
//
//  Created by Patryk on 05.07.2017.
//
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIDatePicker {
    public var pickerMode: UIBindingObserver<Base, UIDatePickerMode> {
        return UIBindingObserver(UIElement: self.base) { `self`, mode in
            self.datePickerMode = mode
        }
    }
}
