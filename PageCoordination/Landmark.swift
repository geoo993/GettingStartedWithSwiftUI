//
//  Landmark.swift
//  OrigonHub
//
//  Created by GEORGE QUENTIN on 02/09/2020.
//  Copyright © 2020 GEORGE QUENTIN. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Landmark: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var park: String = ""
    fileprivate var imageName: String
    fileprivate var coordinates: Coordinates
    var isFeatured: Bool

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    var featureImage: Image? {
        guard isFeatured else { return nil }
        
        return Image(imageName, label: Text(name))
    }
    
    init(name: String, imageName: String, coordinates: Coordinates, isFeatured: Bool) {
        self.name = name
        self.imageName = imageName
        self.coordinates = coordinates
        self.isFeatured = isFeatured
    }

}

extension Landmark {
    var image: Image {
        Image(imageName)
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
