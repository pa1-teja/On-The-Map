//
//  LoginAPIDetails.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 22/02/23.
//

import Foundation


class LoginAPI{
    
    enum LoginEndpoint{
        static let webAddress = "https://onthemap-api.udacity.com"
        static let apiVersion = "v1"
        static let baseEndpoint = "https://onthemap-api.udacity.com/\(apiVersion)/session"
        
        case login
        
        case logout
        
        var stringValue: String{
            switch self{
            case .login: return LoginEndpoint.baseEndpoint
            case .logout: return LoginEndpoint.baseEndpoint
            }
        }
        
        var url: URL{
            return URL(string: stringValue)!
        }
    }
    
    struct LoginRequestParams: Codable{
        let username: String
        let password: String
    }
    
    struct udacity:  Encodable{
        let udacity: LoginRequestParams
    }
    
 
    
}
