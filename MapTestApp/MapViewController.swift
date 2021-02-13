//
//  MapViewController.swift
//  MapTestApp
//
//  Created by students on 2/6/21.
//

import Foundation
import MapKit
import CoreLocation
import UIKit

class MapViewController: UIViewController {
    let annotation = MKPointAnnotation()

    @IBOutlet weak var trailsMap: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        // Center the map on Old Lyme with a 6 mile radius
        
        // let initialLocation = CLLocation(latitude: 41.3159, longitude: -72.3290)

       /* let coordinateRegion = MKCoordinateRegion(
          center: initialLocation.coordinate,
          latitudinalMeters: 10000,
          longitudinalMeters: 10000)
        
        trailsMap.setRegion(coordinateRegion, animated: true)
        */
        
        // lets show a location of interest on the map
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: 41.34564, longitude: -72.28333)
                annotation.title = "Lay Preserve"
                annotation.subtitle = "Lords Meadow Ln"
                trailsMap.addAnnotation(annotation)
        locationManager.startUpdatingLocation()
        
    }
    
  /*  override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // implications on battery
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation){
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) // how much of a span to show for this lat and long
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        trailsMap.setRegion(region, animated: true)
        
    }
    */
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            trailsMap.setRegion(region, animated: true)
        }
    }
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
        } else {
            //show alert to user
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            trailsMap.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            break
        case .notDetermined:
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
            
        }
    }
    
    //func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        
        
   // }
   
}


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        trailsMap.setRegion(region, animated: true)
    }
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

}

