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
        locationManager.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: 0.0,
                               longitude: 0.0,
                               zoom: zoomLevel)
        self.MapView.camera = camera
        self.MapView.settings.myLocationButton = false
        self.MapView.isMyLocationEnabled = true
        self.MapView.delegate = self
    }
    
    func placeMarkOnGoogleMap(address:String,location:CLLocation) {
        let marker = GMSMarker(position: location.coordinate)
        marker.title = address
        marker.map = self.MapView
        marker.icon = UIImage(named: "Bar")
    }
    
    
}


// MARK:- LOCATION METHOD'S EXTENSION
extension MapViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
//        self.curentPosition = location.coordinate
//        if self.curentPosition != nil{
//            manager.stopUpdatingLocation()
//        }
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        self.MapView.camera = camera
        self.MapView.animate(to: camera)
        
        geocoder.reverseGeocodeCoordinate(location.coordinate){response , error in
            guard let address: GMSAddress = response?.firstResult()else{return}
            let  v = address.lines!.joined(separator: "\n")
            
        }
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
}


extension MapViewController:GMSMapViewDelegate{
  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    mapView.clear()
    //updatePlace()
    print("Lat: \(coordinate.latitude) & Long: \(coordinate.longitude)")
    let position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
    //self.curentPosition = position
    let geocoder = GMSGeocoder()
    geocoder.reverseGeocodeCoordinate(coordinate){response , error in
      guard let address: GMSAddress = response?.firstResult()
        else
      {
        return
      }
//    let v = address.lines!.joined(separator: "\n")
//    let marker = GMSMarker(position: position)
//    marker.title = v
//      self.lblAddress.text = v
//    marker.map = mapView
//    marker.icon = imageLiteral(resourceName: "Group 7")
//      print(v)
//      for i in address.lines!{
//        print("\(i)----------------")
//      }
//      print("\(address.locality)..Locatliy \n \(address.description).. Description \n \(address.subLocality)..subLocality \n\(address.country).. Country \n\(address.administrativeArea)..administrativeArea \n \(address.thoroughfare)..thoroughfare \n \(address.postalCode)..Zip \n \(address) Address")
//      self.location.address_name = address.locality
//      self.location.address = v
//      self.location.street_address_1 = address.subLocality
//      self.location.street_address_2 = address.locality
//      self.location.city = address.administrativeArea
//      self.location.zipcode = address.postalCode
//      self.location.address_lat = coordinate.latitude
//      self.location.address_lng = coordinate.longitude
//      self.location.throughFair = address.thoroughfare
    }
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
