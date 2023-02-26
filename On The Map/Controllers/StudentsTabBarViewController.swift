//
//  StudentsTabBarViewController.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 24/02/23.
//

import UIKit

class StudentsTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "On the Map"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LOGOUT", style: .plain, target: self, action: #selector(onClickLogout))
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    @objc func onClickLogout(){
        GenericAPIInfo.taskInteractWithAPI(methodType: GenericAPIInfo.MethodType.DELETE, url: LoginAPI.LoginEndpoint.logout.url, requestBody: "", responseType: LogoutAPI.LogoutResponse.self, completionHandler: handleLogoutSequence(success:error:))
    }

    
    func handleLogoutSequence(success: LogoutAPI.LogoutResponse?, error: Error?){
        
        if let success = success{
            LogoutAPI.LogoutResponse(session: success.session)
            navigationController?.popViewController(animated: true)
        } else {
            
            print("Logout error: \(error.debugDescription)")
            
           present(Utilities.showAlertDialog(alertTitle: "Oops", alertMessage: "Failed to logout, Please try again after sometime", okButtonTxt: "OK"), animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
