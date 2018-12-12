//
//  AMCollectionView.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/28/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation
import UIKit

open class AMCollectionView: UICollectionView {
    
    private var registeredCells: Set<String> = Set()
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canCancelContentTouches = true
        self.delaysContentTouches = false
    }
    
    @objc open func createCell(for type: UICollectionViewCell.Type, at indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: type)
        
        if !registeredCells.contains(identifier) {
            register(UINib(nibName: identifier, bundle: Bundle(for: type)), forCellWithReuseIdentifier: identifier)
            registeredCells.insert(identifier)
        }
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
    
    open override func touchesShouldCancel(in view: UIView) -> Bool {
        if view as? UIControl != nil {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
    open override var frame: CGRect {
        didSet {
            if needRelayoutFor(size: frame.size, oldSize: oldValue.size) {
                collectionViewLayout.invalidateLayout()
            }
        }
    }
    
    open override var bounds: CGRect {
        didSet {
            if needRelayoutFor(size: bounds.size, oldSize: oldValue.size) {
                self.layoutIfNeeded()
                self.collectionViewLayout.invalidateLayout()
            }
        }
    }
    
    private func needRelayoutFor(size: CGSize, oldSize: CGSize) -> Bool {
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            if layout.scrollDirection == .horizontal {
                return size.height != oldSize.height
            } else {
                return size.width != oldSize.width
            }
        }
        return size != oldSize
    }
}
