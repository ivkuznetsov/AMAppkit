//
//  TabsView.swift
//  YouPlayer
//
//  Created by Ilya Kuznetsov on 11/30/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

@objc public enum TabsViewStyle: Int {
    case light
    case dark
}

@objc open class TabsView: UIView {
    
    private(set) var stackView: UIStackView?
    
    private var backgroundView: UIView
    private var selectedView: UIView
    private(set) var selectedIndex: Int = 0
    private var didSelect: (UIButton)->()
    
    open override var frame: CGRect {
        willSet {
            stackView?.layoutMargins = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: -8)
        }
    }
    
    public init(titles: [String], style: TabsViewStyle, didSelect: @escaping (UIButton)->()) {
        self.didSelect = didSelect
        
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        
        selectedView = UIView()
        
        super.init(frame: CGRect.zero)
        var buttons: [UIButton] = []
        for (index, title) in titles.enumerated() {
            let button = TabsViewButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
            button.tintColor = style == .dark ? UIColor.white : UIColor.black
            button.addTarget(self, action: #selector(selectAction(_:)), for: .touchUpInside)
            button.tag = index
            buttons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: buttons)
        stackView?.axis = .horizontal
        stackView?.distribution = .fillEqually
        self.addSubview(stackView!)
        
        stackView!.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: stackView!, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: stackView!, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -3))
        self.addConstraint(NSLayoutConstraint(item: stackView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: stackView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        
        let color = UIColor(red: 226.0 / 255.0, green: 225.0 / 255.0, blue: 229.0 / 255.0, alpha: 1.0)
        if style == .light {
            self.backgroundColor = color.withAlphaComponent(0.3)
        }
        self.addSubview(backgroundView)
        
        selectedView.backgroundColor = tintColor
        backgroundView.addSubview(selectedView)
    }
    
    open override var tintColor: UIColor! {
        didSet {
            selectedView.backgroundColor = tintColor
        }
    }
    
    open func buttons() -> [UIButton] {
        return stackView!.arrangedSubviews as? [UIButton] ?? []
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.frame = CGRect(x: stackView!.layoutMargins.left, y: self.bounds.size.height - 2, width: stackView!.width - stackView!.layoutMargins.left - stackView!.layoutMargins.right, height: 2)
        selectedView.frame = selectedFrame()
    }
    
    private func selectedFrame() -> CGRect {
        if stackView!.arrangedSubviews.count == 0 {
            return CGRect.zero
        }
        
        let width = backgroundView.width / CGFloat(stackView!.arrangedSubviews.count)
        return CGRect(x: width * CGFloat(selectedIndex), y: 0, width: width, height: backgroundView.height)
    }
    
    @objc private func selectAction(_ sender: UIButton) {
        selectTab(index: stackView!.arrangedSubviews.index(of: sender)!, animated: true)
        didSelect(sender)
    }
    
    open func selectTab(index: Int, animated: Bool) {
        selectedIndex = index
        UIView.animate(withDuration: animated ? 0.2 : 0.0) {
            self.selectedView.frame = self.selectedFrame()
        }
    }
    
    open func button(at index: Int) -> TabsViewButton {
        return stackView!.arrangedSubviews[index] as! TabsViewButton
    }
}
