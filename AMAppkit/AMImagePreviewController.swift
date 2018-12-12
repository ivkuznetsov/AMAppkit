//
//  AMImagePreviewController.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 1/5/18.
//  Copyright © 2018 Arello Mobile. All rights reserved.
//

import Foundation

@objc open class AMImagePreviewController: AMBaseViewController {
    
    open var image: UIImage
    open var scrollView: AMPreviewScrollView!
    
    private var sourceView: UIView
    private var customContainer: UIView?
    private var animation: AMExpandAnimation!
    private var contentMode: UIView.ContentMode
    
    public init(image: UIImage, sourceView: UIView, customContainer: UIView?, contentMode: UIView.ContentMode) {
        self.image = image
        self.sourceView = sourceView
        self.customContainer = customContainer
        self.contentMode = contentMode
        super.init()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = AMPreviewScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: ["scrollView" : scrollView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: nil, views: ["scrollView" : scrollView]))
        
        scrollView.setImage(image)
        animation = AMExpandAnimation(source: sourceView, dismissingSource: scrollView.imageView, customContainer: customContainer, viewController: self, contentMode: contentMode)
        self.transitioningDelegate = animation
        
        scrollView.didZoom = { [weak self] (zoom) in
            if let wSelf = self {
                wSelf.animation.interactionDismissing = zoom <= wSelf.scrollView.minimumZoomScale
            }
        }
        scrollView.didZoom(scrollView.zoomScale)
        
        if customContainer != nil {
            scrollView?.backgroundColor = sourceView.backgroundColor
            scrollView.imageView?.backgroundColor = sourceView.backgroundColor
            scrollView.containerView?.backgroundColor = sourceView.backgroundColor
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
