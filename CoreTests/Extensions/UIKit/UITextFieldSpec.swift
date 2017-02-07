//
//  UITextFieldSpec.swift
//  Core
//
//  Created by Francisco Depascuali on 7/15/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Core

public class UITextFieldSpec: QuickSpec {
    
    override public func spec() {   //swiftlint:disable:this function_body_length

        describe("#next") {
            
            context("When there isn't next textfield associated") {
            
                it("should be nil") {
                    let textField = UITextField()
                    expect(textField.next).to(beNil())
                }
            }
            
            context("When there is a next textfield associated") {
                
                var textField: UITextField!
                var nextTextField: UITextField!
                
                beforeEach {
                    textField = UITextField()
                    nextTextField = UITextField()
                    textField.next = nextTextField
                }
                
                it("should return the next textfield") {
                    expect(textField.next).toNot(beNil())
                    expect(textField.next!).to(equal(nextTextField))
                }
                
                context("When the next textField is changed") {
                    
                    var otherTextField: UITextField!
                    
                    beforeEach {
                        otherTextField = UITextField()
                        textField.next = otherTextField
                    }
                    
                    it("should return the new textfield") {
                        expect(textField.next).toNot(beNil())
                        expect(textField.next!).to(equal(otherTextField))
                    }
                }
            }
            
        }
    }
}
