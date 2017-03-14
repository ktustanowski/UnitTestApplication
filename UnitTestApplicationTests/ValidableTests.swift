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
    
    func testThatIsValidWhenAllValidatorsAreValid() {
        //Given
        validableStruct.validators = [PositiveValidator(), PositiveValidator()]
        //When & Then
        XCTAssert(validableStruct.validate() == true, "Validation when all validators return true should also return true")
    }

    func testThatIsInvalidWhenNotAllValidatorsAreValid() {
        //Given
        validableStruct.validators = [PositiveValidator(), NegativeValidator()]
        //When & Then
        XCTAssert(validableStruct.validate() == false, "Validation when not all validators return true should return false")
    }

    func testThatIsValidWhenNoValidators() {
        //Given
        /* do nothing */
        //When & Then
        XCTAssert(validableStruct.validate() == true, "Validation when no validators should return true")
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
