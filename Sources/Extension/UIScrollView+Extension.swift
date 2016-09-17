//
//  UIScrollView+Extension.swift
//  ExtensionKit
//
//  Created by Moch Xiao on 1/4/16.
//  Copyright © 2016 Moch Xiao (https://github.com/cuzv).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public extension UIScrollView {
    public var insetTop: CGFloat {
        get { return contentInset.top }
        set {
            var inset = contentInset
            inset.top = newValue
            contentInset = inset
        }
    }
    
    public var insetLeft: CGFloat {
        get { return contentInset.left }
        set {
            var inset = contentInset
            inset.left = newValue
            contentInset = inset
        }
    }
    
    public var insetBottom: CGFloat {
        get { return contentInset.bottom }
        set {
            var inset = contentInset
            inset.bottom = newValue
            contentInset = inset
        }
    }
    
    public var insetRight: CGFloat {
        get { return contentInset.right }
        set {
            var inset = contentInset
            inset.right = newValue
            contentInset = inset
        }
    }
    
    public var scrollIndicatorInsetTop: CGFloat {
        get { return  scrollIndicatorInsets.top }
        set {
            
            var inset = scrollIndicatorInsets
            inset.top = newValue
            scrollIndicatorInsets = inset
        }
    }
    
    public var scrollIndicatorInsetLeft: CGFloat {
        get { return scrollIndicatorInsets.left }
        set {
            var inset = scrollIndicatorInsets
            inset.left = newValue
            scrollIndicatorInsets = inset
        }
    }
    
    public var scrollIndicatorInsetBottom: CGFloat {
        get { return scrollIndicatorInsets.bottom }
        set {
            var inset = scrollIndicatorInsets
            inset.bottom = newValue
            scrollIndicatorInsets = inset
        }
    }
    
    public var scrollIndicatorInsetRight: CGFloat {
        get { return scrollIndicatorInsets.right }
        set {
            var inset = scrollIndicatorInsets
            inset.right = newValue
            scrollIndicatorInsets = inset
        }
    }
    
    public var contentOffsetX: CGFloat {
        get { return contentOffset.x }
        set {
            var offset = contentOffset
            offset.x = newValue
            contentOffset = offset
        }
    }
    
    public var contentOffsetY: CGFloat {
        get { return contentOffset.y }
        set {
            var offset = contentOffset
            offset.y = newValue
            contentOffset = offset
        }
    }
    
    public var contentSizeWidth: CGFloat {
        get { return contentSize.width }
        set {
            var size = contentSize
            size.width = newValue
            contentSize = size
        }
    }
    
    public var contentSizeHeight: CGFloat {
        get { return contentSize.height }
        set {
            var size = contentSize
            size.height = newValue
            contentSize = size
        }
    }
}

// MARK: - RefreshControl

public extension UIScrollView {
    private struct AssociationKey {
        private static var refreshControl: String = "UIScrollView.RefreshControl"
    }
    
    public var refreshContrl: UIRefreshControl? {
        get { return associatedObject(forKey: &AssociationKey.refreshControl) as? UIRefreshControl }
        set { associate(assignObject: newValue, forKey: &AssociationKey.refreshControl) }
    }
    
    public func addRefreshControl(withActionHandler handler: ((UIScrollView) -> ())) {
        if let _ = refreshContrl {
            return
        }
        
        let _refreshContrl = UIRefreshControl(frame: CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds), 64))
        addSubview(_refreshContrl)
        sendSubviewToBack(_refreshContrl)
        _refreshContrl.addControlEvents(.ValueChanged) { [weak self] (_) in
            if let this = self {
                if this.refreshControlEnabled {
                    handler(this)
                } else {
                    this.endRefreshing()
                }
            }
        }
        refreshContrl = _refreshContrl
    }
    
    public var refreshControlEnabled: Bool {
        get {
            if let refreshContrl = refreshContrl {
                return refreshContrl.enabled
            }
            return false
        }
        set {
            if let refreshContrl = refreshContrl {
                refreshContrl.enabled = newValue
                refreshContrl.alpha = newValue ? 1 : 0
            }
        }
    }
    
    public func beginRefreshing() {
        refreshContrl?.beginRefreshing()
    }
    
    public func endRefreshing() {
        refreshContrl?.endRefreshing()
    }
    
    public var refreshing: Bool {
        if let refreshContrl = refreshContrl {
            return refreshContrl.refreshing
        }
        return false
    }
}