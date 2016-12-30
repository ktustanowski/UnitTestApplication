//
//  IsEmptyValidatorTests.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 25.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import XCTest
@testable import UnitTestApplication

class IsEmptyValidatorTests: XCTestCase {
    
    var validator: IsEmptyValidator!
    
    override func setUp() {
        super.setUp()
        
        validator = IsEmptyValidator()
    }
    
    func testThatWhenPassedEmptyStringValidateReturnsFalse() {
        //Given
        /* do nothing */
        //When & Then
        XCTAssert(validator.validate("") == false, "Validation of empty string should return false")
    }

    func testThatWhenPassedNotEmptyStringValidateReturnsTrue() {
        //Given
        /* do nothing */
        //When & Then
        XCTAssert(validator.validate("SomeNotEmptyString") == true, "Validation of not empty string should return true")
    }

    func testThatWhenPassedNilValidateReturnsFalse() {
        //Given
        /* do nothing */
        //When & Then
        XCTAssert(validator.validate(nil) == false, "Validation of nil should return false")
    }

}

/* 2.
 This tests are much simpler because we have already tested base (Validator) for them. We know that when validation relies on isValid closure. We know that when valid / invalid closures with action will be called. So what is left? We just have to validate the only thing which custom validators should provide - isValid closure. Behavior that will be injected into success / failure closures will be tested where it will be actually used.
 */
//
//struct IsEmptyValidator: Validator {
//    
//    var isValidAction: (()->())?
//    var isInvalidAction: (()->())?
//    
//    var isValid: ((String?) -> (Bool)) = { input in
//        return input?.isEmpty == false
//    }
//    
//}
