//
//  MapViewController.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 26/02/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var studentProfiles : StudentLocationResults.StudentResults!{
        let sharedAppDelegateObject = UIApplication.shared.delegate as! AppDelegate
        return sharedAppDelegateObject.studentProfiles
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mapView.delegate = self
        mapView.register(StudentDetailAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        for profile in studentProfiles.results{
            let annotation = MKPointAnnotation()

            annotation.coordinate = CLLocationCoordinate2D(latitude: profile.latitude, longitude: profile.longitude)

            annotation.title = profile.firstName
            annotation.subtitle = profile.mediaURL


            mapView.addAnnotation(annotation)
            
            
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
