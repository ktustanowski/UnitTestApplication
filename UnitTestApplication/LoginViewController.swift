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
    @IBOutlet weak var successLabel: UILabel!
    
    lazy var userProvider: UserDataProvider? = {
        return UserDataProvider()
    }()
    
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
        
        var isEmailValidator = IsEmailValidator()
        isEmailValidator.isValidAction = { [weak self] in
            self?.hideLoginValidationLabel()
        }
        isEmailValidator.isInvalidAction = { [weak self] in
            self?.showLoginValidation(errorMessage: "Login must be valid email")
        }

        loginTextField.validators = [isEmptyValidator, isEmailValidator]
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
        if inputIsValid() {
            toggleSignInButtonAndSpinner()
            loginUser()
        }
    }
    
    func loginUser() {
        guard let login = loginTextField.text, let password = loginTextField.text else { return }
        self.successLabel.text = nil
        
        userProvider?.success = { [weak self] user in
            self?.successLabel.text = "Hello \(user.name)!"
            self?.toggleSignInButtonAndSpinner()
        }
        
        userProvider?.failure = { [weak self] error in
            self?.showErrorAlert()
            self?.toggleSignInButtonAndSpinner()
        }
        
        userProvider?.load(forLogin: login, password: password)
    }
    
    func showErrorAlert() {
        self.present(UIAlertController.loginErrorAlert(), animated: true, completion: nil)
    }
    
    func toggleSignInButtonAndSpinner() {
        signInButton.isHidden = !signInButton.isHidden
        spinner.isAnimating ? spinner.stopAnimating() : spinner.startAnimating()
    }
    
    private func inputIsValid() -> Bool {
        let loginIsValid = loginTextField.validate()
        let passwordIsValid = passwordTextField.validate()
        
        return loginIsValid && passwordIsValid
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
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
