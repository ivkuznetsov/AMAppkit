//
//  AMOperationHelper.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/26/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

@objc public enum AMLoadingType: Int {
    case fullscreen
    case translucent
    case touchable
    case none
}

@objc public protocol AMCancellable {
    func cancel()
}

extension URLSessionTask: AMCancellable { }

public typealias AMProgress = (Double)->()
public typealias AMOperation = (AMCancellable)->()
public typealias AMCompletion = (Any?, Error?)->()

class AMOperationToken: Hashable {
    var id: String
    var completion: AMCompletion
    var operation: AMCancellable?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: AMOperationToken, rhs: AMOperationToken) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    init(id: String, completion: @escaping AMCompletion) {
        self.id = id
        self.completion = completion
    }
}

@objc open class AMOperationHelper: StaticSetupObject {
    
    //required for using AMLoadingTypeTranslucent.
    @objc open var processTranslucentError: ((UIView, Error, /*retry*/ (()->())?)->())!
    
    //by default retry appears in all operations
    @objc open var shouldSupplyRetry: ((Any?, Error)->Bool)?
    
    @objc open var loadingViewType: AMLoadingView.Type = AMLoadingView.self
    private weak var loadingView: AMLoadingView?
    
    @objc open var loadingBarViewType: AMLoadingBarView.Type = AMLoadingBarView.self
    private var loadingBarView: AMLoadingBarView?
    
    @objc open var failedViewType: AMFailedView.Type = AMFailedView.self
    private var failedView: AMFailedView?
    
    @objc open var failedBarViewType: AMAlertBarView.Type = AMAlertBarView.self
    private weak var failedBarView: AMAlertBarView?
    
    open weak var view: UIView!
    private var keyedOperations: [String:AMOperationToken] = [:]
    private var processing = Set<AMOperationToken>()
    private var loadingCounter = 0
    private var touchableLoadingCounter = 0
    
    @objc public init(view: UIView) {
        self.view = view
        super.init()
    }
    
    private func cancel(token: AMOperationToken) {
        processing.remove(token)
        token.operation?.cancel()
        token.completion(nil, NSError(domain: "AMOperationHelper", code: NSURLErrorCancelled, userInfo: nil))
    }
    
    // progress indicator becomes visible on first AMProgress block performing
    // 'key' is needed to cancel previous launched operation with the same key, you can pass nil if you don't need such functional
    @objc open func run(_ closure: @escaping (@escaping AMCompletion, @escaping AMOperation, @escaping AMProgress)->(), completion: AMCompletion?, loading: AMLoadingType, key: String?) {
        
        assert(loading != .translucent || processTranslucentError != nil, "_processTranslucentError block must be set to use AMLoadingTypeTranslucent")
        
        increament(loading: loading)
        if let key = key {
            if let token = keyedOperations[key] {
                cancel(token: token)
            }
        }
        
        if loading == .fullscreen || loading == .translucent {
            failedView?.removeFromSuperview()
        }
        
        let token = AMOperationToken(id: UUID().uuidString,
                                     completion: { [weak self] (request, error) in
                                        if let wSelf = self {
                                            wSelf.decrement(loading: loading)
                                            
                                            if let key = key {
                                                wSelf.keyedOperations[key] = nil
                                            }
                                            
                                            if let error = error {
                                                var retry: (()->())?
                                                
                                                if wSelf.shouldSupplyRetry?(request, error) ?? true {
                                                    retry = { wSelf.run(closure, completion: completion, loading: loading, key: key) }
                                                }
                                                wSelf.process(error: error, retry: retry, loading: loading)
                                            }
                                            completion?(request, error)
                                        }
        })
        processing.insert(token)
        if let key = key {
            keyedOperations[key] = token
        }
        
        closure({ [weak self] (request, error) in
            if let wSelf = self {
                if wSelf.processing.contains(token) {
                    wSelf.processing.remove(token)
                    token.completion(request, error)
                }
            }
        }, { [weak self] (operation) in
            if let wSelf = self {
                if wSelf.processing.contains(token) {
                    token.operation = operation
                }
            }
        }, { [weak self] (progress) in
            if let wSelf = self {
                if wSelf.processing.contains(token) {
                    if loading == .fullscreen || loading == .translucent {
                        wSelf.loadingView?.progress = CGFloat(progress)
                    } else if loading == .touchable {
                        wSelf.loadingBarView?.progress = CGFloat(progress)
                    }
                }
            }
        })
    }
    
    @objc open func run(_ closure: @escaping (@escaping AMCompletion)->(AMCancellable?), loading: AMLoadingType, key: String?) {
        run({ (completion, operation, _) in
            if let task = closure(completion) {
                operation(task)
            }
        }, completion: nil, loading: loading, key: key)
    }
    
    @objc open func run(_ closure: @escaping (@escaping AMCompletion)->(AMCancellable?), loading: AMLoadingType) {
        run(closure, loading: loading, key: nil)
    }
    
    private func process(error: Error, retry: (()->())?, loading: AMLoadingType) {
        if (error as NSError).code == NSURLErrorCancelled {
            return
        }
        if loading == .translucent {
            processTranslucentError(view, error, retry)
        } else if loading == .fullscreen {
            failedView = self.failedViewType.present(in: view, text: error.localizedDescription, retry: retry)
        } else if loading == .touchable {
            if failedBarView?.message() ?? "" != error.localizedDescription {
                failedBarView = failedBarViewType.present(in: view, message: error.localizedDescription)
            }
        }
    }
    
    private func increament(loading: AMLoadingType) {
        if loading == .translucent || loading == .fullscreen {
            if loadingCounter == 0 {
                loadingView = loadingViewType.present(in: view, animated: (loading == .translucent) && view.window != nil && failedView == nil)
            }
            if loading == .fullscreen && loadingView?.opaqueStyle == false {
                loadingView?.opaqueStyle = true
            }
            loadingCounter += 1
        } else if loading == .touchable {
            if touchableLoadingCounter == 0 {
                loadingBarView = loadingBarViewType.present(in: view, animated: true)
            }
            touchableLoadingCounter += 1
        }
    }
    
    private func decrement(loading: AMLoadingType) {
        if loading == .translucent || loading == .fullscreen {
            loadingCounter -= 1
            if loadingCounter == 0 {
                loadingView?.hide(true)
            }
        } else if loading == .touchable {
            touchableLoadingCounter -= 1
            if touchableLoadingCounter == 0 {
                loadingBarView?.hide(true)
            }
        }
    }
    
    @objc open func cancelOperations() {
        processing.forEach {
            self.cancel(token: $0)
        }
    }
    
    deinit {
        cancelOperations()
    }
}
