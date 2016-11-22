//
//  String+EmailValidation.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 21.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import Foundation

extension String {
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let isEmailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return isEmailPredicate.evaluate(with: self)
    }
}
