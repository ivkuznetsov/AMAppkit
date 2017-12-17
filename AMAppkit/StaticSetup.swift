//
//  LazySetup.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 12/5/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

@objc public class StaticSetup: NSObject {
    
    private static var setupClosures: [String:(StaticSetupObject)->()] = [:]
    
    public static func setup<T: StaticSetupObject>(_ type: T.Type, _ closure: @escaping (T)->()) {
        setupClosures[String(describing: type)] = { (object) in
            closure(object as! T)
        }
    }
    
    fileprivate static func performSetup(object: StaticSetupObject) {
        if let closure = setupClosures[String(describing: type(of: object))] {
            closure(object)
        }
    }
}

@objc open class StaticSetupObject: NSObject {
    
    public override init() {
        super.init()
        StaticSetup.performSetup(object: self)
    }
}

@available(swift, obsoleted: 1.0)
public extension StaticSetup {
    
    @objc public static func setupFor(_ type: AnyClass, block: @escaping (AnyObject)->()) {
        setup(type as! StaticSetupObject.Type, block)
    }
}
