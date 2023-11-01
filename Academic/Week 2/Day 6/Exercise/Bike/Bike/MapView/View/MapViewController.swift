//
//  MapViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 01/11/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationTextField: UITextField!
    
    var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupMapView()
        addExamplePoints()
        locationTextField.delegate = self
    }
    
    @IBAction func searchCity(_ sender: Any) {
        searchLocation()
    }
    
    
}

extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        searchLocation()
        return true
    }
}

extension MapViewController{
    
    private func searchLocation() {
        if let locationName = locationTextField.text, !locationName.isEmpty {
            geocoder.geocodeAddressString(locationName) { [weak self] (placemarks, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Geocoding error: \(error)")
                    // Handle the error, e.g., display an alert to the user
                } else if let placemark = placemarks?.first {
                    let coordinate = placemark.location?.coordinate
                    self.centerMapOnLocation(coordinate)
                } else {
                    // Handle no results found, e.g., display an alert to the user
                }
            }
        }
    }
    
    private func centerMapOnLocation(_ coordinate: CLLocationCoordinate2D?) {
        if let coordinate = coordinate {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = false
        
        let region = MKCoordinateRegion(center: .init(latitude: 35.278259, longitude: -119.5), latitudinalMeters: 500000, longitudinalMeters: 500000)
        mapView.setRegion(region, animated: false)
    }
    
    private func addExamplePoints() {
        /// Removing existing annotations before adding new ones
        let oldAnnotations = self.mapView.annotations
        mapView.removeAnnotations(oldAnnotations)
        
        /// Generating and adding new annotations to the map
        let points = generateExamplePoints(40)
        mapView.addAnnotations(points)
    }
    
    private func generateExamplePoints(_ pointsCount: Int) -> [CustomAnnotation] {
        var points: [CustomAnnotation] = []
        
        /// Generating sample points based on the given count
        for _ in 0..<pointsCount {
            let latitude = Double.random(in: 34.0 ... 36.0)
            let longitude = Double.random(in: -121.0 ... -119.0)
            let annotation = CustomAnnotation(latitude: latitude, longitude: longitude)
            points.append(annotation)
        }
        
        return points
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        return MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
}
