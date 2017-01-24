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
        viewController.view.layoutIfNeeded()
    }
    
    func testThatHidesLoginValidationLabelOnViewDidLoad() {
        viewController.viewDidLoad()
        
        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, 0, "Login validation label should be hidden on startup")
    }

    func testThatHidesPasswordValidationLabelOnViewDidLoad() {
        viewController.viewDidLoad()
        
        XCTAssertEqual(viewController.passwordValidationLabelHeightConstraint.constant, 0, "Password validation label should be hidden on startup")
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
    
    func testThatLoginTextFieldValidatorsAreSetUpOnViewDidLoad() {
        viewController.viewDidLoad()
        
        XCTAssertEqual(viewController.loginTextField.validators?.count, 2, "Login text field should have 2 validators assigned")
        XCTAssert(viewController.loginTextField.validators?.first is IsEmptyValidator, "Login text field should have Is Empty Validator assigned")
        XCTAssert(viewController.loginTextField.validators?.last is IsEmailValidator, "Login text field should have Is Email Validator assigned")
    }

    func testThatLoginIsEmptyValidatorIsValidActionIsSetToHideValidationLabel() {
        viewController.viewDidLoad()
        viewController.loginValidationLabelHeightConstraint.constant = 999
        
        viewController.loginTextField.validators?.first?.isValidAction?()
        
        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, 0, "Is empty validator should hide validation label on success")
    }

    func testThatLoginIsEmptyValidatorIsValidActionIsSetToShowValidationLabelWithValidationText() {
        viewController.viewDidLoad()
        viewController.loginValidationLabel.text = nil
        viewController.loginValidationLabelHeightConstraint.constant = 0
        
        viewController.loginTextField.validators?.first?.isInvalidAction?()
        
        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, viewController.labelDefaultHeight, "Is empty validator should show validation label on failure")
        XCTAssertEqual(viewController.loginValidationLabel.text, "Login cannot be empty", "Is empty validator should show validation text on failure")
    }

    func testThatLoginIsEmailValidatorIsValidActionIsSetToHideValidationLabel() {
        viewController.viewDidLoad()
        viewController.loginValidationLabelHeightConstraint.constant = 999
        
        viewController.loginTextField.validators?.last?.isValidAction?()
        
        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, 0, "Is empty validator should hide validation label on success")
    }
    
    func testThatLoginIsEmailValidatorIsValidActionIsSetToShowValidationLabelWithValidationText() {
        viewController.viewDidLoad()
        viewController.loginValidationLabel.text = nil
        viewController.loginValidationLabelHeightConstraint.constant = 0
        
        viewController.loginTextField.validators?.last?.isInvalidAction?()
        
        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, viewController.labelDefaultHeight, "Is empty validator should show validation label on failure")
        XCTAssertEqual(viewController.loginValidationLabel.text, "Login must be valid email", "Is empty validator should show validation text on failure")
    }

    func testThatPasswordTextFieldValidatorsAreSetUpOnViewDidLoad() {
        viewController.viewDidLoad()
        
        XCTAssertEqual(viewController.passwordTextField.validators?.count, 1, "Password text field should have 1 validator assigned")
        XCTAssert(viewController.passwordTextField.validators?.first is IsEmptyValidator, "Password text field should have Is Empty Validator assigned")
    }
    
    func testThatPasswordIsEmptyValidatorIsValidActionIsSetToHideValidationLabel() {
        viewController.viewDidLoad()
        viewController.passwordValidationLabelHeightConstraint.constant = 999
        
        viewController.passwordTextField.validators?.first?.isValidAction?()
        
        XCTAssertEqual(viewController.passwordValidationLabelHeightConstraint.constant, 0, "Is empty validator should hide validation label on success")
    }
    
    func testThatPasswordIsEmptyValidatorIsValidActionIsSetToShowValidationLabelWithValidationText() {
        viewController.viewDidLoad()
        viewController.passwordValidationLabel.text = nil
        viewController.passwordValidationLabelHeightConstraint.constant = 0
        
        viewController.passwordTextField.validators?.first?.isInvalidAction?()
        
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
        viewController.signInButton.isHidden = false
        viewController.spinner.stopAnimating()
        //When
        viewController.signIn()
        //Then
        XCTAssertNil(viewController.successLabel.text, "Success label text should be nil")
        XCTAssertEqual(viewController.signInButton.isHidden, true)
        XCTAssertEqual(viewController.spinner.isAnimating, true)
    }
    
    func testThatWhenInputIsValidLoginUserAfterTappingSignInButtonWhenNoError() {
        //Given
        viewController.loginTextField.text = "kyle.katarn@ravensclaw.com"
        viewController.passwordTextField.text = "0123456"
        viewController.successLabel.text = nil
        viewController.signInButton.isHidden = false
        viewController.spinner.stopAnimating()
        //When
        let name = "Jonh"
        userDataProviderStub?.usernameToReturn = name
        viewController.signIn()
        //Then
        XCTAssertEqual(viewController.successLabel.text, "Hello \(name)!", "Should contain \"Hello \(name)!\"")
        XCTAssertEqual(viewController.signInButton.isHidden, false)
        XCTAssertEqual(viewController.spinner.isAnimating, false)
    }
    
    func testThatWhenInputIsValidDoNotLoginUserAfterTappingSignInButtonWhenError() {
        //Given
        viewController.loginTextField.text = "kyle.katarn@ravensclaw.com"
        viewController.passwordTextField.text = "0123456"
        viewController.successLabel.text = nil
        viewController.signInButton.isHidden = false
        viewController.spinner.stopAnimating()
        //When
        userDataProviderStub?.errorToReturn = NSError(domain: "", code: 0, userInfo: [:])
        viewController.signIn()
        //Then
        XCTAssertEqual(viewController.successLabel.text, "Couldn't login 😱", "Should contain \"Couldn't login 😱\"")
        XCTAssertEqual(viewController.signInButton.isHidden, false)
        XCTAssertEqual(viewController.spinner.isAnimating, false)
    }

    func testThatWhenInputIsInvalidNothingHappensAfterTappingSignInButton() {
        //Given
        viewController.loginTextField.text = nil
        viewController.passwordTextField.text = nil
        viewController.successLabel.text = "some text"
        viewController.signInButton.isHidden = false
        viewController.spinner.stopAnimating()
        //When
        viewController.signIn()
        //Then
        XCTAssertEqual(viewController.successLabel.text, "some text", "Shoulc contain some text")
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
        XCTAssertEqual(viewController.passwordValidationLabel.text, nil, "Shouldn't set validation text")

        XCTAssertEqual(viewController.loginValidationLabelHeightConstraint.constant, 0, "Shouldn't show validation label")
        XCTAssertEqual(viewController.loginValidationLabel.text, nil, "Shouldn't set validation text")
    }

}

extension LoginViewControllerTests {
    
    func simulate(inputIsValid isValid: Bool) {
        viewController.loginTextField.text = isValid ? "kyle.katarn@ravensclaw.com" : ""
        viewController.passwordTextField.text = isValid ? "0123456" : ""
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
