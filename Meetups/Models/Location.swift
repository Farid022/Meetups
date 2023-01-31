//
//  Location.swift
//  Meetups
//
//  Created by Muhammad Farid Ullah on 19/01/2023.
//

import Foundation
import MapKit

struct Location: Identifiable {
    let id = UUID()
    var cooredinate: CLLocationCoordinate2D
}
