//
//  ValidableTextField.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 15.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import UIKit

class ValidableTextField: UITextField, Validable {
    
    var validators: [Validator]?
    
    var stringToValidate: String? {
        return text
    }
    
}
