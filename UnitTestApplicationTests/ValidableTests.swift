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
    
    func testThatWhenAllValidatorsReturnTrueValidateAlsoReturnsTrue() {
        //Given
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(PositiveValidator())
        //When & Then
        XCTAssert(validableStruct.validate() == true, "Validation when all validators return true should also return true")
    }

    func testThatWhenNotAllValidatorsReturnTrueValidateReturnsFalse() {
        //Given
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(NegativeValidator())
        validableStruct.validators?.append(PositiveValidator())
        //When & Then
        XCTAssert(validableStruct.validate() == false, "Validation when not all validators return true should return false")
    }

    func testThatWhenNoValidatorsValidateReturnsTrue() {
        //Given
        /* do nothing */
        //When & Then
        XCTAssert(validableStruct.validate() == true, "Validation when no validators should return true")
    }

    func testThatWhenAllValidatorsReturnTrueIsValidReturnsTrue() {
        //Given
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(PositiveValidator())
        //When & Then
        XCTAssert(validableStruct.isValid() == true, "IsValid when all validators return true should also return true")
    }
    
    func testThatWhenNotAllValidatorsReturnTrueIsValidReturnsFalse() {
        //Given
        validableStruct.validators?.append(PositiveValidator())
        validableStruct.validators?.append(NegativeValidator())
        validableStruct.validators?.append(PositiveValidator())
        //When & Then
        XCTAssert(validableStruct.isValid() == false, "IsValid when not all validators return true should return false")
    }

    func testThatWhenNoValidatorsIsValidReturnsTrue() {
        //Given
        /* do nothing */
        //When & Then
        XCTAssert(validableStruct.isValid() == true, "IsValid when no validators should return true")
    }

}

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
