//
//  AMNotificationManagerTests.swift
//  AMAppkitTests
//
//  Created by Ilya Kuznetsov on 1/31/18.
//

import XCTest
@testable import AMAppkit

class SampleObserverClass: NSObject {
    
}

class SampleObservableClass: NSObject, AMObservable {
    
}

class AMNotificationManagerTests: XCTestCase {
    
    var notificationManager: AMNotificationManager!
    
    override func setUp() {
        super.setUp()
        notificationManager = AMNotificationManager()
    }
    
    func testSimpleNotification() {
        let observer = SampleObserverClass()
        let removedObserver = SampleObserverClass()
        
        let test = expectation(description: "Got notification single time")
        
        [observer, removedObserver].forEach {
            notificationManager.add(observer: $0, closure: { (_) in
                test.fulfill()
            }, names: ["Notification"])
        }
        notificationManager.remove(observer: removedObserver, names: ["Notification"])
        notificationManager.postNotification(names: ["Notification"], notification: nil)
        wait(for: [test], timeout: 1.0)
    }
    
    func testNotificationsOrder() {
        let observers: [SampleObserverClass] = (0..<15).map { (_) in return SampleObserverClass() }
        var gotNorification: [SampleObserverClass] = []
        
        let test = expectation(description: "Got notifications in correct order")
        
        observers.forEach { (observer) in
            notificationManager.add(observer: observer, closure: { (_) in
                
                gotNorification.append(observer)
                
                if gotNorification.count == observers.count {
                    XCTAssert(gotNorification.reversed() == observers)
                    test.fulfill()
                }
                
            }, names: ["Notification"])
        }
        notificationManager.postNotification(names: ["Notification"], notification: nil)
        
        wait(for: [test], timeout: 1.0)
    }
    
    func testProcessingServeralNotificationNames() {
        
        let observers: [SampleObserverClass] = (0...15).map { (_) in return SampleObserverClass() }
        var notificationCount = 0
        
        observers.enumerated().forEach { (index, object) in
            
            var names: [String] = []
            
            switch index {
            case 0...5:
                names = ["FirstNotification"]
            case 6...12:
                names = ["FirstNotification", "SecondNotification"]
            default:
                names = ["SecondNotification"]
            }
            
            notificationManager.add(observer: object, closure: { (_) in
                notificationCount += 1
            }, names: names)
        }
        
        notificationManager.postNotification(names: ["FirstNotification"], notification: nil)
        XCTAssert(notificationCount == 13)
        
        notificationCount = 0
        notificationManager.postNotification(names: ["SecondNotification"], notification: nil)
        XCTAssert(notificationCount == 10)
        
        notificationCount = 0
        notificationManager.postNotification(names: ["FirstNotification", "SecondNotification"], notification: nil)
        XCTAssert(notificationCount == 16)
        
        observers[0...5].forEach {
            notificationManager.add(observer: $0, closure: { (_) in
                notificationCount += 1
            }, names: ["SecondNotification"])
        }
        
        notificationCount = 0
        notificationManager.postNotification(names: ["SecondNotification"], notification: nil)
        XCTAssert(notificationCount == 16)
    }
    
    func testNotificationSender() {
        let observer = SampleObserverClass()
        let senderObserver = SampleObserverClass()
        
        let test = expectation(description: "Got notification single time")
        
        [observer, senderObserver].forEach {
            notificationManager.add(observer: $0, closure: { (_) in
                test.fulfill()
            }, names: ["Notification"])
        }
        
        let notification = AMNotification()
        notification.sender = senderObserver
        notificationManager.postNotification(names: ["Notification"], notification: notification)
        wait(for: [test], timeout: 1.0)
    }
    
    func testObservableObject() {
        let test = expectation(description: "Got notification single time")
        
        let observable = SampleObservableClass()
        let secondObservable = SampleObservableClass()
        let observer = SampleObserverClass()
        
        observable.observe(observer) { (_) in
            test.fulfill()
        }
        
        observable.post(nil)
        secondObservable.post(nil)
        wait(for: [test], timeout: 1.0)
    }
    
    func testObserveAllObservableClassObjects() {
        let observable = SampleObservableClass()
        let secondObservable = SampleObservableClass()
        let observer = SampleObserverClass()
        
        var notifications = 0
        SampleObservableClass.observe(observer) { (_) in
            notifications += 1
        }
        
        observable.post(nil)
        secondObservable.post(nil)
        
        XCTAssert(notifications == 2)
    }
}
