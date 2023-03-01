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
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    

    var sharedAppDelegateObject = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmailAddr.delegate = Utilities.textFieldDelegate()
        userPassword.delegate = Utilities.textFieldDelegate()
        
        isUserScreenInteraction(isEnabled: true)
        // Do any additional setup after loading the view.
        let emailTxt = userEmailAddr.text
        
       
        
        if(!Utilities.isConnectedToNetwork()){
           present(Utilities.showAlertDialog(alertTitle: "No Internet", alertMessage: "Please check you internet connectivity", okButtonTxt: "OK"), animated: true)
        }else if(emailTxt != nil || emailTxt != ""){
            userEmailAddr.text = ""
            userPassword.text = ""
        }
    }
    
    
    @IBAction func onClickSignUp(){
        UIApplication.shared.open(URL(string: "https://www.udacity.com/account/auth#!/signup")!)
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
            let loginRequestPackage: String = "{\"udacity\": {\"username\": \"\(userEmail ?? "")\", \"password\": \"\(password ?? "")\"}}"
            
            GenericAPIInfo.taskInteractWithAPI(methodType: GenericAPIInfo.MethodType.POST , url: LoginAPI.LoginEndpoint.login.url, requestBody: loginRequestPackage, responseType: LoginResponseJSON.LogInResponse.self, completionHandler: {
                (success, error) in
                guard let success = success else{
                    print("JSON response parsing failed : \(String(describing: error))")
                    self.handleLoginResponse(success: nil, error: error)
                    return
                }
                
                self.handleLoginResponse(success: success, error: error)
               
            })
        }
    }
    
    
    func handleLoginResponse(success: LoginResponseJSON.LogInResponse?, error:Error?){
       
        if(success != nil){
            print("JSON response successful : \(String(describing: success))")
            sharedAppDelegateObject.LoginUserObj = success
            GenericAPIInfo.taskInteractWithAPI(methodType: GenericAPIInfo.MethodType.GET, url: StudentLocationAPI.StudentLocationEndpoint.order("-updatedAt", 100).url, requestBody: "", responseType: StudentLocationResults.StudentResults.self, completionHandler: handleStudentProfileRecords(success:error:))
            
        }else{
            isUserScreenInteraction(isEnabled: true)
            present(Utilities.showAlertDialog(alertTitle: "Oops", alertMessage: error!.localizedDescription, okButtonTxt: "OK"), animated: true)
        }
    }
    
    func isUserScreenInteraction(isEnabled: Bool){
        loadingIndicator.isHidden = isEnabled
        userEmailAddr.isEnabled = isEnabled
        userPassword.isEnabled = isEnabled
        LoginButton.isEnabled = isEnabled
    }
    
    func handleStudentProfileRecords(success: StudentLocationResults.StudentResults?, error: Error?){
        if(success != nil){
            isUserScreenInteraction(isEnabled: true)
            sharedAppDelegateObject.studentProfiles.results = success!.results
            performSegue(withIdentifier: "LoginToStudentDetails", sender: nil)
        }else{
            isUserScreenInteraction(isEnabled: true)
            present(Utilities.showAlertDialog(alertTitle: "Oops", alertMessage: "Login was successfull but we couldn't fetch the student profiles. Please try again in some time.", okButtonTxt: "OK"), animated: true)
        }
    }
}

