//
//  AddStudentProfileViewController.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 27/02/23.
//

import UIKit

class AddStudentProfileViewController: UIViewController {

    
    
    @IBOutlet weak var locationName: UITextField!
    @IBOutlet weak var profileLink: UITextField!
    @IBOutlet weak var findLocationOnMap: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "Add Location"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(moveBackToTabs))
    }
    
    @objc func moveBackToTabs(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pinLocationOnMap(){
        let address  = locationName.text ?? ""
        let profileLink = profileLink.text ?? ""
        
        if (address.isEmpty){
           present(Utilities.showAlertDialog(alertTitle: "Location Error", alertMessage: "Please enter the name of the City, Province", okButtonTxt: "OK"), animated: true)
        } else if(profileLink.isEmpty){
            present(Utilities.showAlertDialog(alertTitle: "Profile Error", alertMessage: "Please enter your profile link", okButtonTxt: "OK"), animated: true)
        }else{
            let controller = storyboard?.instantiateViewController(withIdentifier: "New Student Location") as! NewStudentLocationViewController
            
            controller.newStudentLocation = address
            controller.newStudentProfileLink = profileLink
            
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
