//
//  RxExtensions.swift
//  Pods
//
//  Created by Patryk on 05.07.2017.
//
//

import Foundation
import RxSwift
import RxCocoa

///Operator for bidirectional binding. UIElement on left, variable on right.
infix operator <->

///Function for bidirectional binding. UIElement on left, variable on right.
public func <-> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    let bindToUIDisposable = variable.asObservable()
        .bind(to: property)
    let bindToVariable = property
        .subscribe(onNext: { n in
            variable.value = n
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })
    
    return CompositeDisposable(bindToUIDisposable, bindToVariable)
}

extension Observable {
    
    open func doOnNext(_ next: @escaping ((Element) -> Void)) -> Observable<Element> {
        return self.do(onNext: next)
    }
    
    open func doOnCompleted(_ completed: @escaping (() -> Void)) -> Observable<Element> {
        return self.do(onCompleted: completed)
    }
    
    open func doOnError(_ error: @escaping ((Error) -> Void)) -> Observable<Element> {
        return self.do(onError: error)
    }
    
    open func subscribeNext(_ next: @escaping ((Element) -> Void)) -> Disposable {
        return self.subscribe(onNext: next)
    }
    
    open func subscribeError(_ error: @escaping ((Error) -> Void)) -> Disposable {
        return self.subscribe(onError: error)
    }
    
    open func subscribeCompleted(_ completed: @escaping (() -> Void)) -> Disposable {
        return self.subscribe(onCompleted: completed)
    }
    
    open func asPublishSubject() -> PublishSubject<Element>? {
        return self as? PublishSubject<Element>
    }
}

extension ControlEvent {
    public func subscribeNext(_ next: @escaping ((E) -> Void)) -> Disposable {
        return self.subscribe(onNext: next)
    }
}

extension Disposable {
    public func dispose(in bag: DisposeBag) {
        addDisposableTo(bag)
    }
}
