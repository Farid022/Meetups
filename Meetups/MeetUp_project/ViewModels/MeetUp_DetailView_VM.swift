//
//  MeetUp_DetailView.swift
//  Meetups
//
//  Created by Muhammad Farid Ullah on 19/01/2023.
//

import Foundation
import MapKit

extension MeetUp_DetailView {
    @MainActor class MeetUp_Detail_VM: ObservableObject {
        enum VisibleView: String {
            case photo, map
        }
        
        let meetUp: MeetUp
        var location: Location?
        
        @Published var showingDeleteAlert = false
        @Published var currentVisibleView = VisibleView.photo
        @Published var mapRegion = MKCoordinateRegion()
        
        
        var pin: Location {
            location ?? Location(cooredinate: CLLocationCoordinate2D(latitude: meetUp.latitude, longitude: meetUp.longitude))
        }
        
        
        init(meetUp: MeetUp) {
            self.meetUp = meetUp
            mapRegion = MKCoordinateRegion(center: meetUp.location, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
}
