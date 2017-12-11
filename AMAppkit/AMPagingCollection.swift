//
//  AMPagingCollectionHelper.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/29/17.
//  Copyright © 2017 Arello Mobile. All rights reserved.
//

import Foundation
import UIKit

open class AMPagingCollection: AMCollection {
    
    open private(set) var loader: AMPagingLoader!
    private weak var pagingDelegate: AMPagingLoaderDelegate!
    
    override func setup() {
        super.setup()
        
        let loaderType = pagingDelegate.pagingLoader?() ?? AMPagingLoader.self
        
        loader = loaderType.init(scrollView: collection,
                                 delegate: pagingDelegate!,
                                 addRefreshControl: { [unowned self] (control) in
                                        
                                    if #available(iOS 10.0, *) {
                                        self.collection.refreshControl = control
                                    } else {
                                        self.collection.insertSubview(control, at: 0)
                                    }
                                        
            }, scrollOnRefreshing: { [weak self] (control) in
                
                if let wSelf = self {
                    if wSelf.isVertical() {
                        wSelf.collection.contentOffset = CGPoint(x: 0, y: -control.bounds.size.width)
                    } else {
                        wSelf.collection.contentOffset = CGPoint(x: -control.bounds.size.width, y: 0)
                    }
                }
            }, setFooterVisible: { [weak self] (visible, footerView) in
                
                if let wSelf = self {
                    var insets = wSelf.collection.contentInset
                    
                    if visible {
                        wSelf.collection.addSubview(footerView)
                        if wSelf.isVertical() {
                            footerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                            insets.bottom = footerView.frame.size.height
                        } else {
                            insets.right = footerView.frame.size.width
                        }
                    } else {
                        footerView.removeFromSuperview()
                        
                        if wSelf.isVertical() {
                            insets.bottom = 0
                        } else {
                            insets.right = 0
                        }
                    }
                    wSelf.collection.contentInset = insets
                    wSelf.reloadFooterPosition()
                }
        })
        collection.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
    open func isVertical() -> Bool {
        return self.layout!.scrollDirection == .vertical
    }
    
    open func reloadFooterPosition() {
        let size = collection.collectionViewLayout.collectionViewContentSize
        
        if isVertical() {
            loader.footerLoadingView.center = CGPoint(x: size.width / 2.0, y: size.height + loader.footerLoadingView.frame.size.height / 2.0)
        } else {
            loader.footerLoadingView.center = CGPoint(x: size.width + loader.footerLoadingView.frame.size.width / 2.0, y: size.height / 2.0)
        }
    }
    
    public init(collection: AMCollectionView, pagingDelegate: CollectionDelegate & AMPagingLoaderDelegate) {
        self.pagingDelegate = pagingDelegate
        super.init(collection: collection, delegate: pagingDelegate)
    }
    
    public init(view: UIView, pagingDelegate: AMPagingLoaderDelegate & CollectionDelegate) {
        self.pagingDelegate = pagingDelegate
        super.init(view: view, delegate: pagingDelegate)
    }
    
    public init(customAdd: (AMCollectionView)->(), pagingDelegate: AMPagingLoaderDelegate & CollectionDelegate) {
        self.pagingDelegate = pagingDelegate
        super.init(customAdd: customAdd, delegate: pagingDelegate)
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if loader.footerLoadingView != nil, keyPath == "contentOffset" {
            reloadFooterPosition()
        }
    }
    
    deinit {
        collection.removeObserver(self, forKeyPath: "contentOffset")
    }
}

extension AMPagingCollection {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loader.endDecelerating()
        delegate.scrollViewDidEndDecelerating?(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loader.endDecelerating()
        }
        delegate.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
}
