//
//  AMRefreshControl.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 3/22/18.
//

import Foundation

class AMRefreshControl: UIRefreshControl {
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        if window != nil && isRefreshing, let scrollView = superview as? UIScrollView {
            let offset = scrollView.contentOffset
            UIView.performWithoutAnimation {
                endRefreshing()
            }
            beginRefreshing()
            scrollView.contentOffset = offset
        }
    }
}
