//
//  AMMake.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 12/8/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

@available(swift, obsoleted: 1.0)
@objc public class TMake: NSObject {
    
    @objc public class func cell(_ type: UITableViewCell.Type, _ fill: ((UITableViewCell)->())?) -> Any {
        return TCell(type, fill)
    }
    
    @objc public class func oldEditor(_ actions: @escaping ()->([UITableViewRowAction])) -> Any {
        return TEditor(actions: actions)
    }
    
    @objc public class func deleteEditor(_ delete: @escaping ()->()) -> Any {
        return TEditor(delete: delete)
    }
    
    @available(iOS 11.0, *)
    @objc public class func editor(_ actions: @escaping ()->([UIContextualAction])) -> Any {
        return TEditor(actions: actions)
    }
}

@available(swift, obsoleted: 1.0)
@objc public class CMake: NSObject {
    
    @objc public class func cell(_ type: UICollectionViewCell.Type, _ fill: ((UICollectionViewCell)->())?) -> Any {
        return CCell(type, fill)
    }
}

@objc public class AMake: NSObject {
    
    var title: String!
    var closure: (()->())?
    var closureField: ((UITextField)->())?
    
    public required override init() {
        super.init()
    }
    
    @objc public class func action(_ title: String, _ closure: (()->())?) -> Any {
        let make = self.init()
        make.title = title
        make.closure = closure
        return make
    }
    
    @objc public class func action(_ title: String) -> Any {
        let make = self.init()
        make.title = title
        return make
    }
}
