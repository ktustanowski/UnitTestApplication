//
//  UIAlertController+LoginAlert.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 22.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    class func loginErrorAlert() -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: "Couldn't login 😱", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
}
