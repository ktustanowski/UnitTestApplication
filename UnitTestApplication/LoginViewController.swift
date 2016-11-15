//
//  ViewController.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 11.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginValidationLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordValidationLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

