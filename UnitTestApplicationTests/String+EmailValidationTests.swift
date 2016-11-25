//
//  String+EmailValidationTests.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 25.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import XCTest
@testable import UnitTestApplication


class String_EmailValidationTests: XCTestCase {
    
    func testThatReturnsTrueIfStringIsValidEmail() {
        XCTAssert("luke.starkiller@death.star.emp".isEmail == true, "Should return true for valid email")
    }

    func testThatReturnsFalseIfStringIsNotValidEmail() {
        XCTAssert("InvalidEmail".isEmail == false, "Should return false for string that are is valid email")
        XCTAssert("%%2@_dsa**sdd8dsa".isEmail == false, "Should return false for string that is not valid email")
        XCTAssert("".isEmail == false, "Should return false for string that are not valid email")
        XCTAssert("almost.email.string.com".isEmail == false, "Should return false for string that is not valid email")
        XCTAssert("@almost.email.string.com".isEmail == false, "Should return false for string that is not valid email")
        XCTAssert("almost@email@string.com".isEmail == false, "Should return false for string that is not valid email")
        XCTAssert("almost@email.string@".isEmail == false, "Should return false for string that is not valid email")
        XCTAssert("almost@email/string".isEmail == false, "Should return false for string that is not valid email")
    }

}

/* 
 3a.
 This is fairly simple. We just have to check if our extension properly indicates whether string contains email or not.
 
extension String {
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let isEmailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return isEmailPredicate.evaluate(with: self)
    }
}
*/
