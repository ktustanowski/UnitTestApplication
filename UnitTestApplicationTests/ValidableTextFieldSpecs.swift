//
//  ValidableTextField.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 26.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import XCTest
@testable import UnitTestApplication

class ValidableTextFieldSpecs: XCTestCase {
    
    let stringToValidate = "JustSomeString"
    var textField: ValidableTextField!
    
    override func setUp() {
        super.setUp()

        textField = ValidableTextField()
    }
        
    func testThatCanReturnCurrentTextAsStringToValidate() {
        textField.text = stringToValidate
        
        XCTAssert(textField.stringToValidate == stringToValidate, "Should return current text as string to validate")
    }
    
}
/* 
 Again dependencies - we would like to test whether this field returns correct value for validation but... we should test the validable protocol first because we have to make sure its working properly. Tough luck!
 */


//struct ValidatorStub: Validator {
//    
//    var isValidAction: (()->())?
//    var isInvalidAction: (()->())?
//    
//    var _isValid = false
//    
//    var isValid: ((String?) -> (Bool)) = { _ in
//        return self?._isValid
//    }
//
//    init() { }
//}

/*
class ValidableTextField: UITextField, Validable {
    
    var validators: [Validator]?
    var stringToValidate: String? {
        return text
    }
    
}
*/
