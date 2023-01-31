//
//  Meetup.swift
//  Meetups
//
//  Created by Muhammad Farid Ullah on 19/01/2023.
//

import Foundation

import CoreLocation
import Foundation
import UIKit
import SwiftUI

struct MeetUp: Codable, Comparable {
    let id: UUID
    let name: String
    let description: String
    let image: Data?
    var latitude: Double
    var longitude: Double
    
    
    //convert UIImage to image. UIImage requires data. and Image(uiImage...)
    var wrappedImage: Image {
        if let imageData = image, let uiimage = UIImage(data: imageData) {
            return Image(uiImage: uiimage)
        }
        return Image(systemName: "camera.macro")
    }
    
    //a location var with init values of lati and longi
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    //sorting the meetUps
    static func <(lhs: MeetUp, rhs: MeetUp) -> Bool {
        lhs.name < rhs.name
    }
    
    //Example for preViews.
    static let example = MeetUp(id: UUID(),
                                name: "Memory Example: Marsa",
                                description: "This is Marsa beach, after very very very heavy rain ⛈.. the sun came up 🌤 the weather was amazing, the beach looked fablous. We ate bambalouni and ice cream.",
                                image: UIImage(named: "Example-Memory")!.jpegData(compressionQuality: 0.8)!,
                                latitude: 37.33233141, longitude: -122.0312186)
    //The compressionQuality parameter can be any value between 0 (very low quality) and 1 (maximum quality); something like 0.8 gives a good trade off between size and quality.

}
