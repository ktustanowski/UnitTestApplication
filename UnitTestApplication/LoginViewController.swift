//
//  ViewController.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 11.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import UIKit

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
        
        setupValidators()
    }

    func setupValidators() {
        loginTextField.validators = [IsEmptyValidator()]
        passwordTextField.validators = [IsEmptyValidator()]
    }
    
    @IBAction func signIn() {
        if inputIsValid() {
            print("input is valid - starting login process")
        } else {
            print("input is invalid")
        }
    }
    
    private func inputIsValid() -> Bool {
        return loginTextField.isValid() && passwordTextField.isValid()
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        guard let validableTextField = textField as? ValidableTextField else { return }
        
        validableTextField.validate()
    }
    
}
