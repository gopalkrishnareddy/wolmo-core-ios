//
//  RawRepresentable.swift
//  Core
//
//  Created by Francisco Depascuali on 7/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Core

private enum IntRepresentable: Int {
    case Zero
    case One
    case Two
    case Three
}

public class RawRepresentableSpec: QuickSpec {
    
    override public func spec() {   //swiftlint:disable:this function_body_length
        
        describe("#allValues") {
            
            context("When specifying an existent initial value") {
                
                it("should return all values starting at the initial value") {
                    let values = Array(IntRepresentable.allValues(startingAt: .One))
                    expect(values).to(equal([.One, .Two, .Three]))
                }
                
                context("When the value is the first one") {
                    
                    it("should return all values") {
                        let values = Array(IntRepresentable.allValues(startingAt: .Zero))
                        expect(values).to(equal([.Zero, .One, .Two, .Three]))
                    }
                }
                
                context("When the value is the last one") {
                    
                    it("should return the last value") {
                        let values = Array(IntRepresentable.allValues(startingAt: .Three))
                        expect(values).to(equal([.Three]))
                    }
                }

            }
        }
        
        describe("#count") {
            
            context("When specifying an initial value") {
                
                it("should return the count of all the values starting at the initial value") {
                    expect(IntRepresentable.count(startingAt: .One)).to(equal(3))
                }
                
                context("When the value is the first one") {
                    
                    it("should return the count of all the values") {
                        expect(IntRepresentable.count(startingAt: .Zero)).to(equal(4))
                    }
                }
                
                context("When the value is the last one") {
                    
                    it("should return one") {
                        expect(IntRepresentable.count(startingAt: .Three)).to(equal(1))
                    }
                }
            }
        }
    }
    
}

public class RawRepresentableGeneratorSpec: QuickSpec {
    
    override public func spec() {
        
        var generator: RawRepresentableGenerator<Int, IntRepresentable>!
        
        beforeEach {
            generator = RawRepresentableGenerator(startingAt: .Zero) { $0 }
        }
        
        describe("#next") {
            
            context("When using the identity function as generator") {
                
                it("should return always the same element") {
                    expect(generator.next()).to(equal(IntRepresentable.Zero))
                    expect(generator.next()).to(equal(IntRepresentable.Zero))
                }
            }
            
            context("When adding one in the generator") {
                
                beforeEach {
                    generator = RawRepresentableGenerator(startingAt: .Zero) { IntRepresentable(rawValue: $0.rawValue + 1) }
                }
                
                it("should return the following element") {
                    expect(generator.next()).to(equal(IntRepresentable.Zero))
                    expect(generator.next()).to(equal(IntRepresentable.One))
                }
                
            }
        }
    }
}
