//
//  CustomHeightNavigationBar.swift
//  Copyright (c) 2015-2016 Moch Xiao (http://mochxiao.com).
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

// See: http://www.emdentec.com/blog/2014/2/25/hacking-uinavigationbar
open class CustomHeightNavigationBar: UINavigationBar {
    fileprivate let defaultHeight: CGFloat = 44
    @IBInspectable
    open var customHeight: CGFloat = 88
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        commitInit()
    }
    
    fileprivate func commitInit() {
        transform = CGAffineTransform.identity
        transform = CGAffineTransform(translationX: 0, y: defaultHeight - customHeight)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height = customHeight
        return newSize
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        let classNamesToReposition = ["_UINavigationBarBackground"]
        for view in subviews {
            if classNamesToReposition.contains(NSStringFromClass(type(of: view))) {
                var newFrame = view.frame
                let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
                newFrame.origin.y = bounds.origin.y + customHeight - defaultHeight - statusBarHeight
                newFrame.size.height = bounds.size.height + statusBarHeight
                view.frame = newFrame
            }
        }
    }
}
