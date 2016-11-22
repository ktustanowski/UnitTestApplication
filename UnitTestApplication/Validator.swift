//
//  Validator.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 21.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import Foundation

protocol Validator {
    
    var isValidAction: (()->())? { get set }
    var isInvalidAction: (()->())? { get set }
    
    var isValid: ((String?) -> (Bool)) { get set }
    
}

extension Validator {
    
    func validate(_ input: String?) -> Bool{
        let isValid = self.isValid(input) == true
        
        if isValid {
            isValidAction?()
        } else {
            isInvalidAction?()
        }
        
        return isValid
    }
    
}
