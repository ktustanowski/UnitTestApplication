//
//  LoginViewControllerTests.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 15.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import XCTest
@testable import UnitTestApplication

class LoginViewControllerTests: XCTestCase {
    
    var viewController: LoginViewController!
    var userDataProviderStub: UserDataProviderStub? {
        return viewController.userProvider as? UserDataProviderStub
    }
    
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! LoginViewController
        viewController.userProvider = UserDataProviderStub() /* Make sure we won't make api calls during the tests */
        viewController.loadViewIfNeeded()
    }
    
    func testThatHidesLoginValidationLabelOnViewDidLoad() {
        viewController.viewDidLoad()
        
        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, 0, "Login validation label should be hidden on startup")
    }

    func testThatHidesPasswordValidationLabelOnViewDidLoad() {
        viewController.viewDidLoad()
        
        XCTAssertEqual(viewController.passwordValidationLabelHeightConstraint.constant, 0, "Password validation label should be hidden on startup")
    }
    
    func testThatLoginIsEmptyValidatorIsSetOnViewDidLoad() {
        //Given
        viewController.viewDidLoad()
        viewController.loginValidationLabel.text = nil
        viewController.loginValidationLabelHeightConstraint.constant = 0
        //When
        viewController.signIn()
        //Then
        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, viewController.labelDefaultHeight, "Is empty validator should show validation label on failure")
        XCTAssertEqual(viewController.loginValidationLabel.text, "Login cannot be empty", "Is empty validator should show validation text on failure")
    }
    
    func testThatLoginIsEmailValidatorIsSetOnViewDidLoad() {
        //Given
        viewController.viewDidLoad()
        viewController.loginValidationLabel.text = nil
        viewController.loginValidationLabelHeightConstraint.constant = 0
        viewController.loginTextField.text = "incorrect_email"
        //When
        viewController.signIn()
        //Then
        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, viewController.labelDefaultHeight, "Is empty validator should show validation label on failure")
        XCTAssertEqual(viewController.loginValidationLabel.text, "Login must be valid email", "Is empty validator should show validation text on failure")
    }

    func testThatPasswordIsEmptyValidatorIsSetOnViewDidLoad() {
        //Given
        viewController.viewDidLoad()
        viewController.passwordValidationLabel.text = nil
        viewController.passwordValidationLabelHeightConstraint.constant = 0
        //When
        viewController.signIn()
        //Then
        XCTAssertEqual(viewController.passwordValidationLabelHeightConstraint.constant, viewController.labelDefaultHeight, "Is empty validator should show validation label on failure")
        XCTAssertEqual(viewController.passwordValidationLabel.text, "Password cannot be empty", "Is empty validator should show validation text on failure")
    }

    func testThatInputIsValidReturnsTrueWhenBothLoginAndPasswordAreValid() {
        //Given
        viewController.loginTextField.text = "kyle.katarn@ravensclaw.com"
        viewController.passwordTextField.text = "0123456"
        //When & Then
        XCTAssertEqual(viewController.inputIsValid(), true, "When both login and password are valid should return true")
    }

    func testThatInputIsValidReturnsFalseWhenOnlyLoginIsValid() {
        //Given
        viewController.loginTextField.text = "kyle.katarn@ravensclaw.com"
        //When & Then
        XCTAssertEqual(viewController.inputIsValid(), false, "When only login is valid should return false")
    }

    func testThatInputIsValidReturnsFalseWhenOnlyPasswordIsValid() {
        //Given
        viewController.passwordTextField.text = "0123456"
        //When & Then
        XCTAssertEqual(viewController.inputIsValid(), false, "When only password is valid should return false")
    }

    func testThatInputIsValidReturnsFalseWhenBothLoginAndPasswordAreInvalid() {
        //Given
        /* do nothing */
        //When & Then
        XCTAssertEqual(viewController.inputIsValid(), false, "When both login and password are invalid should return false")
    }
    
    func testThatWhenInputIsValidBeforeLoginSpinnerStartAnimating() {
        //Given
        viewController.loginTextField.text = "kyle.katarn@ravensclaw.com"
        viewController.passwordTextField.text = "0123456"
        viewController.successLabel.text = "some text"
        setupBeforeSigninInState()
        //When
        viewController.signIn()
        //Then
        XCTAssertNil(viewController.successLabel.text, "Success label text should be nil")
        XCTAssertEqual(viewController.signInButton.isHidden, true)
        XCTAssertEqual(viewController.spinner.isAnimating, true)
    }
    
    func testThatBeforeSigningInUserProviderIsCreated() {
        //Given
        viewController.loginTextField.text = "kyle.katarn@ravensclaw.com"
        viewController.passwordTextField.text = "0123456"
        viewController.successLabel.text = nil
        setupBeforeSigninInState()
        viewController.userProvider = nil /* unstub this only for this test */
        //When
        viewController.signIn()
        //Then
        XCTAssertNotNil(viewController.userProvider , "Should create provider when signing in user")
    }

    func testThatWhenInputIsValidLoginUserAfterTappingSignInButtonWhenNoError() {
        //Given
        viewController.loginTextField.text = "kyle.katarn@ravensclaw.com"
        viewController.passwordTextField.text = "0123456"
        viewController.successLabel.text = nil
        setupBeforeSigninInState()
        //When
        userDataProviderStub?.usernameToReturn = "John"
        viewController.signIn()
        //Then
        XCTAssertEqual(viewController.successLabel.text, "Hello John!", "Should be equal Hello John!")
        XCTAssertEqual(viewController.signInButton.isHidden, false)
        XCTAssertEqual(viewController.spinner.isAnimating, false)
    }
    
    func testThatWhenInputIsValidDoNotLoginUserAfterTappingSignInButtonWhenError() {
        //Given
        viewController.loginTextField.text = "kyle.katarn@ravensclaw.com"
        viewController.passwordTextField.text = "0123456"
        viewController.successLabel.text = nil
        setupBeforeSigninInState()
        //When
        userDataProviderStub?.errorToReturn = NSError(domain: "", code: 0, userInfo: [:])
        viewController.signIn()
        //Then
        XCTAssertEqual(viewController.successLabel.text, "Couldn't login 😱", "Should be equal Couldn't login 😱")
        XCTAssertEqual(viewController.signInButton.isHidden, false)
        XCTAssertEqual(viewController.spinner.isAnimating, false)
    }
    
    func testThatWhenInputIsInvalidNothingHappensAfterTappingSignInButton() {
        //Given
        viewController.loginTextField.text = nil
        viewController.passwordTextField.text = nil
        viewController.successLabel.text = "some text"
        setupBeforeSigninInState()
        //When
        viewController.signIn()
        //Then
        XCTAssertEqual(viewController.successLabel.text, "some text", "Should contain some text")
        XCTAssertEqual(viewController.signInButton.isHidden, false)
        XCTAssertEqual(viewController.spinner.isAnimating, false)
    }
    
    func testThatLoginViewControllerIsLoginTextFieldDlegate() {
        //Given
        /* do nothing */
        //When
        /* do nothing */
        //Then
        XCTAssertEqual(viewController.loginTextField.delegate as? UIViewController, viewController, "LoginViewController should be text field delegate")
    }
    
    func testThatLoginViewControllerIsPasswordTextFieldDlegate() {
        //Given
        /* do nothing */
        //When
        /* do nothing */
        //Then
        XCTAssertEqual(viewController.passwordTextField.delegate as? UIViewController, viewController, "LoginViewController should be text field delegate")
    }

    
    func testThatWhenUserEndEditingLoginTextFieldValidationIsCalled() {
        //Given
        /* do nothing*/
        //When
        viewController.textFieldDidEndEditing(viewController.loginTextField)
        //Then
        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, viewController.labelDefaultHeight, "Is empty validator should show validation label on failure")
        XCTAssertEqual(viewController.loginValidationLabel.text, "Login cannot be empty", "Is empty validator should show validation text on failure")
    }
    
    func testThatWhenUserEndEditingPasswordTextFieldValidationIsCalled() {
        //Given
        /* do nothing*/
        //When
        viewController.textFieldDidEndEditing(viewController.passwordTextField)
        //Then
        XCTAssertEqual(viewController.passwordValidationLabelHeightConstraint.constant, viewController.labelDefaultHeight, "Is empty validator should show validation label on failure")
        XCTAssertEqual(viewController.passwordValidationLabel.text, "Password cannot be empty", "Is empty validator should show validation text on failure")
    }
    
    func testThatWhenUserEndEditingRegulartextFieldValidationIsNotCalled() {
        //Given
        /* do nothing*/
        //When
        viewController.textFieldDidEndEditing(UITextField())
        //Then
        XCTAssertEqual(viewController.passwordValidationLabelHeightConstraint.constant, 0, "Shouldn't show validation label")
        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, 0, "Shouldn't show validation label")
    }

}

extension LoginViewControllerTests {
    
    func simulate(inputIsValid isValid: Bool) {
        viewController.loginTextField.text = isValid ? "kyle.katarn@ravensclaw.com" : ""
        viewController.passwordTextField.text = isValid ? "0123456" : ""
    }
    
    func setupBeforeSigninInState() {
        viewController.signInButton.isHidden = false
        viewController.spinner.stopAnimating()
    }

}

class UserDataProviderStub: UserDataProvider {
    
    /**
     When set and error is nil - success closure is called
     */
    var usernameToReturn: String?
    /**
     When set failure closure is called
     */
    var errorToReturn: NSError?
    
    override func load(forLogin login: String, password: String) {
        if let errorToReturn = errorToReturn {
            failure?(errorToReturn)
            return
        }
        
        if let username = usernameToReturn {
            success?(User(login: login, name: username))
        }
    }
}
