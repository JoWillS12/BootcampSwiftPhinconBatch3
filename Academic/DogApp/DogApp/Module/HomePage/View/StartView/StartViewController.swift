//
//  StartViewController.swift
//  DogApp
//
//  Created by Joseph William Santoso on 15/11/23.
//

import UIKit
import MapKit
import CoreLocation

class StartViewController: UIViewController {
    
    @IBOutlet weak var methodType: UILabel!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var minute: UILabel!
    @IBOutlet weak var objective: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var customButton: CustomButton!
    @IBOutlet weak var myLocButton: UIButton!
    @IBOutlet weak var locImage: UIImageView!
    @IBOutlet weak var petImage: UIImageView!
    
    private let locationManager = CLLocationManager()
    private var locations: [CLLocation] = []
    private var startTime: Date?
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setupMapView()
        requestLocationPermission()
        
        customButton.tapAction = {[weak self] in
            let vc = EndViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTime = Date()
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    
    func setUp(){
        containView.layer.cornerRadius = 10
        containView.layer.borderWidth = 2
        containView.layer.borderColor = UIColor.white.cgColor
        containView.layer.shadowColor = UIColor.black.cgColor
        containView.layer.shadowOpacity = 0.1
        containView.layer.shadowOffset = CGSize(width: 5, height: 5)
        containView.layer.shadowRadius = 2
        mapView.layer.cornerRadius = 10
        mapView.layer.borderWidth = 2
        mapView.layer.borderColor = UIColor.white.cgColor
        locImage.layer.cornerRadius = locImage.frame.width / 2
        petImage.layer.cornerRadius = petImage.frame.width / 2
        customButton.buttonLabel.text = "End the walk"
    }
    
    @IBAction private func myLocButtonTapped() {
        centerMapOnLocation(mapView.userLocation.coordinate)
        //        if let userLocation = locationManager.location?.coordinate {
        //            centerMapOnLocation(userLocation)
        //        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updateTimer() {
        if let startTime = startTime {
            let elapsedTime = Date().timeIntervalSince(startTime)
            let formattedTime = formatTime(timeInterval: elapsedTime)
            minute.text = "\(formattedTime)"
        }
    }
}

extension StartViewController: MKMapViewDelegate {
    private func centerMapOnLocation(_ coordinate: CLLocationCoordinate2D?) {
        if let coordinate = coordinate {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        // Add a tap gesture recognizer to the myLocButton
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(myLocButtonTapped))
        myLocButton.addGestureRecognizer(tapGesture)
    }
    
    private func requestLocationPermission() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func generateExamplePoints(_ pointsCount: Int) -> [CustomAnnotation] {
        var points: [CustomAnnotation] = []
        
        for _ in 0..<pointsCount {
            let latitude = Double.random(in: 34.0 ... 36.0)
            let longitude = Double.random(in: -121.0 ... -119.0)
            let annotation = CustomAnnotation(latitude: latitude, longitude: longitude)
            points.append(annotation)
        }
        
        return points
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
}

extension StartViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last?.coordinate else { return }
        
        // Center the map on the user's location only when the button is not tapped
        if !myLocButton.isHighlighted {
            centerMapOnLocation(userLocation)
        }
        
        // Add the location to the locations array
        self.locations.append(locations.last!)
        
        // Remove existing annotations and add a pin to the user's location
        mapView.removeAnnotations(mapView.annotations)
        
        // Display the route on the map
        updateRoute()
    }
    
    private func updateRoute() {
        guard locations.count > 1 else { return }
        
        // Create a polyline and add it to the map
        var coordinates = locations.map { $0.coordinate }
        let polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
        mapView.addOverlay(polyline)
        
        // Calculate the total distance
        let totalDistance = locations.reduce(0.0) { $0 + $1.distance(from: locations.last!) }
        let formattedDistance = formatDistance(distance: totalDistance)
        distance.text = "\(formattedDistance)"
        
        // Calculate the elapsed time
        if let startTime = startTime {
            let elapsedTime = Date().timeIntervalSince(startTime)
            let formattedTime = formatTime(timeInterval: elapsedTime)
            minute.text = "\(formattedTime)"
        }
    }
    
    
    private func formatTime(timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timeInterval) ?? ""
    }
    
    private func formatDistance(distance: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        let formattedDistance = formatter.string(from: NSNumber(value: distance)) ?? ""
        return "\(formattedDistance)m"
    }
}


