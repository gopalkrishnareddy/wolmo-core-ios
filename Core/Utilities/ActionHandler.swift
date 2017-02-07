//
//  ActionHandler.swift
//  Core
//
//  Created by Francisco Depascuali on 6/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

/**
 Closure-based handlers for UIControlEvents.
 */
public protocol ActionHandlerType {
    
    func setAction(events: UIControlEvents, _ action: (Self, UIEvent) -> Void)
    
}

extension ActionHandlerType where Self: UIControl {
    
    /**
     Sets the action passed by parameter to the specified events.
     
     - parameter events: Control events for which the action is registered. TouchUpInside is default.
     - parameter action: Closure that receives the UIControl and the UIEvent.
     
     - note: It retains any object used in the closure.
     */
    public func setAction(events: UIControlEvents = .TouchUpInside, _ action: (Self, UIEvent) -> Void) {
        let handler = ActionHandler(action: action)
        addTarget(handler, action: #selector(handler.action(_:forEvent:)), forControlEvents: events)
        setAssociatedObject(self, key: actionHandlerTypeAssociatedObjectKey, value: handler, policy: .OBJC_ASSOCIATION_RETAIN)
    }
    
}

extension UIControl: ActionHandlerType {}

private let actionHandlerTypeAssociatedObjectKey = UnsafeMutablePointer<Int8>.alloc(1)

private class ActionHandler<T>: NSObject {
    private let _action: ((T, UIEvent) -> Void)
    
    init(action: (T, UIEvent) -> Void) {
        _action = action
    }
    
    @objc func action(sender: UIControl, forEvent event: UIEvent) {
        if let sender = sender as? T {
            _action(sender, event)
        }
    }
    
}
