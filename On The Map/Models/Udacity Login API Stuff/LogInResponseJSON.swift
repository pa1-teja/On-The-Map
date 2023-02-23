//
//  LogInResponseJSON.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 22/02/23.
//

import Foundation


class LoginResponseJSON{
    
    
    struct LogInResponse: Codable{
        let account: Account
        let session: Session
    }
    
    struct Account: Codable{
        let registered: Bool
        let key: String
    }
    
    struct Session: Codable{
        let id: String
        let expiration: String
    }
}
