//
//  ViewController.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 11.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    let labelDefaultHeight = CGFloat(21)
    @IBOutlet weak var loginValidationLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordValidationLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginTextField: ValidableTextField!
    @IBOutlet weak var passwordTextField: ValidableTextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var userProvider: UserDataProvider? {
        didSet {
            userProvider?.success = { [weak self] user in
                self?.messageLabel.text = "Hello \(user.name)!"
                self?.toggleSignInButtonAndSpinner()
            }
            
            userProvider?.failure = { [weak self] error in
                self?.messageLabel.text = "Couldn't login 😱"
                self?.toggleSignInButtonAndSpinner()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideLoginValidationLabel()
        hidePasswordValidationLabel()
        setupValidators()
    }

    
    fileprivate func setupValidators() {
        setupLoginValidators()
        setupPasswordValidators()
    }
    
    fileprivate func setupLoginValidators() {
        var isEmptyValidator = IsEmptyValidator()
        isEmptyValidator.isValidAction = { [weak self] in
            self?.hideLoginValidationLabel()
        }
        isEmptyValidator.isInvalidAction = { [weak self] in
            self?.showLoginValidation(errorMessage: "Login cannot be empty")
        }
        
        var isEmailValidator = IsEmailValidator()
        isEmailValidator.isValidAction = { [weak self] in
            self?.hideLoginValidationLabel()
        }
        isEmailValidator.isInvalidAction = { [weak self] in
            self?.showLoginValidation(errorMessage: "Login must be valid email")
        }

        loginTextField.validators = [isEmptyValidator, isEmailValidator]
    }
    
    
    fileprivate func setupPasswordValidators() {
        var isEmptyValidator = IsEmptyValidator()
        isEmptyValidator.isValidAction = { [weak self] in
            self?.hidePasswordValidationLabel()
        }
        isEmptyValidator.isInvalidAction = { [weak self] in
            self?.showPasswordValidation(errorMessage: "Password cannot be empty")
        }
        
        passwordTextField.validators = [isEmptyValidator]
    }
    
    @IBAction func signIn() {
        if inputIsValid() {
            signInUser()
        }
    }
    
    fileprivate func signInUser() {
        guard let login = loginTextField.text, let password = loginTextField.text else { return }
        if userProvider == nil {
            userProvider = UserDataProvider()
        }
                
        toggleSignInButtonAndSpinner()
        self.messageLabel.text = nil
        
        userProvider?.load(forLogin: login, password: password)
    }
    
    fileprivate func toggleSignInButtonAndSpinner() {
        signInButton.isHidden = !signInButton.isHidden
        spinner.isAnimating ? spinner.stopAnimating() : spinner.startAnimating()
    }
    
    fileprivate func inputIsValid() -> Bool {
        let loginIsValid = loginTextField.validate()
        let passwordIsValid = passwordTextField.validate()
        
        return loginIsValid && passwordIsValid
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let validableTextField = textField as? ValidableTextField else { return }
        
        let _ = validableTextField.validate()
    }
    
}

// MARK: Appearance management
extension LoginViewController {

    func hideLoginValidationLabel() {
        loginValidationLabelHeightConstraint.constant = 0
    }

    func showLoginValidation(errorMessage: String) {
        loginValidationLabel.text = errorMessage
        loginValidationLabelHeightConstraint.constant = labelDefaultHeight
    }

    func hidePasswordValidationLabel() {
        passwordValidationLabelHeightConstraint.constant = 0
    }
    
    func showPasswordValidation(errorMessage: String) {
        passwordValidationLabel.text = errorMessage
        passwordValidationLabelHeightConstraint.constant = labelDefaultHeight
    }

}
