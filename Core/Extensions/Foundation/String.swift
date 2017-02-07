//
//  String.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

/**
    Appends two string, similar to web resource addressing.
    
    - parameter basePath: base string.
    - parameter pathComponent: string that will be appended.
 
    - returns: The new NSURL, with pathComponent appended to baseURL.
 */
public func / (basePath: String, pathComponent: String) -> String {
    return (basePath as NSString).stringByAppendingPathComponent(pathComponent)
}

public extension String {
    
    /**
     Returns a localized representation of the string.
     
     - parameter bundle: Bundle were to search for localization.
     - parameter arguments: Formatting arguments.
     */
    public func localized(bundle: NSBundle = NSBundle.mainBundle(), arguments: CVarArgType...) -> String {
        return String(format: NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: ""), arguments: arguments)
    }
    
    /**
     Returns the length of the string.
     
     - Complexity: O(1) if String's `Index` conforms to `RandomAccessIndexType`;
     O(N) otherwise.
     - note: It is a function and not a property because possible O(N) computation cost.
     - seealso: CharacterView.count
     */
    public func length() -> Int {
        return characters.count
    }
    
    /**
     Builds an NSURL from a string.
     */
    public var url: NSURL? {
        return NSURL(string: self)
    }
    
    /**
     Checks if the string has spaces or not.
     */
    public var hasSpaces: Bool {
        let whitespace = NSCharacterSet.whitespaceCharacterSet()
        let range = rangeOfCharacterFromSet(whitespace)
        return range != nil
    }
    
    /**
     Checks if a string is a valid email or not.
     
     - returns: True is self is a valid email
        or false if not.
    */
    public func isValidEmail() -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }
    
    /*
     String with leading and trailing whitespaces removed.
     */
    public var trimmed: String {
        return stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    /**
     Returns a new string in which all occurrences of a target string in a specified range of the String are replaced by another given string.
     
     - parameter target: The string to replace.
     - parameter with: The replacement.
     - parameter options: The comparing options. Default: LiteralSearch
     - parameter range: The range of the string to search.
     - seealso: stringByReplacingOccurrencesOfString().
     */
    public func replacing(target: String, with replacement: String, options: NSStringCompareOptions = .LiteralSearch, range: Range<Index>? = .None) -> String {
        return stringByReplacingOccurrencesOfString(target, withString: replacement, options: .LiteralSearch, range: range)
    }
    
    /**
     Returns a new string without whitespaces.
     */
    public var withoutWhiteSpaces: String {
        return replacing(" ", with: "")
    }
    
}
