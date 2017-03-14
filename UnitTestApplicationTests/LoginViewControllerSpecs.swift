//
//  LoginViewControllerSpecs.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 13.03.2017.
//  Copyright © 2017 Kamil Tustanowski. All rights reserved.
//

import Quick
import Nimble
@testable import UnitTestApplication

class LoginViewControllerSpecs: QuickSpec {
    
    override func spec() {
        
        var viewController: LoginViewController!
        
        beforeEach {
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! LoginViewController
            viewController.loadViewIfNeeded()
            viewController.userProvider = UserDataProviderStub() /* Make sure we won't make api calls during the tests */
        }
        
        describe("On view did load") {
            it("hides login validation label") {
                viewController.viewDidLoad()
                
                expect(viewController.loginValidationLabelHeightConstraint.constant) == 0
            }
            
            it("hides password validation label") {
                viewController.viewDidLoad()
                
                expect(viewController.passwordValidationLabelHeightConstraint.constant) == 0
            }
        }
        
        describe("User") {
            context("tapped sign in button") {
                context("when provided correct credentials") {
                    beforeEach {
                        viewController.loginTextField.text = "valid@email.com"
                        viewController.passwordTextField.text = "validPassword"
                    }
                    it("updates UI for loading") {
                        viewController.userProvider = BlockCallbacksUserDataProviderStub()
                        
                        viewController.signIn()
                    
                        expect(viewController.spinner.isAnimating) == true
                        expect(viewController.signInButton.isHidden) == true
                    }
                    
                    context("and request was succesfull") { beforeEach { viewController.userProvider = SuccessUserDataProviderStub() }
                        it("shows success message") {
                            viewController.signIn()
                            
                            expect(viewController.messageLabel.text) == "Hello \(SuccessUserDataProviderStub.username)!"
                            expect(viewController.messageLabel.isHidden) == false
                        }
                        
                        it("updates UI for not loading") {
                            viewController.signIn()
                            
                            expect(viewController.spinner.isAnimating) == false
                            expect(viewController.signInButton.isHidden) == false
                        }
                    }
                    
                    context("and request was unsuccesfull") { beforeEach { viewController.userProvider = FailureUserDataProviderStub() }
                        it("shows failure message") {
                            viewController.signIn()
                            
                            expect(viewController.messageLabel.text) == "Couldn't login 😱"
                            expect(viewController.messageLabel.isHidden) == false
                        }
                        
                        it("updates UI for not loading") {
                            viewController.signIn()
                            
                            expect(viewController.spinner.isAnimating) == false
                            expect(viewController.signInButton.isHidden) == false
                        }
                    }
                }
                
                context("when provided incorrect credentials") {
                    it("doesn't update UI") {
                        viewController.userProvider = BlockCallbacksUserDataProviderStub()
                        
                        viewController.signIn()
                        
                        expect(viewController.spinner.isAnimating) == false
                        expect(viewController.signInButton.isHidden) == false
                    }

                    context("password is empty") {
                        it("shows empty password validation error") {
                            viewController.signIn()
                            
                            expect(viewController.passwordValidationLabelHeightConstraint.constant) == viewController.labelDefaultHeight
                            expect(viewController.passwordValidationLabel.text) == "Password cannot be empty"
                        }
                    }
                    
                    context("login is empty") {
                        it("shows empty login validation error") {
                            viewController.signIn()
                            
                            expect(viewController.loginValidationLabelHeightConstraint.constant) == viewController.labelDefaultHeight
                            expect(viewController.loginValidationLabel.text) == "Login cannot be empty"
                        }
                    }
                    
                    context("login is not valid email") {
                        it("shows invalid email login validation error") {
                            viewController.loginTextField.text = "invalid@email"
                            
                            viewController.signIn()
                            
                            expect(viewController.loginValidationLabelHeightConstraint.constant) == viewController.labelDefaultHeight
                            expect(viewController.loginValidationLabel.text) == "Login must be valid email"
                        }
                    }
                }
            }
            
            context("did end editing login field") {
                context("when login is empty") {
                    it("shows empty login validation error") {
                        viewController.textFieldDidEndEditing(viewController.loginTextField)
                        
                        expect(viewController.loginValidationLabelHeightConstraint.constant) == viewController.labelDefaultHeight
                        expect(viewController.loginValidationLabel.text) == "Login cannot be empty"
                    }
                }
                
                context("when login is not valid email") {
                    it("shows invalid email login validation error") {
                        viewController.loginTextField.text = "invalid@email"
                        viewController.textFieldDidEndEditing(viewController.loginTextField)
                        
                        expect(viewController.loginValidationLabelHeightConstraint.constant) == viewController.labelDefaultHeight
                        expect(viewController.loginValidationLabel.text) == "Login must be valid email"
                    }
                }
            }

            context("did end editing password field") {
                context("when password is empty") {
                    it("shows empty password validation error") {
                        viewController.textFieldDidEndEditing(viewController.passwordTextField)
                        
                        expect(viewController.passwordValidationLabelHeightConstraint.constant) == viewController.labelDefaultHeight
                        expect(viewController.passwordValidationLabel.text) == "Password cannot be empty"
                    }
                }
            }
        }
    }
}

class UserDataProviderStub: UserDataProvider {
    
    override func load(forLogin login: String, password: String) {
        /* do nothing to block any api calls from tests */
    }
}

class SuccessUserDataProviderStub: UserDataProvider {
    
    static var username = "Bob"
    
    override func load(forLogin login: String, password: String) {
        success?(User(login: login, name: SuccessUserDataProviderStub.username))
    }
}

class FailureUserDataProviderStub: UserDataProvider {
    
    override func load(forLogin login: String, password: String) {
        failure?(NSError(domain: "domain", code: 65, userInfo: nil))
    }
    
}

class BlockCallbacksUserDataProviderStub: UserDataProvider {
    
    override func load(forLogin login: String, password: String) {
        /* do nothing to allow to check state after starting sign in request*/
    }
    
}

