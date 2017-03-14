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
        var userDataProviderStub: UserDataProviderStub? {
            return viewController.userProvider as? UserDataProviderStub
        }
        
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
                    context("and request was succesfull") {
                        it("signs user in") {
                        }
                    }
                    
                    context("request was unsuccesfull") {
                        it("shows error message") {
                            
                        }
                    }
                }
                
                context("when provided incorrect credentials") {
                    context("password is empty") {
                        it("shows empty password validation error") {
                            
                            
                            expect(viewController.loginValidationLabelHeightConstraint.constant) == viewController.labelDefaultHeight
                            expect(viewController.loginValidationLabel.text) == "Login cannot be empty"
                        }
                    }
                    
                    context("login is empty") {
                        it("shows empty login validation error") {
                            
                        }
                    }
                    
                    context("login is not valid email") {
                        it("shows invalid email login validation error") {
                            
                        }
                    }
                }
            }
            
            context("did end editing login") {
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

            context("did end editing password") {
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
    
    /**
     When set and error is nil - success closure is called
     */
    public var usernameToReturn: String?
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

class SuccessDataProviderStub: UserDataProvider {
    
    override func load(forLogin login: String, password: String) {
        success?(User(login: login, name: "Bob"))
    }
}

class FailureDataProviderStub: UserDataProviderStub {
    
    override func load(forLogin login: String, password: String) {
        failure?(NSError(domain: "domain", code: 65, userInfo: nil))
    }
    
}

