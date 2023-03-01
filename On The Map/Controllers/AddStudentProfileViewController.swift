//
//  AddStudentProfileViewController.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 27/02/23.
//

import UIKit
import MapKit

class AddStudentProfileViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var locationName: UITextField!
    @IBOutlet weak var profileLink: UITextField!
    @IBOutlet weak var findLocationOnMap: UIButton!
    @IBOutlet weak var geoCodeLoadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        locationName.delegate = self
        
        locationName.enablesReturnKeyAutomatically = true
        profileLink.delegate = self
        
        profileLink.enablesReturnKeyAutomatically = true
        
        // Do any additional setup after loading the view.
        toggleScreenAcessebility(isEnabled: true)
        navigationItem.title = "Add Location"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(moveBackToTabs))
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
            toggleScreenAcessebility(isEnabled: false)
            Utilities.getLocationCoordinates(from: address, completionHandler: getLocationPinCoord(coordinates:error:))
        }
    }
    
    func getLocationPinCoord(coordinates: CLLocationCoordinate2D?, error: Error?){
        
        if(coordinates != nil){
           toggleScreenAcessebility(isEnabled: true)
            let controller = storyboard?.instantiateViewController(withIdentifier: "New Student Location") as! NewStudentLocationViewController
            
            controller.locationCoordinates = coordinates
            controller.profileLink = profileLink.text!
            controller.typedAddress = locationName.text!
            
            navigationController?.pushViewController(controller, animated: true)
        } else{
            toggleScreenAcessebility(isEnabled: true)
            present(Utilities.showAlertDialog(alertTitle: "Location Error", alertMessage: error!.localizedDescription, okButtonTxt: "OK"), animated: true)
            
        }
    }
    
    func toggleScreenAcessebility(isEnabled: Bool){
        locationName.isEnabled = isEnabled
        profileLink.isEnabled = isEnabled
        findLocationOnMap.isEnabled = isEnabled
        geoCodeLoadingIndicator.isHidden = isEnabled
    }
}
