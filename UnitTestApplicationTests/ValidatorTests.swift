//
//  ValiatorTests.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 22.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import XCTest
@testable import UnitTestApplication

class ValidatorTests: XCTestCase {
    
    var invalidActionWasCalled = false
    var validActionWasCalled = false
    var validator: ValidatorStruct!
    
    override func setUp() {
        super.setUp()
        
        validator = ValidatorStruct(isValidAction: { [weak self] in
            self?.validActionWasCalled = true
        }, isInvalidAction: { [weak self] in
            self?.invalidActionWasCalled = true
        }, isValid: { string in
            return string == "ValidString"
        })
    }
    
    func testThatReturnsFalseWhenIsValidClosureReturnsFalseAndCallsIsInvalidAction() {
        //Given
        /* is done in setup */
        //When
        let isValid = validator.validate("InvalidString")
        //Then
        XCTAssert(isValid == false, "Validator should return false when validation failed")
        XCTAssert(validActionWasCalled == false, "Validator shouldn't call valid action")
        XCTAssert(invalidActionWasCalled == true, "Validator should call invalid action")
    }
    
    func testThatReturnsTrueWhenIsValidClosureReturnsTrueAndCallsIsValidAction() {
        //Given
        /* is done in setup */
        //When
        let isValid = validator.validate("ValidString")
        //Then
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
