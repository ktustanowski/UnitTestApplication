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
    
    func validate() -> Bool {
        guard let validators = validators else { return true }
        
        for validator in validators {
            if validator.validate(stringToValidate) == false {
                return false
            }
        }
        
        return true
    }
}
