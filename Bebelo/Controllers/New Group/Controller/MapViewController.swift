//
//  MapViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 05/07/2021.
//

import UIKit
import CoreLocation
import GoogleMaps

class MapViewController: UIViewController {
    
    //MARK: IBOUTLET'S
    @IBOutlet weak var MapView: GMSMapView!
    
    //MARK: VARIABLE'S
    var locationManager = CLLocationManager()
    var zoomLevel: Float = 12.0
    let geocoder = GMSGeocoder()
    var userLocationMarker = GMSMarker()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.userLocationSetup()
    }
    
}

//MARK:- Helping Method's
extension MapViewController{
    func userLocationSetup() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        locationManager.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: 0.0,
                                              longitude: 0.0,
                                              zoom: zoomLevel)
        self.MapView.camera = camera
        self.MapView.settings.myLocationButton = false
        self.MapView.isMyLocationEnabled = false
        self.MapView.delegate = self
    }
    
    func placeMarkOnGoogleMap(address:String,location:CLLocation) {
        let marker = GMSMarker(position: location.coordinate)
        marker.title = address
        marker.map = self.MapView
        marker.icon = UIImage(named: "Bar")
    }
    
    func RadiansToDegrees(radians: Double) -> Double {
        return radians * 190.0/M_PI
    }
    
    func DegreesToRadians(degrees: Double) -> Double {
        return degrees * M_PI / 180.0
    }
    
}


// MARK:- LOCATION METHOD'S EXTENSION
extension MapViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!

        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,longitude: location.coordinate.longitude,zoom: zoomLevel)
        self.MapView.camera = camera
        self.MapView.animate(to: camera)
        
        //Change current/my location icon
        userLocationMarker = GMSMarker(position: location.coordinate)
        userLocationMarker.icon = UIImage(named: "Me")
//        userLocationMarker.rotation = CLLocationDegrees(m)
        userLocationMarker.map = self.MapView
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            PopupHelper.alertWithAppSetting(title: "Alert", message: "Please enable your location", controler: self)
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        @unknown default:
            print("Unknown case found")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    //MARK: CHANGE CURRENT LOCATION ICON DEGREE FOR ROUTATION
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let direction = -newHeading.trueHeading as Double
        userLocationMarker.icon = self.imageRotatedByDegrees(degrees: CGFloat(direction), image: UIImage(named: "Me")!)
    }
 
    func imageRotatedByDegrees(degrees: CGFloat, image: UIImage) -> UIImage{
        let size = image.size
        
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.translateBy(x: 0.5*size.width, y: 0.5*size.height)
        context!.rotate(by: CGFloat(DegreesToRadians(degrees: Double(degrees))))
        
        image.draw(in: CGRect(origin: CGPoint(x: -size.width*0.5, y: -size.height*0.5), size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func setLatLonForDistanceAndAngle(userLocation: CLLocation) -> Double {
        let lat1 = DegreesToRadians(degrees: userLocation.coordinate.latitude)
        let lon1 = DegreesToRadians(degrees: userLocation.coordinate.longitude)
        
        let lat2 = DegreesToRadians(degrees: 37.7833);
        let lon2 = DegreesToRadians(degrees: -122.4167);
        
        let dLon = lon2 - lon1;
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        var radiansBearing = atan2(y, x);
        if(radiansBearing < 0.0)
        {
            radiansBearing += 2*M_PI;
        }
        
        return radiansBearing;
    }
}


extension MapViewController:GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        //mapView.clear()

    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        let camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: zoomLevel)
        let update = GMSCameraUpdate.setCamera(camera)
        mapView.animate(with: update)
        return true
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        //    self.lblAddress.text = marker.title
        //    self.curentPosition = marker.position
        //    self.gotoBack()
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        //reverseGeocodeCoordinate(position.target)
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
    }
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        // 1
        let geocoder = GMSGeocoder()
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            // 3
            //    self.lblAddress.text = lines.joined(separator: "\n")
            //    self.curentPosition = address.coordinate
            // 4
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
            self.MapView.animate(toLocation: address.coordinate)
        }
    }
}
