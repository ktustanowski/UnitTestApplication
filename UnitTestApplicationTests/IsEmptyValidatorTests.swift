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
