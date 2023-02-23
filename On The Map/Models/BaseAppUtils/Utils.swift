//
//  Utils.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 22/02/23.
//

import Foundation
import UIKit



class Utilities{
    
   
    class func isInternetConnectionAvailable(networkSharedInstance: NetworkReachabilityManager){
        
    }
    
    class func validateEmail(emailAddress: String)-> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

         let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         return emailPred.evaluate(with: emailAddress)
    }
    
    class func showAlertDialog(alertTitle: String, alertMessage: String, okButtonTxt: String) -> UIAlertController{
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okButtonTxt, style: .default, handler: nil))
//          present(alert, animated: true)
        return alert
    }
}
