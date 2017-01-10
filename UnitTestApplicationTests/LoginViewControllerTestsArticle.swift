//
//  LoginViewControllerTestsArticle.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 19.12.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import XCTest
@testable import UnitTestApplication

class LoginViewControllerTestsArticle: XCTestCase {
    
    var viewController: LoginViewController!

    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! LoginViewController
        viewController.view.layoutIfNeeded()
    }
    
    func testThatHidesLoginValidationLabelOnViewDidLoad() {
        viewController.viewDidLoad()
        
        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, 0, "Login validation label should be hidden on startup")
    }

    func testThatHidesPasswordValidationLabelOnViewDidLoad() {
        //Given
        /* no additional setup needed */
        //When
        viewController.viewDidLoad()
        //Then
        XCTAssertEqual(viewController.passwordValidationLabelHeightConstraint.constant, 0, "Password validation label should be hidden on startup")
    }

    func testThatLoginTextFieldValidatorsAreSetUpOnViewDidLoad() {
        viewController.viewDidLoad()
        
        XCTAssertEqual(viewController.loginTextField.validators?.count, 2, "Login text field should have 2 validators assigned")
        XCTAssert(viewController.loginTextField.validators?.first is IsEmptyValidator, "Login text field should have Is Empty Validator assigned")
        XCTAssert(viewController.loginTextField.validators?.last is IsEmailValidator, "Login text field should have Is Email Validator assigned")
    }
    
    func testThatLoginIsEmptyValidatorIsValidActionIsSetToHideValidationLabel() {
        //Given
        viewController.viewDidLoad()
        viewController.loginValidationLabelHeightConstraint.constant = 999
        //When
        viewController.loginTextField.validators?.first?.isValidAction?()
        //Then
        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, 0, "Is empty validator should hide validation label on success")
    }

    func testThatUserProviderSuccessClosureIsSetOnViewDidLoad() {
        //Given
        viewController.viewDidLoad()
        viewController.successLabel.text = nil
        viewController.signInButton.isHidden = true
        viewController.spinner.startAnimating()
        //When
        viewController.userProvider?.success?(User(login: "some@email.com", name: "John"))
        //Then
        XCTAssertEqual(viewController.successLabel.text, "Hello John!", "Should contain \"Hello John!\"")
        XCTAssertEqual(viewController.signInButton.isHidden, false)
        XCTAssertEqual(viewController.spinner.isAnimating, false)
    }
    
    func testThatUserProviderFailureClosureIsSetOnViewDidLoad() {
        //Given
        viewController.viewDidLoad()
        viewController.successLabel.text = nil
        viewController.signInButton.isHidden = true
        viewController.spinner.startAnimating()
        //When
        viewController.userProvider?.failure?(nil)
        //Then
        XCTAssertEqual(viewController.successLabel.text, "Couldn't login 😱", "Should contain \"Couldn't login 😱\"")
        XCTAssertEqual(viewController.signInButton.isHidden, false)
        XCTAssertEqual(viewController.spinner.isAnimating, false)
    }

}
