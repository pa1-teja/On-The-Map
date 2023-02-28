//
//  Utils.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 22/02/23.
//

import Foundation
import UIKit
import SystemConfiguration
import MapKit



class Utilities{
    
   
    class func isConnectedToNetwork() -> Bool {
          var zeroAddress = sockaddr_in()
          zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
          zeroAddress.sin_family = sa_family_t(AF_INET)

          guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
              $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                  SCNetworkReachabilityCreateWithAddress(nil, $0)
              }
          }) else {
              return false
          }

          var flags: SCNetworkReachabilityFlags = []
          if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
              return false
          }
          if flags.isEmpty {
              return false
          }

          let isReachable = flags.contains(.reachable)
          let needsConnection = flags.contains(.connectionRequired)

          return (isReachable && !needsConnection)
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
    
    
    class func getLocationCoordinates(from locationString: String, completionHandler:
                                      @escaping (_ location: CLLocationCoordinate2D?, _ error: Error?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationString) { (placemarks, error) in
            guard let placemarks = placemarks,
            let location = placemarks.first?.location?.coordinate else {
                completionHandler(nil, error)
                return
            }
            completionHandler(location, nil)
        }
    }
    
    
}
