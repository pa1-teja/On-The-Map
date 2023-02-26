//
//  LogoutResponseJSON.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 26/02/23.
//

import Foundation

class LogoutAPI{
    
    struct LogoutResponse: Codable{
        let session: LogOutResponseContents
    }
    
    struct LogOutResponseContents: Codable{
        let id: String
        let expiration: String
    }
    

}
