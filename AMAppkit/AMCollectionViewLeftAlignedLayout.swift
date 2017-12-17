//
//  AMCollectionViewLeftAlignedLayout.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 12/3/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

fileprivate extension UICollectionViewLayoutAttributes {
    
    func alignFrame(sectionInset: UIEdgeInsets) {
        var frame = self.frame
        frame.origin.x = sectionInset.left
        self.frame = frame
    }
}

open class AMCollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        var updatedAttributes = attributes
        
        for (index, attribute) in attributes.enumerated() {
            if attribute.representedElementKind != nil {
                if let attributes = self.layoutAttributesForItem(at: attribute.indexPath) {
                    updatedAttributes[index] = attributes
                }
            }
        }
        return updatedAttributes
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let currentItemAttributes = super.layoutAttributesForItem(at: indexPath) else {
            return nil
        }
        let sectionInset = evaluatedSectionInset(itemIndex: indexPath.section)
        
        let layoutWidth = self.collectionView?.frame.size.width ?? 0 - sectionInset.left - sectionInset.right
        
        if indexPath.item == 0 {
            currentItemAttributes.alignFrame(sectionInset: sectionInset)
            return currentItemAttributes
        }
        
        let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
        let previousFrame = self.layoutAttributesForItem(at: previousIndexPath)?.frame ?? CGRect.zero
        let previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width
        let currentFrame = currentItemAttributes.frame
        let strecthedCurrentFrame = CGRect(x: sectionInset.left, y: currentFrame.origin.y, width: layoutWidth, height: currentFrame.size.height)
        
        let isFirstItemInRow = !previousFrame.intersects(strecthedCurrentFrame)
        
        if isFirstItemInRow {
            currentItemAttributes.alignFrame(sectionInset: sectionInset)
            return currentItemAttributes
        }
        
        var frame = currentItemAttributes.frame
        frame.origin.x = previousFrameRightPoint + evaluateMinimumInteritemSpacing(sectionIndex: indexPath.section)
        currentItemAttributes.frame = frame
        return currentItemAttributes
    }
    
    func evaluateMinimumInteritemSpacing(sectionIndex: Int) -> CGFloat {
        if let delegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout {
            return delegate.collectionView?(self.collectionView!, layout: self, minimumLineSpacingForSectionAt: sectionIndex) ?? minimumInteritemSpacing
        }
        return 0
    }
    
    func evaluatedSectionInset(itemIndex: Int) -> UIEdgeInsets {
        if let delegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout {
            return delegate.collectionView?(self.collectionView!, layout: self, insetForSectionAt: itemIndex) ?? sectionInset
        }
        return UIEdgeInsets.zero
    }
}
