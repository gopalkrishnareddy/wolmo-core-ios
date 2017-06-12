//
//  UIImage.swift
//  Core
//
//  Created by Nahuel Gladstein on 6/8/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /**
     Returns a resized copy of the image maintaining it's aspect ratio, with cornerRadius if used.
     
     - parameter wantedSize: The wanted size to fit the new image in.
        Note that the size of the resulting image will be the closest size to the one specified that maintains the aspect ratio of the original image.
     - parameter cornerRadius: The cornerRadius to be used. Any number lower or equal to zero will not add cornerRadius. Default: 0.0
     
     */
    
    public func resizedTo(_ wantedSize: CGSize, cornerRadius: CGFloat = 0.0) -> UIImage {
        let newSize = size.resizedMaintainingRatio(wantedSize: wantedSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        if cornerRadius > 0 {
            let path = UIBezierPath(
                        roundedRect:CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height),
                        cornerRadius: cornerRadius)
            path.addClip()
        }
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }

}

fileprivate extension CGSize {

    /**
     Returns a resized copy of the size maintaining it's aspect ratio.
     
     - parameter wantedSize: The wanted new size to fit.
     Note that the size of the resulting CGSize will be the closest to the one specified that maintains the aspect ratio of the original.
     
     */
    
    
    fileprivate func resizedMaintainingRatio(wantedSize: CGSize) -> CGSize {
        let widthFactor = width / wantedSize.width
        let heightFactor = height / wantedSize.height
        let resizeFactor = height > width ? heightFactor : widthFactor
        
        return CGSize(width: width / resizeFactor, height: height / resizeFactor)
    }
    
}
