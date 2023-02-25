//
//  StudentProfile.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 25/02/23.
//

import Foundation

class StudentProfile{
    
    struct StudentProfile: Codable{
        let createdAt: String
        let firstName: String
        let lastName : String
        let latitude : Double
        let longitude: Double
        let mapString: String
        let mediaURL : String
        let objectId : String
        let uniqueKey: String
        let updatedAt: String
    }
}
