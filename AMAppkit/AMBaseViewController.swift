//
//  AMBaseViewController.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/26/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

open class AMBaseViewController: UIViewController {
    
    open static var closeTitle: String?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open lazy var operationHelper: AMOperationHelper = {
        return AMOperationHelper(view: self.view)
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        if let nc = self.navigationController,
            nc.presentingViewController != nil,
            let index = nc.viewControllers.index(of: self),
            (index == 0 || nc.viewControllers[index - 1].navigationItem.rightBarButtonItem?.action == #selector(closeAction) ) {
            
            createCloseButton()
        }
    }
    
    open func createCloseButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: type(of: self).closeTitle ?? "Close", style: .plain, target: self, action: #selector(closeAction))
    }
    
    open func previousViewController() -> UIViewController? {
        if let array = self.navigationController?.viewControllers, let index = array.index(of: self), index != 0 {
            return array[index - 1]
        }
        return nil
    }
    
    @IBAction open func closeAction() {
        if let nc = self.navigationController {
            if nc.presentingViewController != nil {
                nc.dismiss(animated: true, completion: nil)
            } else if let parentVC = self.parent, let nc = parentVC.navigationController, nc.presentingViewController != nil {
                nc.dismiss(animated: true, completion: nil)
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    open func reloadView(_ animated: Bool) {
        
    }
}
