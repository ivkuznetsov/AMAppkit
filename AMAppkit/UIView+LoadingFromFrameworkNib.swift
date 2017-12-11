//
//  UIView+LoadingFromFrameworkNib.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/28/17.
//  Copyright © 2017 Arello Mobile. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    public static func loadFromNib() -> Self {
        return loadFrom(nib: String(describing: self))
    }
    
    public static func loadFrom(nib: String) -> Self {
        return loadFrom(nib: nib, owner: nil)
    }
    
    public static func loadFrom(nib: String, owner: Any?) -> Self {
        return loadFrom(nib: nib, owner: owner, type: self)
    }
    
    public static func loadFrom<T: UIView>(nib: String, owner: Any?, type: T.Type) -> T  {
        var bundle = Bundle.main
        if bundle.path(forResource: nib, ofType: "nib") == nil {
            bundle = Bundle(for: type)
        }
        
        var resultObject: T?
        if let objects = bundle.loadNibNamed(nib, owner: owner, options: nil) {
            for object in objects {
                if let object = object as? T {
                    resultObject = object
                    break
                }
            }
        }
        return resultObject! // crash if didn't find
    }
}
