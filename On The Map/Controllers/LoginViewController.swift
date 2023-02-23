//
//  ViewController.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 22/02/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailAddr: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    struct Connectivity {
        static let sharedInstance = NetworkReachabilityManager()!
        static var isConnectedToInternet:Bool {
            let connected = self.sharedInstance.isReachable
            return connected
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isUserScreenInteraction(isEnabled: true)
        // Do any additional setup after loading the view.
        let emailTxt = userEmailAddr.text
        
        if(emailTxt != nil || emailTxt != ""){
            userEmailAddr.text = ""
            userPassword.text = ""
        }
    }


    
    @IBAction func onClickLogin(_ sender: Any) {
        
        let userEmail = userEmailAddr.text
        let password = userPassword.text
        
        isUserScreenInteraction(isEnabled: false)
        
        if(userEmail == "" && userEmail == nil){
            let alert = UIAlertController(title: "Oops", message: "Please enter your email address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }else if(password == "" && password == nil){
            let alert = UIAlertController(title: "Oops", message: "Please enter your account password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }else{
            var loginRequestPackage: String = "{\"udacity\": {\"username\": \"\(userEmail ?? "")\", \"password\": \"\(password ?? "")\"}}"
            
            GenericAPIInfo.taskInteractWithAPI(methodType: GenericAPIInfo.MethodType.POST , url: LoginAPI.LoginEndpoint.login.url, requestBody: loginRequestPackage, responseType: LoginResponseJSON.LogInResponse.self, completionHandler: {
                (success, error) in
                guard let success = success else{
                    print("JSON response parsing failed : \(error)")
                    self.handleLoginResponse(success: nil, error: error)
                    return
                }
                
                self.handleLoginResponse(success: success, error: error)
               
            })
        }
    }
    
    
    func handleLoginResponse(success: LoginResponseJSON.LogInResponse?, error:Error?){
        isUserScreenInteraction(isEnabled: true)
        if(success != nil){
            print("JSON response successful : \(success)")
        }else{
            present(Utilities.showAlertDialog(alertTitle: "Oops", alertMessage: "Your email or password are incorrect. Please check and try again.", okButtonTxt: "OK"), animated: true)
        }
    }
    
    func isUserScreenInteraction(isEnabled: Bool){
        loadingIndicator.isHidden = isEnabled
        userEmailAddr.isEnabled = isEnabled
        userPassword.isEnabled = isEnabled
        LoginButton.isEnabled = isEnabled
    }
}

