//
//  IsEmailValidatorsTests.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 25.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import XCTest
@testable import UnitTestApplication

class IsEmailValidatorsTests: XCTestCase {
    
    var validator: IsEmailValidator!
    
    override func setUp() {
        super.setUp()
        
        validator = IsEmailValidator()
    }
    
    func testThatWhenEmailStringIsValidValidationPasses() {
        //Given
        /* do nothing */
        //When & Then
        XCTAssert(validator.validate("thrawn@grand.admiral.emp") == true, "Validation of correct email string should return true")
    }

    func testThatWhenEmailStringIsInvalidValidationFails() {
        //Given
        /* do nothing */
        //When & Then
        XCTAssert(validator.validate("not_valid_email_string") == false, "Validation of incorrect email string should return false")
        XCTAssert(validator.validate("%%2@_dsa**sdd8dsa") == false, "Validation of incorrect email string should return false")
        XCTAssert(validator.validate("") == false, "Validation of incorrect email string should return false")
        XCTAssert(validator.validate("almost.email.string.com") == false, "Validation of incorrect email string should return false")
        XCTAssert(validator.validate("@almost.email.string.com") == false, "Validation of incorrect email string should return false")
        XCTAssert(validator.validate("almost@email@string.com") == false, "Validation of incorrect email string should return false")
        XCTAssert(validator.validate("almost@email.string@") == false, "Validation of incorrect email string should return false")
        XCTAssert(validator.validate("almost@email/string") == false, "Validation of incorrect email string should return false")

    }

    func testThatWhenNilValidationFails() {
        //Given
        /* do nothing */
        //When & Then
        XCTAssert(validator.validate(nil) == false, "Validation nil should return false")
    }

}
