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
        
        mapView.delegate = self
        mapView.register(StudentDetailAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        loadMapPins()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(animated){
            reloadMapPins()
        }
    }
    
    private func loadMapPins(){
        for profile in studentProfiles.results{
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: profile.latitude, longitude: profile.longitude)
            annotation.title = profile.firstName
            annotation.subtitle = profile.mediaURL
            mapView.addAnnotation(annotation)
        }
    }
   
    func reloadMapPins(){
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
        loadMapPins()
    }
   
  
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let strUrl: String = (view.annotation?.subtitle!)!
            UIApplication.shared.open(URL(string: strUrl)!)
    }

}
