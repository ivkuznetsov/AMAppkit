//
//  AMLoadingView.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/28/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation
import UIKit

open class AMLoadingView : UIView {
    
    @IBOutlet open var indicator: UIActivityIndicatorView!
    @IBOutlet open var progressIndicator: AMCircularProgressView!
    
    @objc open var opaqueStyle: Bool = false {
        didSet {
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(opaqueStyle ? 1.0 : 0.6)
        }
    }
    @objc open var progress: CGFloat = 0 {
        didSet {
            indicator.isHidden = true
            progressIndicator.isHidden = false
            progressIndicator.progress = progress
        }
    }
    
    @objc open class func present(in view: UIView, animated: Bool) -> Self {
        let loadingView = self.loadFromNib()
        
        loadingView.frame = view.bounds
        loadingView.progressIndicator.isHidden = true
        loadingView.opaqueStyle = false
        view.addSubview(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[loadingView]|", options: [], metrics: nil, views: ["loadingView":loadingView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[loadingView]|", options: [], metrics: nil, views: ["loadingView":loadingView]))
        
        if animated {
            loadingView.alpha = 0
            UIView.animate(withDuration: 0.2, animations: {
                loadingView.alpha = 1
            })
        }
        
        return loadingView
    }
    
    @objc open func hide(_ animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 0
            }, completion: { (_) in
                self.removeFromSuperview()
            })
        } else {
            self.removeFromSuperview()
        }
    }
}
