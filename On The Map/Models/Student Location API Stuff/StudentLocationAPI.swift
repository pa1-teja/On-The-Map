//
//  StudentLocationAPI.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 25/02/23.
//

import Foundation


class StudentLocationAPI {
    
    
    enum StudentLocationEndpoint{
        static let webAddress = "https://onthemap-api.udacity.com"
        static let apiVersion = "v1"
        static let baseEndpoint = "https://onthemap-api.udacity.com/\(apiVersion)/StudentLocation"
        static var urlComp = URLComponents(string: baseEndpoint)!
        
        
        
        case limit(Int)
        
        case skip(Int, Int)
        
        case order(String, Int)
        
        case uniqueKey(String)
        
        
        
        var queryParams: [URLQueryItem]{
            switch self{
            case .limit(let maxNoOfRecords): return [URLQueryItem(name: "limit", value: String(maxNoOfRecords))]
                
            case .skip(let noOfRecordsToSkip, let maxNoOfRecords): return [URLQueryItem(name: "skip", value: String(noOfRecordsToSkip)), URLQueryItem(name: "limit", value: String(maxNoOfRecords))]
                
            case .order(let sortOrder, let maxNoOfRecords): return [URLQueryItem(name: "order", value: sortOrder), URLQueryItem(name: "limit", value: String(maxNoOfRecords))]
                
            case .uniqueKey(let studentID): return [URLQueryItem(name: "uniqueKey", value: studentID)]
            }
        }
        
        var url: URL{
            StudentLocationEndpoint.urlComp.queryItems = queryParams
            print("Framed URL: \(StudentLocationEndpoint.urlComp.url!)")
            return StudentLocationEndpoint.urlComp.url!
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
