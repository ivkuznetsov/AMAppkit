//
//  AMObservable.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/29/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

public protocol AMObservable: class {
    
    static func notificationName() -> String
    
    func observe(_ observer: AnyObject, closure: @escaping (AMNotification?)->())
    
    static func observe(_ observer: AnyObject, closure: @escaping (AMNotification?)->())
    
    // removing observer is not necessary, it will be removed after object gets deallocated
    static func cancelObserving(_ observer: AnyObject)
    
    static func post(_ notification: AMNotification?)
    func post(_ notification: AMNotification?)
}

public extension AMObservable {
    
    static func notificationName() -> String {
        return String(describing: self)
    }
    
    func observe(_ observer: AnyObject, closure: @escaping (AMNotification?)->()) {
        type(of: self).observe(observer) { [unowned self] (notification) in
            if notification == nil || notification!.object == nil || notification!.object! === self {
                closure(notification)
            }
        }
    }
    
    static func observe(_ observer: AnyObject, closure: @escaping (AMNotification?)->()) {
        AMNotificationManager.shared.add(observer: observer, closure: closure, names: [notificationName()])
    }
    
    static func cancelObserving(_ observer: AnyObject) {
        AMNotificationManager.shared.remove(observer: observer, names: [notificationName()])
    }
    
    static func post(_ notification: AMNotification?) {
        AMNotificationManager.shared.postNotification(names: [notificationName()], notification: notification)
    }
    
    func post(_ notification: AMNotification?) {
        let notification = notification ?? AMNotification()
        notification.object = self
        type(of: self).post(notification)
    }
}
