//
//  IsEmptyValidator.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 21.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import Foundation

struct IsEmptyValidator: Validator {
    
    var isValidAction: (()->())?
    var isInvalidAction: (()->())?
    
    var isValid: ((String?) -> (Bool)) = { input in
        return input?.isEmpty == false
    }
    
    init() { /* block generation of init with parameters */ }
    
}
