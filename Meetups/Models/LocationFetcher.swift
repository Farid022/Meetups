//
//  LocationFetcher.swift
//  Meetups
//
//  Created by Muhammad Farid Ullah on 19/01/2023.
//

import CoreLocation
import MapKit

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    var region = MKCoordinateRegion() //mapRegion
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        print("Location: started")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        region = MKCoordinateRegion(center: lastKnownLocation!, span: span) //initialising.
    }
}
