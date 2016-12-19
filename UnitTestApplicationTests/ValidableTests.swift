//
//  ValidableTests.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 26.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import XCTest
@testable import UnitTestApplication

class ValidableTests: XCTestCase {
    
    var validableStruct: ValidableStruct!
    
    override func setUp() {
        super.setUp()
        
        validableStruct = ValidableStruct()
    }
    
    func testThatCanAddValidators() {
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(NegativeValidator())
        
        XCTAssert(validableStruct.validators?.count == 3, "Should be able to add validators")
    }
    
    func testThatWhenAllValidatorsReturnTrueValidateAlsoReturnsTrue() {
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(PositiveValidator())
        
        XCTAssert(validableStruct.validate() == true, "Validation when all validators return true should also return true")
    }

    func testThatWhenNotAllValidatorsReturnTrueValidateReturnsFalse() {
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(NegativeValidator())
        validableStruct.validators?.append(PositiveValidator())
        
        XCTAssert(validableStruct.validate() == false, "Validation when not all validators return true should return false")
    }

    func testThatWhenNoValidatorsValidateReturnsTrue() {
        XCTAssert(validableStruct.validate() == true, "Validation when no validators should return true")
    }

    func testThatWhenAllValidatorsReturnTrueIsValidReturnsTrue() {
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(PositiveValidator())
        
        XCTAssert(validableStruct.isValid() == true, "IsValid when all validators return true should also return true")
    }
    
    func testThatWhenNotAllValidatorsReturnTrueIsValidReturnsFalse() {
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(NegativeValidator())
        validableStruct.validators?.append(PositiveValidator())
        
        XCTAssert(validableStruct.isValid() == false, "IsValid when not all validators return true should return false")
    }

    func testThatWhenNoValidatorsIsValidReturnsTrue() {
        XCTAssert(validableStruct.isValid() == true, "IsValid when no validators should return true")
    }

}

/*
 We can test whether adding validators works properly. Then we should make sure that validate() & isValid are using this validators to determine whether stuff is fine or not. 
 */

struct PositiveValidator: Validator {
    
    var isValidAction: (() -> ())?
    var isInvalidAction: (() -> ())?
    
    var isValid: ((String?) -> (Bool)) = { _ in return true }
    
}

struct NegativeValidator: Validator {
    
    var isValidAction: (() -> ())?
    var isInvalidAction: (() -> ())?
    
    var isValid: ((String?) -> (Bool)) = { _ in return false }
    
}

struct ValidableStruct: Validable {
    
    var validators: [Validator]? = []
    var stringToValidate: String? {
        return nil
    }
    
}
