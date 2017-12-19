//
//  AMPagingTable.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/26/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

@objc open class AMPagingTable: AMTable {
    
    @objc open private(set) var loader: AMPagingLoader!
    private weak var pagingDelegate: AMPagingLoaderDelegate!
    
    override func setup() {
        super.setup()
        
        let loaderType = pagingDelegate.pagingLoader?() ?? AMPagingLoader.self
        
        self.loader = loaderType.init(scrollView: table,
                                 delegate: pagingDelegate!,
                                 addRefreshControl: { [unowned self] (control) in
                                    
                                    if #available(iOS 10.0, *) {
                                        self.table.refreshControl = control
                                    } else {
                                        self.table.insertSubview(control, at: 0)
                                    }
                                    
            }, scrollOnRefreshing: { [weak self] (control) in
                
                self?.table.contentOffset = CGPoint(x: 0, y: -control.bounds.size.height)
                
            }, setFooterVisible: { [weak self] (visible, footerView) in
                
                self?.table.tableFooterView = visible ? footerView : UIView()
        })
    }
    
    @objc public init(table: UITableView, pagingDelegate: AMPagingLoaderDelegate & TableDelegate) {
        self.pagingDelegate = pagingDelegate
        super.init(table: table, delegate: pagingDelegate)
    }
    
    @objc public convenience init(view: UIView, pagingDelegate: AMPagingLoaderDelegate & TableDelegate) {
        self.init(view: view, style: .plain, pagingDelegate: pagingDelegate)
    }
    
    @objc public init(view: UIView, style: UITableViewStyle, pagingDelegate: AMPagingLoaderDelegate & TableDelegate) {
        self.pagingDelegate = pagingDelegate
        super.init(view: view, style: style, delegate: pagingDelegate)
    }
    
    @objc public convenience init(customAdd: (UITableView)->(), pagingDelegate: AMPagingLoaderDelegate & TableDelegate) {
        self.init(customAdd: customAdd, style: .plain, pagingDelegate: pagingDelegate)
    }
    
    @objc public init(customAdd: (UITableView)->(), style: UITableViewStyle, pagingDelegate: AMPagingLoaderDelegate & TableDelegate) {
        self.pagingDelegate = pagingDelegate
        super.init(customAdd: customAdd, style: style, delegate: pagingDelegate)
    }
}

extension AMPagingTable {
    
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