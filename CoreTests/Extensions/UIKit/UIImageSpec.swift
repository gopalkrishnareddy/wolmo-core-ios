//
//  UIImageSpec.swift
//  Core
//
//  Created by Nahuel Gladstein on 6/12/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Quick
import Nimble
import Core

public class UIImageSpec: QuickSpec {
    
    public func ratio(of image: UIImage) -> CGFloat {
        return image.size.width / image.size.height
    }
    
    public func hasMatchingWidth(sizeOne: CGSize, sizeTwo: CGSize) -> Bool {
        return sizeOne.width.rounded() == sizeTwo.width.rounded()
    }
    
    override public func spec() {
        
        var originalImage: UIImage!
        
        describe("#resizedTo") {
            
            beforeEach {
                let bundle = Bundle(for: type(of: self))
                originalImage = UIImage(named: "50by50", in: bundle, compatibleWith: nil)
                // The original size of the image is 50x50, so it's aspect ratio is 1:1
            }
            
            context("When the wanted size is bigger") {
                
                context("And has the same aspect ratio") {
                    
                    it("should return a resized image with the same aspect ratio and a size equal to the wanted size") {
                        let wantedSize = CGSize(width: 100, height: 100)
                        let resizedImage = originalImage.resizedTo(wantedSize)
                        expect(self.ratio(of: originalImage)).to(equal(self.ratio(of: resizedImage)))
                        expect(resizedImage.size).to(equal(wantedSize))
                    }
                }
                
                context("And has a different aspect ratio") {
                    
                    it("should return an image with the same aspect ratio and a size close to the wanted one") {
                        let wantedSize = CGSize(width: 250, height: 346)
                        let resizedImage = originalImage.resizedTo(wantedSize)
                        expect(self.ratio(of: originalImage)).to(equal(self.ratio(of: resizedImage)))
                        expect(self.hasMatchingWidth(sizeOne: resizedImage.size, sizeTwo: wantedSize)).to(beTrue())
                    }
                }
            }
            
            context("When the wanted size is smaller") {
                
                context("And has the same aspect ratio") {
                    
                    it("should return a resized image with the same aspect ratio and a size equal to the wanted size") {
                        let wantedSize = CGSize(width: 10, height: 10)
                        let resizedImage = originalImage.resizedTo(wantedSize)
                        expect(self.ratio(of: originalImage)).to(equal(self.ratio(of: resizedImage)))
                        expect(resizedImage.size).to(equal(wantedSize))
                    }
                }
                
                context("And has a different aspect ratio") {
                    
                    it("should return an image with the same aspect ratio and a size close to the wanted one") {
                        let wantedSize = CGSize(width: 15, height: 29)
                        let resizedImage = originalImage.resizedTo(wantedSize)
                        expect(self.ratio(of: originalImage)).to(equal(self.ratio(of: resizedImage)))
                        expect(self.hasMatchingWidth(sizeOne: resizedImage.size, sizeTwo: wantedSize)).to(beTrue())
                    }
                }
            }
        }
    }
}
