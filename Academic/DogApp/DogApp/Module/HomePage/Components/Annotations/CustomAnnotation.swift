//
//  CustomAnnotatios.swift
//  DogApp
//
//  Created by Joseph William Santoso on 15/11/23.
//

import Foundation
import MapKit

// CustomAnnotation class conforming to the MKAnnotation protocol
class CustomAnnotation: NSObject, MKAnnotation {
    
    // MARK: - Properties
    
    var coordinate: CLLocationCoordinate2D
    
    // MARK: - Initialization
    
    // Initialize the annotation with latitude and longitude
    init(latitude: Double, longitude: Double) {
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
    }
}

// Explanation: The code defines a `CustomAnnotation` class conforming to the `MKAnnotation` protocol. This class represents a custom annotation on the map with a specific coordinate. The coordinate property is required by the `MKAnnotation` protocol and is set during initialization using latitude and longitude values. This class can be used to create custom map annotations.

