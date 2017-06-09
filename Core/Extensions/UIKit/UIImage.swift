//
//  UIImage.swift
//  Core
//
//  Created by Nahuel Gladstein on 6/8/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit

public extension UIImage {
    
    func resizedImage(_ wantedSize: CGSize, cornerRadius: CGFloat = 0.0) -> UIImage {
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

private extension CGSize {

    func resizedMaintainingRatio(wantedSize: CGSize) -> CGSize {
        let widthFactor = width / wantedSize.width
        let heightFactor = height / wantedSize.height
        let resizeFactor = height > width ? heightFactor : widthFactor
        
        return CGSize(width: width / resizeFactor, height: height / resizeFactor)
    }
    
}
