//
//  ViewController.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 11.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import UIKit

let labelDefaultHeight = CGFloat(21)

final class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginValidationLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordValidationLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginTextField: ValidableTextField!
    @IBOutlet weak var passwordTextField: ValidableTextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideLoginValidationLabel()
        hidePasswordValidationLabel()
        setupValidators()
    }

    func setupValidators() {
        setupLoginValidators()
        setupPasswordValidators()
    }
    
    func setupLoginValidators() {
        var isEmptyValidator = IsEmptyValidator()
        isEmptyValidator.isValidAction = { [weak self] in
            self?.hideLoginValidationLabel()
        }
        
        isEmptyValidator.isInvalidAction = { [weak self] in
            self?.showLoginValidation(errorMessage: "Login cannot be empty")
        }
        
        loginTextField.validators = [isEmptyValidator]
    }
    
    
    func setupPasswordValidators() {
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
        validateInput()
        if inputIsValid() {
            print("input is valid - starting login process")
        } else {
            
        }
    }
    
    private func inputIsValid() -> Bool {
        return loginTextField.isValid() && passwordTextField.isValid()
    }
    
    private func validateInput() {
        loginTextField.validate()
        passwordTextField.validate()
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        guard let validableTextField = textField as? ValidableTextField else { return }
        
        validableTextField.validate()
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
