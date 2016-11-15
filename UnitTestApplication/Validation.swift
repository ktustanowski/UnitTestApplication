//
//  Validation.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 15.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import Foundation

protocol Validable {
    
    var validators: [Validator]? { get set }
    var stringToValidate: String? { get }
    
}

extension Validable {
    
    func validate() {
        validators?.forEach { validator in
            validator.validate(stringToValidate)
        }
    }
    
    func isValid() -> Bool {
        var isValid = true
        validators?.forEach { validator in
            if validator.isValid(stringToValidate) == false {
                isValid = false
                return
            }
        }
        
        return isValid
    }
}

protocol Validator {
    
    var isValidAction: (()->())? { get set }
    var isInvalidAction: (()->())? { get set }
    
    var isValid: ((String?) -> (Bool)) { get set }
    
}

extension Validator {
    
    func validate(_ input: String?) {
        if self.isValid(input) == true {
            isValidAction?()
        } else {
            isInvalidAction?()
        }
    }
    
}

struct IsEmptyValidator: Validator {

    var isValidAction: (()->())?
    var isInvalidAction: (()->())?
   
    var isValid: ((String?) -> (Bool)) = { input in
        return input?.isEmpty == false
    }
    
}
