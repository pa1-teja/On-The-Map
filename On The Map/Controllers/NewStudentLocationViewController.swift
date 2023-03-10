//
//  NewStudentLocationViewController.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 27/02/23.
//

import UIKit
import MapKit

class NewStudentLocationViewController: UIViewController, MKMapViewDelegate {

    
    
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationCoordinates: CLLocationCoordinate2D?
    var typedAddress: String?
    var profileLink: String?
    
     let annotation = MKPointAnnotation()
    
    var loginObj : LoginResponseJSON.LogInResponse{
        let sharedAppDelegateObject = UIApplication.shared.delegate as! AppDelegate
        return sharedAppDelegateObject.LoginUserObj!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Add Location", style: .plain, target: self, action: #selector(moveBack))
        
        mapView.delegate = self
        mapView.register(StudentDetailAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: locationCoordinates!.latitude, longitude: locationCoordinates!.longitude)
        annotation.title = typedAddress!
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        
        mapView.setRegion(region, animated: false)
        mapView.addAnnotation(annotation)
    }
    
    @objc func moveBack(){
        navigationController?.popViewController(animated: true)
    }
    
  
    @IBAction func addStudentProfile(_ sender: Any) {
        let requestBody = "{\"uniqueKey\": \"\(loginObj.account.key) \", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"\(typedAddress!)\", \"mediaURL\": \"\(profileLink!)\", \"latitude\": \(annotation.coordinate.latitude), \"longitude\": \(annotation.coordinate.longitude)}"
        
        GenericAPIInfo.taskInteractWithAPI(methodType: GenericAPIInfo.MethodType.POST, url: URL(string:StudentLocationAPI.StudentLocationEndpoint.baseEndpoint)!,
                                           requestBody: requestBody,
                                           responseType: AddStudent.AddStudent.self, completionHandler: registerStudentProfile(success:error:))
    }
    
    
    func registerStudentProfile(success: AddStudent.AddStudent?, error: Error?){
        
        if(success != nil){
            performSegue(withIdentifier: "Back To Profiles", sender: nil)
            
        } else{
            present(Utilities.showAlertDialog(alertTitle: "Network Error", alertMessage: "Failed to add the student profile : \(error?.localizedDescription)", okButtonTxt: "OK"), animated: true)
        }
    }
}
