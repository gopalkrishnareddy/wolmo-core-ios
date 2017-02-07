//
//  UIView.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//
import UIKit

public struct Border {
    
    let height: Float
    let color: UIColor
    
    init(height: Float, color: UIColor) {
        self.height = height
        self.color = color
    }
}

public enum ViewPositioning {
    case Back
    case Front
}

extension UIView {
    
    /**
     Adds a border to the top of the view.
     
     - parameter border: Models the border to be added
     - parameter offset: The offset for the width of the border related to self.
     The width of the border will be view.width - offset.
     
     Note: By default, the border will have the width of the view.
     */
    public func topBorder(border: Border, offset: CGFloat = 0) {
        let borderView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width - offset, height: CGFloat(border.height)))
        borderView.backgroundColor = border.color
        addSubview(borderView)
    }
    
    /**
     Adds a border to the bottom of the view.
     
     - parameter border: Models the border to be added
     - parameter offset: The offset for the width of the border related to self.
     The width of the border will be view.width - offset.
     
     Note: By default, the border will have the width of the view.
     */
    public func bottomBorder(border: Border, offset: CGFloat = 0) {
        let borderView = UIView(frame: CGRect(x: 0, y: bounds.height - CGFloat(border.height), width: bounds.width - offset,
            height: CGFloat(border.height)))
        borderView.backgroundColor = border.color
        addSubview(borderView)
    }
    
    /**
     Adds a border to the left of the view.
     
     - parameter border: Models the border to be added
     - parameter offset: The offset for the height of the border related to self.
     The height of the border will be view.height - offset.
     
     Note: By default, the border will have the height of the view.
     */
    public func leftBorder(border: Border, offset: CGFloat = 0) {
        let borderView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(border.height), height: bounds.height - offset))
        borderView.backgroundColor = border.color
        addSubview(borderView)
    }
    
    /**
     Adds a border to the right of the view.
     
     - parameter border: Models the border to be added
     - parameter offset: The offset for the height of the border related to self.
     The width of the border will be view.height - offset.
     
     Note: By default, the border will have the height of the view.
     */
    public func rightBorder(border: Border, offset: CGFloat = 0) {
        let borderView = UIView(frame: CGRect(x: bounds.width - CGFloat(border.height), y: 0, width: CGFloat(border.height),
            height: bounds.height - offset))
        borderView.backgroundColor = border.color
        addSubview(borderView)
    }
    
    /**
     Loads the view into the specified containerView.
     
     - warning: It must be done after self's view is loaded.
     - note: It uses constraints to determine the size, so the frame isn't needed. Because of this,
            `loadInto()` can be used in viewDidLoad().
     
     - Parameters:
        - containerView: The container view.
        - viewPositioning: Back or Front. Default: Front.
        - leadingOffset: Distance offset between the container view's leading and self's leading.
            Default: 0.
        - trailingOffset: Distance offset between the self's trailing and container view's trailing.
            Default: 0.
        - topOffset: Distance offset between the container view's top and self's top.
            Default: 0.
        - bottomOffset: Distance offset between the self's bottom and container view's bottom.
            Default: 0.
     */
    public func loadInto(containerView: UIView,
                         viewPositioning: ViewPositioning = .Front,
                         leadingOffset: CGFloat = 0.0,
                         trailingOffset: CGFloat = 0.0,
                         topOffset: CGFloat = 0.0,
                         bottomOffset: CGFloat = 0.0) {
        containerView.addSubview(self)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 9.0, *) {
            topAnchor.constraintEqualToAnchor(containerView.topAnchor, constant: topOffset).active = true
            containerView.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: bottomOffset).active = true
            leadingAnchor.constraintEqualToAnchor(containerView.leadingAnchor, constant: leadingOffset).active = true
            containerView.trailingAnchor.constraintEqualToAnchor(trailingAnchor, constant: trailingOffset).active = true
        } else {
            addConstraintsiOS8(containerView, leadingOffset, trailingOffset, topOffset, bottomOffset)
        }
        
        if case viewPositioning = ViewPositioning.Back {
            containerView.sendSubviewToBack(self)
        }
    }

}

private extension UIView {
    
    private func addConstraintsiOS8(containerView: UIView,
                                    _ leadingOffset: CGFloat = 0.0,
                                    _ trailingOffset: CGFloat = 0.0,
                                    _ topOffset: CGFloat = 0.0,
                                    _ bottomOffset: CGFloat = 0.0) {
        addConstraint(NSLayoutConstraint(item: self, attribute: .Top,
            relatedBy: .Equal, toItem: containerView, attribute: .Top,
            multiplier: 1.0, constant: topOffset))
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .Bottom,
            relatedBy: .Equal, toItem: self, attribute: .Bottom,
            multiplier: 1.0, constant: bottomOffset))
        addConstraint(NSLayoutConstraint(item: self, attribute: .Leading,
            relatedBy: .Equal, toItem: containerView, attribute: .Leading,
            multiplier: 1.0, constant: leadingOffset))
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .Trailing,
            relatedBy: .Equal, toItem: self, attribute: .Trailing,
            multiplier: 1.0, constant: trailingOffset))
    }
    
}
