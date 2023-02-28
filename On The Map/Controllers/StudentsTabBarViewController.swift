//
//  StudentsTabBarViewController.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 24/02/23.
//

import UIKit

class StudentsTabBarViewController: UITabBarController {

    
    var sharedAppDelegateObject = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "On the Map"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LOGOUT", style: .plain, target: self, action: #selector(onClickLogout))
        
        let addProfileBarButton = UIBarButtonItem(image: UIImage(named: "icon_addpin"), style: .plain, target: self, action: #selector(popUpAddLocationScreen))
        
        let refreshDataBarButton = UIBarButtonItem(image: UIImage(named: "icon_refresh"), style: .plain, target: self, action: #selector(onCLickRefresh))
        
        navigationItem.setRightBarButtonItems([addProfileBarButton,refreshDataBarButton], animated: true)
    
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
    @objc func popUpAddLocationScreen(){
        performSegue(withIdentifier: "add profile", sender: nil)
    }
    
 
    
    @objc func onCLickRefresh(){
        GenericAPIInfo.taskInteractWithAPI(methodType: GenericAPIInfo.MethodType.GET, url: StudentLocationAPI.StudentLocationEndpoint.order("-updatedAt", 100).url, requestBody: "", responseType: StudentLocationResults.StudentResults.self, completionHandler: handleStudentProfilesRefreshRecords(success:error:))
    }
    
    @objc func onClickLogout(){
        GenericAPIInfo.taskInteractWithAPI(methodType: GenericAPIInfo.MethodType.DELETE, url: LoginAPI.LoginEndpoint.logout.url, requestBody: "", responseType: LogoutAPI.LogoutResponse.self, completionHandler: handleLogoutSequence(success:error:))
    }

    
    func handleLogoutSequence(success: LogoutAPI.LogoutResponse?, error: Error?){
        if let success = success{
            LogoutAPI.LogoutResponse(session: success.session)
            navigationController?.popToRootViewController(animated: true)
            
//           let rrr = storyboard?.instantiateViewController(withIdentifier:  "") as! MapViewController!z
            
        } else {
            print("Logout error: \(error.debugDescription)")
           present(Utilities.showAlertDialog(alertTitle: "Network Error", alertMessage: "Failed to logout, Please try again after sometime", okButtonTxt: "OK"), animated: true)
        }
    }
    
 
    func handleStudentProfilesRefreshRecords(success: StudentLocationResults.StudentResults?, error: Error?){
        if(success != nil){
            sharedAppDelegateObject.studentProfiles.results = success!.results
        }else{
            present(Utilities.showAlertDialog(alertTitle: "Network Error", alertMessage: "we couldn't fetch new student profiles. Please try again in some time.", okButtonTxt: "OK"), animated: true)
        }
    }

}
