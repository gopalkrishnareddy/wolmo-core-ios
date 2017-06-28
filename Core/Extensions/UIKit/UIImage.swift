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
     - parameter useScreenScale: Determines if the screen scale will be used when creating the image context. Default: true.
        Set to true if you want to make the size relative to the scale of the screen 
            (So the resized image looks the same relative size on all devices, you probably want this if you're showing the resized image).
        Set to false if you want the size to be actual pixels 
            (This is useful to generate a resized image of a particular size in real pixels to send to API regardless of the device screen scale).
     - parameter cornerRadius: The cornerRadius to be used. Any number lower or equal to zero will not add cornerRadius. Default: 0.0
     
     */
    
    public func resizedTo(_ wantedSize: CGSize, useScreenScale: Bool = true, cornerRadius: CGFloat = 0.0) -> UIImage {
        let newSize = size.resizedMaintainingRatio(wantedSize: wantedSize)
        let scale: CGFloat = useScreenScale ? 0.0 : 1.0
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
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
