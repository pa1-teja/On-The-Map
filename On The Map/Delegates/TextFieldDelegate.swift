//
//  TextFieldDelegate.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 01/03/23.
//

import Foundation
import UIKit

class GenericTextFieldDelegate: NSObject, UITextFieldDelegate{
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
