//
//  AMOptionsView.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 12/8/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

@objc open class AMOptionsView: UIView, TableDelegate {
    
    @objc open var options: [AnyHashable]! {
        didSet {
            table.set(objects: options, animated: false)
        }
    }
    
    fileprivate var table: AMTable!
    @IBOutlet private var overlayView: UIView!
    fileprivate var fill: ((UITableViewCell, Any)->())!
    fileprivate var didSelect: ((Any)->())!
    private var willHide: (()->())?
    fileprivate var selectedOption: Any?
    open var cellHeight: CGFloat = 50.0
    
    open class func present<T: Hashable>(view: UIView,
                                         options: [T],
                                         selectedOption: T,
                                         fill: @escaping (UITableViewCell, T)->(),
                                         willHide: (()->())?,
                                         didSelect: @escaping (T)->()) -> Self {
        let optionView = self.loadFromNib()
        optionView.selectedOption = selectedOption
        optionView.fill = { (cell, option) in
            let safeOtions = option as Any // swift bug workaround
            fill(cell, safeOtions as! T)
        }
        optionView.didSelect = { (option) in
            let safeOtions = option as Any // swift bug workaround
            didSelect(safeOtions as! T)
        }
        optionView.willHide = willHide
        optionView.options = options
        DispatchQueue.main.async {
            optionView.show(in: view)
        }
        return optionView
    }
    
    @objc open func hide() {
        willHide?()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.table.table.transform = CGAffineTransform(translationX: 0, y: -self.tableOffset())
            self.overlayView.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    @available(swift, obsoleted: 1.0)
    @objc open class func present(in view: UIView,
                                  options: [AnyHashable],
                                  selectedOption: AnyHashable,
                                  fill: @escaping (UITableViewCell, AnyHashable)->(),
                                  willHide: (()->())?,
                                  didSelect: @escaping (AnyHashable)->()) -> Self {
        return present(view: view, options: options, selectedOption: selectedOption, fill: fill, willHide: willHide, didSelect: didSelect)
    }
    
    private func show(in view: UIView) {
        overlayView.alpha = 0
        frame = view.bounds
        table.table.transform = CGAffineTransform(translationX: 0, y: -tableOffset())
        view.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            self.overlayView.alpha = 1
            self.table.table.transform = CGAffineTransform.identity
        }
        
    }
    
    private func tableOffset() -> CGFloat {
        return CGFloat(table.objects.count) * self.cellHeight(object: 0, def: 0, table: table)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        table = AMTable(view: self, delegate: self)
        let gr = UITapGestureRecognizer(target: self, action: #selector(hide))
        gr.delegate = self
        table.table.addGestureRecognizer(gr)
    }
    
    public func createCell(object: Any, table: AMTable) -> Any? {
        return TCell(AMOptionCell.self, { (cell) in
            self.fill(cell, object)
            
            if let option = self.selectedOption,
                (option as! AnyHashable).hashValue == (object as! AnyHashable).hashValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        })
    }
    
    public func action(object: Any, table: AMTable) -> AResult {
        didSelect(object)
        return .deselect
    }
    
    public func cellHeight(object: Any, def: CGFloat, table: AMTable) -> CGFloat {
        return cellHeight
    }
}

extension AMOptionsView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.location(in: table.table).y > table.table.contentSize.height
    }
}
