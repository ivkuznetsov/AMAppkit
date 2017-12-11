//
//  AMObservable.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/29/17.
//  Copyright © 2017 Arello Mobile. All rights reserved.
//

import Foundation

public protocol AMObservable: class {
    
    static func notificationName() -> String
    
    static func observe(_ observer: AnyObject, closure: @escaping (AMNotification?)->())
    
    // removing observer is not necessary, it will be removed after object gets deallocated
    static func cancelObserving(_ observer: AnyObject)
    
    static func post(_ notification: AMNotification?)
    func post(_ notification: AMNotification?)
}

public extension AMObservable {
    
    public static func notificationName() -> String {
        return String(describing: self)
    }
    
    public static func observe(_ observer: AnyObject, closure: @escaping (AMNotification?)->()) {
        AMNotificationManager.shared.add(observer: observer, closure: closure, names: [notificationName()])
    }
    
    public static func cancelObserving(_ observer: AnyObject) {
        AMNotificationManager.shared.remove(observer: observer, names: [notificationName()])
    }
    
    public static func post(_ notification: AMNotification?) {
        AMNotificationManager.shared.postNotification(names: [notificationName()], notification: notification)
    }
    
    public func post(_ notification: AMNotification?) {
        let notification = notification
        notification?.object = self
        type(of: self).post(notification)
    }
}
