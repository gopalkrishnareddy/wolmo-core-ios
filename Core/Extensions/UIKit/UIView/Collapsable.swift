//
//  Collapsable.swift
//  Core
//
//  Created by Francisco Depascuali on 7/6/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

/**
 Represents a collapsable element.
 */
public protocol Collapsable {
    
    /**
     Collapse self.
     
     - Parameter animated: Indicates if the collapse should be animated.
     - Parameter animationDuration: The animationDuration of the collapse.
     */
    func collapse(animated: Bool, animationDuration: NSTimeInterval)
    
    /**
     Uncollapse self.
     
     - Parameter animated: Indicates if the collapse should be animated.
     - Parameter animationDuration: The animationDuration of the collapse.
     */
    func uncollapse(animated: Bool, animationDuration: NSTimeInterval)
    
}

/**
 Represents a vertical collapsable view, which when collapsed not only isn't shown but isn't considered in vertical layout.
 */
extension Collapsable where Self: UIView {
    
    /**
     Collapse a view by adding/modifying constraint height. It works also if they view already has a constraint.
     
     - Warning: It is intended to be used to collapse a view *without* subviews.
     
     - Parameters:
        - animated: Indicates if the collapse should be animated.
        - animationDuration: The animationDuration of the collapse.
     */
    public func collapse(animated: Bool = true, animationDuration: NSTimeInterval = 1) {
        if let previousHeightConstraint = previousHeightConstraint {
            // We save the previous height value
            setAssociatedObject(self, key: &CollapsableHeightConstraintKey, value: previousHeightConstraint.constant, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            previousHeightConstraint.constant = 0
        } else {
            // We create a new height constraint with constant 0
            let zeroheightConstraint: NSLayoutConstraint
            if #available(iOS 9.0, *) {
                zeroheightConstraint = heightAnchor.constraintEqualToConstant(0)
            } else {
                zeroheightConstraint = NSLayoutConstraint(item: self,
                                                          attribute: .Height,
                                                          relatedBy: .Equal,
                                                          toItem: .None,
                                                          attribute: .Height,
                                                          multiplier: 0.0,
                                                          constant: 0.0)
            }
            zeroheightConstraint.active = true
        }
        
        updateView(animated, animationDuration: animationDuration)
    }
    
    /**
     Uncollapse a view by removing/modifying constraint height. It works also if they view already has a constraint.
     
     - Warning: It is intended to be used to uncollapse a view *without* subviews.
     
     - Parameters:
        - animated: Indicates if the collapse should be animated.
        - animationDuration: The animationDuration of the collapse.
     */
    public func uncollapse(animated: Bool = true, animationDuration: NSTimeInterval = 1) {
        if let heightConstraint = previousHeightConstraint {
            // If we have a previous height, it means that before collapsing it had another height constraint.
            if let previousHeight: CGFloat = getAssociatedObject(self, key: &CollapsableHeightConstraintKey) {
                heightConstraint.constant = previousHeight
            } else {
                // We desactive the height constraint added because it didn't have a height before collapsing.
                heightConstraint.active = false
            }
        }
        
        updateView(animated, animationDuration: animationDuration)
    }
    
    private func updateView(animated: Bool, animationDuration: NSTimeInterval) {
        setNeedsLayout()
        
        if animated {
            UIView.animateWithDuration(animationDuration) {
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
        }
    }
}

private var CollapsableHeightConstraintKey: UInt8 = 0

private extension UIView {
    
    private var previousHeightConstraint: NSLayoutConstraint? {
        return constraints.filterFirst { $0.firstAttribute == .Height }
    }
    
}
