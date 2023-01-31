//
//  File.swift
//  Meetups
//
//  Created by Muhammad Farid Ullah on 19/01/2023.
//
import CoreLocation
import MapKit
import SwiftUI
import Foundation


extension Meetup_addView {
    @MainActor class MeetUp_addview_VM: ObservableObject {
        @Published var inputImage: UIImage?
        @Published var image: Image?
        @Published var name: String = ""
        @Published var note: String = ""
        
        @Published var showingPhotoSelection = false
        @Published var showingPhotoLibrary = false
        @Published var showingCamera = false
        @Published var showingMapView = false
        
        let locationFetcher = LocationFetcher()
        @Published var mapRegion = MKCoordinateRegion()
        var location: Location?
        var wrappedPin: Location {
            location ?? Location(cooredinate: CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186))
        }
        
        init() {
            locationFetcher.start()
        }
        
        func save() {
            
        }
        
        func addMeetUp() -> MeetUp? {
            //you need to convert your UIImage to Data by calling its jpegData() method like this:
            guard let inputImage = inputImage,
                  let jpegData = inputImage.jpegData(compressionQuality: 0.8) else { return nil }
            
            readLocation()
            
            
            guard let location = location else { return nil }
            
            let newMeetUp = MeetUp(id: UUID(), name: name, description: note, image: jpegData, latitude: location.cooredinate.latitude, longitude: location.cooredinate.longitude)
            
            return newMeetUp
        }
        
        func readLocation() {
            if let currentlocation = locationFetcher.lastKnownLocation {
                mapRegion = MKCoordinateRegion(center: currentlocation, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                location = Location(cooredinate: currentlocation)
                print("Location: \(currentlocation)")
            }
            else {
                print("Location unknown")
            }
        }
    }
}
