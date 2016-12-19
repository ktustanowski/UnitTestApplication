//
//  ValiatorTests.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 22.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import XCTest
@testable import UnitTestApplication

class ValiatorTests: XCTestCase {
    
    func testThatReturnsFalseWhenIsValidClosureReturnsFalse() {
        var invalidActionWasCalled = false
        var validActionWasCalled = false
        
        let validator = ValidatorStruct(isValidAction: {
            validActionWasCalled = true
        }, isInvalidAction: {
            invalidActionWasCalled = true
        }, isValid: { string in
            return string == "ValidString"
        })
        
        let isValid = validator.validate("InvalidString")
        
        XCTAssert(isValid == false, "Validator should return false when validation failed")
        XCTAssert(validActionWasCalled == false, "Validator shouldn't call valid action")
        XCTAssert(invalidActionWasCalled == true, "Validator should call invalid action")
    }
    
    func testThatReturnsTrueWhenIsValidClosureReturnsTrue() {
        var invalidActionWasCalled = false
        var validActionWasCalled = false
        
        let validator = ValidatorStruct(isValidAction: {
            validActionWasCalled = true
        }, isInvalidAction: {
            invalidActionWasCalled = true
        }, isValid: { string in
            return string == "ValidString"
        })
        
        let isValid = validator.validate("ValidString")
        
        XCTAssert(isValid == true, "Validator should return true when validation succeeded")
        XCTAssert(validActionWasCalled == true, "Validator shouldn't call valid action")
        XCTAssert(invalidActionWasCalled == false, "Validator should call invalid action")
    }
    
}

struct ValidatorStruct: Validator {
    
    var isValidAction: (()->())?
    var isInvalidAction: (()->())?
    
    var isValid: ((String?) -> (Bool))

}



/* 1.
 
 In this document I won't evangelize on subject "why you should test" - its purely for people who want to learn practical unit testing.
 I read blogs, books, attend meetups but mostly I was just writing unit tests. Lots and lots of unit tests.
 
 Ok so let's do some real-world testing. Validator protocol seems like a good starting point. No views, no async stuff just strightforward blackbox input / output testing.
 What is important - tests documents your code. When someone new join the project and need to do some changes in class A then tests for class A should be starting point. Should be always up-to-date documentation, because its executable, and should answer for question - what this class does. How its constructed. How it can be used. To make it happen you have to test all paths that application can encounter - not only the obvious happy / negative ones
 
 Every `if` means more tests. Every guard means that there is at least two possible paths runnig through this code. So to summarize:
 
 2. testThatReturnsFalseWhenIsValidClosureReturnsFalse
 3. testThatReturnsTrueWhenIsValidClosureReturnsTrue
 
 */

/* It's not that bad - right? More gets better.
 
 */

//func validate(_ input: String?) -> Bool{
//    let isValid = self.isValid(input) == true
//    
//    if isValid {
//        isValidAction?()
//    } else {
//        isInvalidAction?()
//    }
//    
//    return isValid
//}
