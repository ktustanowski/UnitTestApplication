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
    
    func testThatCanReturnCurrentTextAsStringToValidate() {
        //Given
        let textField = ValidableTextField()
        textField.text = "just some random text"
        //When & Then
        XCTAssert(textField.stringToValidate == "just some random text", "Should return current text as string to validate")
    }
    
}
