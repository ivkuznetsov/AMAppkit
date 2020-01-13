//
//  AMNotificationManager.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/29/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

private struct AMObserver: Equatable {
    
    static func ==(lhs: AMObserver, rhs: AMObserver) -> Bool {
        return lhs.object === rhs.object && lhs.uid == rhs.uid
    }
    
    weak var object: AnyObject?
    var uid: String
    var closure: (AMNotification?)->()
    
    init(object: AnyObject, closure: @escaping (AMNotification?)->(), uid: String) {
        self.object = object
        self.closure = closure
        self.uid = uid
    }
}

@objc open class AMNotificationManager: NSObject {
    
    @objc public static let shared = AMNotificationManager()
    
    private var dictionary: [AnyHashable:[AMObserver]] = [:]
    
    @objc open func add(observer: AnyObject, closure: @escaping (AMNotification?)->(), names: [String]) {
        let uid = UUID().uuidString
        
        for name in names {
            var array = dictionary[name] ?? []
            array.append(AMObserver(object: observer, closure: closure, uid: uid))
            dictionary[name] = array
        }
    }
    
    @objc open func remove(observer: AnyObject, names: [String]) {
        for name in names {
            dictionary[name] = dictionary[name]?.compactMap { $0.object === observer ? nil : $0 }
        }
    }
    
    private func runOnMainThread(_ closure: @escaping ()->()) {
        if Thread.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async(execute: closure)
        }
    }
    
    @objc open func postNotification(names: [String], notification: AMNotification?) {
        runOnMainThread {
            var postedUpdates: [AMObserver] = []
            
            for name in names {
                let array = self.dictionary[name]
                
                if var array = self.dictionary[name] {
                    for observer in array.reversed() {
                        if observer.object == nil || postedUpdates.contains(observer) {
                            continue
                        }
                        
                        if notification?.sender == nil || notification!.sender! !== observer.object {
                            observer.closure(notification)
                        }
                        
                        postedUpdates.append(observer)
                    }
                    self.dictionary[name] = self.dictionary[name]?.filter({ $0.object != nil })
                }
            }
        }
    }
}
