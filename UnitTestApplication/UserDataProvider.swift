//
//  UserDataProvider.swift
//  UnitTestApplication
//
//  Created by Kamil Tustanowski on 16.11.2016.
//  Copyright © 2016 Kamil Tustanowski. All rights reserved.
//

import Foundation

struct User {

    let login: String
    let name: String
    
}

class UserDataProvider {
    
    var success: ((User)->())?
    var failure: ((NSError?)->())?
    
    func load(forLogin login: String, password: String) {
        /* ------------------------------------- */
        /* pretend we do some network calls here */
        /* ------------------------------------- */
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).asyncAfter(deadline: .now() + 1.0, execute: {
            DispatchQueue.main.async(execute: {
                let shouldFail = arc4random_uniform(2) == 0
                if shouldFail {
                    self.failure?(NSError(domain: "ErrorDomain", code: 999, userInfo: nil))
                } else {
                    self.success?(User(login: login, name: "Rupert"))
                }
            })
        })
    }
    
}
