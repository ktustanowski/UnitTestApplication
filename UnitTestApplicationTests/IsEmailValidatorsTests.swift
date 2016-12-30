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
    
    func testThatWhenPassedValidEmailStringReturnsTrue() {
        //Given
        /* do nothing */
        //When & Then
        XCTAssert(validator.validate("thrawn@grand.admiral.emp") == true, "Validation of correct email string should return true")
    }

    func testThatWhenPassedInvalidEmailStringReturnsFalse() {
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

    func testThatWhenPassedNilReturnsFalse() {
        //Given
        /* do nothing */
        //When & Then
        XCTAssert(validator.validate(nil) == false, "Validation nil should return false")
    }

}

/* 3b.
 
 We could use the same approach as with previous validator. Mostly. When you look closer you will see that this validator is actually very simple
 
     input?) == true
 
    we have a dependency here - we rely on code from String extension. In this case first we should test this extension  (3a.)- and when we documented that it works well - we can test validator.
 
 struct IsEmailValidator: Validator {
 
 var isValidAction: (()->())?
 var isInvalidAction: (()->())?
 
 var isValid: ((String?) -> (Bool)) = { input in
 return input?) == true
 }
 
 init() { /* block generation of init with parameters */ }
 
 }
*/
