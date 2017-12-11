//
//  AMMake.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 12/8/17.
//  Copyright © 2017 Arello Mobile. All rights reserved.
//

import Foundation

@available(swift, obsoleted: 1.0)
@objc public class TMake: NSObject {
    
    @objc public class func cell(_ type: UITableViewCell.Type, _ fill: ((UITableViewCell)->())?) -> Any {
        return TCell(type, fill)
    }
    
    @objc public class func editor(_ actions: @escaping ()->([UITableViewRowAction])) -> Any {
        return TEditor(actions: actions)
    }
}

@available(swift, obsoleted: 1.0)
@objc public class CMake: NSObject {
    
    @objc public class func cell(_ type: UICollectionViewCell.Type, _ fill: ((UICollectionViewCell)->())?) -> Any {
        return CCell(type, fill)
    }
}
