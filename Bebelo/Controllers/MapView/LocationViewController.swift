//
//  LocationViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 08/09/2021.
//

import UIKit
import MapboxMaps
import MapboxSearch
import MapboxCoreMaps
import MapKit
//import MapboxSearchUI
import MapboxGeocoder
import IQKeyboardManagerSwift
class LocationViewController: UIViewController {
    
    //IBOUTLET'S
    @IBOutlet weak var MapboxView: UIView!
    @IBOutlet weak var tfSearch: UISearchBar!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var tableViewConst: NSLayoutConstraint!
    let searchEngine = SearchEngine()
    var searchSuggestionArray = [SearchSuggestion]()
    let distanceFilter: CLLocationDistance = 50
    var myLocation = CLLocationCoordinate2D(latitude: Constant.Mad_latitude, longitude: Constant.Mad_longitude)
    var location = LocationModel()
    var locationManager = CLLocationManager()
    var delegate = UIViewController()
    var zoomLevel: CGFloat = 14.0
    var delagate = UIViewController()
    var Mapbox: MapView!
    var pointAnnotationManager: PointAnnotationManager!
    var cameraLocationConsumer: CameraLocationConsumer!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchEngine.delegate = self
        
        let option = CameraOptions(center: self.myLocation, zoom: self.zoomLevel, bearing: 0, pitch: 15)
        let myMapInitOptions = MapInitOptions(cameraOptions: option)
        self.Mapbox = MapView(frame: self.view.bounds, mapInitOptions: myMapInitOptions)
        self.Mapbox.backgroundColor = .white
        self.MapboxView.addSubview(self.Mapbox)
        self.pointAnnotationManager = self.Mapbox.annotations.makePointAnnotationManager()
        self.pointAnnotationManager.delegate = self
        
        
        self.Mapbox.ornaments.scaleBarView.isHidden = true
        self.Mapbox.ornaments.compassView.isHidden = false
        self.Mapbox.ornaments.logoView.isHidden = true
        self.Mapbox.ornaments.attributionButton.isHidden = true
        self.Mapbox.gestures.options.pitchEnabled = false
        
//        self.Mapbox.mapboxMap.onEvery(.mapIdle, handler: { [weak self] _ in
//            guard let selfs = self else { return }
//
//            let touchCoordinate =  selfs.Mapbox.cameraState.center
//            selfs.myLocation.latitude = touchCoordinate.latitude
//            selfs.myLocation.longitude = touchCoordinate.longitude
//            let touchLocation = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
//            selfs.loadAnotaion()
//            print(selfs.myLocation)
//        })
//        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
//        for recognizer in self.Mapbox.gestureRecognizers! where recognizer is UITapGestureRecognizer {
//        singleTap.require(toFail: recognizer)
//        }
//        self.Mapbox.addGestureRecognizer(singleTap)
        self.Mapbox.gestures.delegate = self
        
        self.tableViewConst.constant = 0
        self.searchResultTableView.tableFooterView = UIView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(doneBtnAction(_:))), animated: true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.userLocationSetup()
        self.Mapbox.mapboxMap.setCamera(to: CameraOptions(center: self.myLocation, zoom: self.zoomLevel, bearing: 0, pitch: 15))
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = true
    }
    func showAnnotation(_ annotations: [PointAnnotation], isPOI: Bool) {
        guard !annotations.isEmpty else { return }
        self.pointAnnotationManager.annotations.removeAll()
        self.pointAnnotationManager.annotations = annotations
        
        if annotations.count == 1, let annotation = annotations.first {
            if case let .point(point) = annotation.geometry {
                self.Mapbox.mapboxMap.setCamera(to: CameraOptions(center: point.coordinates, zoom: self.zoomLevel, bearing: 0, pitch: 15))
            }
            
        }
    }
    @IBAction func doneBtnAction(_ sender: Any) {
        self.gotoBack()
    }
    
    func gotoBack(){

        switch delagate {
        case let control as AddYourBarViewController:
            control.loadAddress(self.location)
        case let control as EditBarProfileViewController:
            control.loadAddress(self.location)
        default:
            break
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    func userLocationSetup() {
        self.Mapbox.location.locationProvider.requestAlwaysAuthorization()
        self.Mapbox.location.delegate = self
        self.Mapbox.location.locationProvider.setDelegate(self)
        self.Mapbox.location.locationProvider.startUpdatingLocation()
//        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.distanceFilter = distanceFilter
//        locationManager.startUpdatingLocation()
//        locationManager.startUpdatingHeading()
//        locationManager.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
extension LocationViewController:GestureManagerDelegate{
    func gestureManager(_ gestureManager: GestureManager, didBegin gestureType: GestureType) {
        
    }
    
    func gestureManager(_ gestureManager: GestureManager, didEnd gestureType: GestureType, willAnimate: Bool) {
        switch gestureType {
        case .singleTap:
            self.handleMapTap(sender: gestureManager.singleTapGestureRecognizer)
        default:
            break
        }
    }
    
    func gestureManager(_ gestureManager: GestureManager, didEndAnimatingFor gestureType: GestureType) {
        
    }
    
    
}
extension LocationViewController: SearchEngineDelegate {
    func suggestionsUpdated(suggestions: [SearchSuggestion], searchEngine: SearchEngine) {
        let annotations = searchEngine.suggestions.map { searchResult in
            return searchResult
        }
        
        self.searchSuggestionArray = annotations
        self.searchResultTableView.reloadData()
    }
    
    func resultResolved(result: SearchResult, searchEngine: SearchEngine) {
        self.pointAnnotationManager.annotations.removeAll()
        var annotation = PointAnnotation(point: Point(result.coordinate))
        //annotation.textField = result.name
        annotation.image = .init(image: UIImage(named: "Me1")!, name: "Me1")
        annotation.iconAnchor = .center
        //annotation.textAnchor = .left
        //annotation.subtitle = result.address?.formattedAddress(style: .medium)
        self.pointAnnotationManager.annotations.append(annotation)
        self.Mapbox.camera.fly(to: CameraOptions(center: result.coordinate, zoom: self.zoomLevel, bearing: 0, pitch: 15))
        self.location.address_lat = result.coordinate.latitude
        self.location.address_lng = result.coordinate.longitude
        self.location.address_name = result.name
        self.location.address = result.address?.formattedAddress(style: .medium)
        //showAnnotation([annotation], isPOI: result.type == .POI)
        print("Dumping resolved result:", dump(result))
        self.tableViewConst.constant = UIScreen.main.bounds.height/3
    }
    
    func searchErrorHappened(searchError: SearchError, searchEngine: SearchEngine) {
        print("Error during search: \(searchError)")
    }
    
}
extension LocationViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchSuggestionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationsTableViewCell
        cell.lblName.text = self.searchSuggestionArray[indexPath.row].name
        if let address = self.searchSuggestionArray[indexPath.row].address?.formattedAddress(style: .long){
            cell.lblAddress.text = address
        }
        else{
            cell.lblAddress.text = ""
        }
        if let name = self.searchSuggestionArray[indexPath.row].iconName{
            print("iconName:\(name)")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchEngine.select(suggestion: self.searchSuggestionArray[indexPath.row])
        self.tfSearch.resignFirstResponder()
    }
    
    
}
extension LocationViewController:UISearchBarDelegate{
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text!.isEmpty{
            self.tableViewConst.constant = 0
        }
        //self.tableViewConst.constant = 0
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //searchBar.resignFirstResponder()
        let height = UIScreen.main.bounds.height
        switch height{
        case Globals.iphone_13ProMax_12ProMax_hieght8:
            self.tableViewConst.constant = UIScreen.main.bounds.height/1.3
        case Globals.iphone_11ProMax_11_XsMax_XR_hieght7:
            self.tableViewConst.constant = UIScreen.main.bounds.height/2.2
        default:
            self.tableViewConst.constant = UIScreen.main.bounds.height/1.3
        }
        //searchBar.becomeFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let cameraOptions = CameraOptions(cameraState: Mapbox.mapboxMap.cameraState, anchor: nil)
        let cameraBounds = Mapbox.mapboxMap.coordinateBounds(for: cameraOptions)
        //let cameraBounds = CoordinateBounds(location: self.Mapbox.mapboxMap.cameraState.center, radiusMeters: 50000)
        let boundingBox = MapboxSearch.BoundingBox(cameraBounds.southwest,
        cameraBounds.northeast)
        let requestOptions = SearchOptions(proximity: self.Mapbox.mapboxMap.cameraState.center, boundingBox: boundingBox)
        searchEngine.search(query: searchText, options: requestOptions)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
//MARK:- MAPBOX DELEGATES
extension LocationViewController:AnnotationInteractionDelegate {
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
//        guard let annotation = annotations.first else {
//            return
//        }
//        print("annotations:\(annotation.id),\(annotations.count)")
//        let anotaion = self.annotaionFilterArray1.first { annotationModel in
//            print("uuuuuid:\(annotationModel.uuid)")
//            return "\(annotationModel.uuid)" == annotation.id
//        }
//        let bar = self.barArray.first { barModel in
//            return barModel.uuid == anotaion?.uuid
//        }
////        mapView.fly(to: mapView.camera) {
////            //self.tapAnotation(annotion: anotaion,bar: bar)
////        }
//        if let locaction = CommonHelper.getCachedMapLocData(){
//            self.Mapbox.camera.fly(to: CameraOptions(center: anotaion?.location, zoom: self.Mapbox.cameraState.zoom, bearing: self.Mapbox.cameraState.bearing, pitch: self.Mapbox.cameraState.pitch)) { position in
//                CommonHelper.saveCachedMapLocData(LocationModel(address_lat: anotaion?.location.latitude, address_lng: anotaion?.location.longitude, altitude: self.Mapbox.cameraState.zoom, pitch: self.Mapbox.cameraState.pitch, heading: self.Mapbox.cameraState.bearing))
//
//                self.selectedAnnotation = anotaion
//                self.selectedBar = bar
//                self.showtableView()
//            }
//        }
//        else{
//            self.Mapbox.camera.fly(to: CameraOptions(center: anotaion?.location, zoom: 15, bearing: 0, pitch: 15)) { position in
//
//                self.selectedAnnotation = anotaion
//                self.selectedBar = bar
//                self.showtableView()
//            }
//        }
        
    }
}
extension LocationViewController {
    
    func loadAnotaion(){
        
        var point = PointAnnotation(point: Point(self.myLocation))
        //point.textField = "Me"
        //point.textAnchor = .left
        point.image = .init(image: UIImage(named: "Me1")!, name: "Me1")
        point.iconAnchor = .center
        self.Mapbox.camera.fly(to: CameraOptions(center: self.myLocation, zoom: self.zoomLevel, bearing: 0, pitch: 15))
        self.pointAnnotationManager.annotations = [point]
        
        let geocoder = Geocoder(accessToken: Constant.mapboxtoken)
        let options = ReverseGeocodeOptions(coordinate: self.myLocation)
        options.allowedScopes = [.country,.region,.district,.locality,.place,.address]
        geocoder.geocode(options) {(placemarks, attribution, error) in
            guard let placemark = placemarks?.first else {
                    return
                }
            print(placemark.name)
                    // 200 Queen St
            print(placemark.qualifiedName)
            print(placemark.address)
            print(placemark.postalAddress)
            self.location.address_lat = placemark.location?.coordinate.latitude
            self.location.address_lng = placemark.location?.coordinate.longitude
            self.location.address_name = placemark.qualifiedName
            self.location.address = placemark.qualifiedName
            self.showAnnotation([point], isPOI: true)
        }
    }
    @objc @IBAction func handleMapTap(sender: UIGestureRecognizer) {
//        let mapView = sender.view as! MapView
//        if sender.state == .ended {
            let point = sender.location(in: sender.view!)
            let touchCoordinate =  self.Mapbox.mapboxMap.coordinate(for: point)
            self.myLocation.latitude = touchCoordinate.latitude
            self.myLocation.longitude = touchCoordinate.longitude
            //let touchLocation = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
            self.loadAnotaion()
            print(self.myLocation)
//        }
    }
    
}

// MARK:- LOCATION METHOD'S EXTENSION
extension LocationViewController: LocationPermissionsDelegate,LocationProviderDelegate {
    func locationProvider(_ provider: MapboxMaps.LocationProvider, didUpdateHeading newHeading: CLHeading) {

    }

    func locationProvider(_ provider: MapboxMaps.LocationProvider, didFailWithError error: Error) {

    }

    func locationProviderDidChangeAuthorization(_ provider: MapboxMaps.LocationProvider) {
        switch provider.authorizationStatus {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            UserDefaults.standard.set(false, forKey: Constant.locationAccessKey)
            // Display the map using the default location.
            PopupHelper.alertWithAppSetting(title: "Alert".localized(), message: "Please enable your location".localized(), controler: self)
        case .notDetermined:
            print("Location status not determined.")
            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
            provider.startUpdatingLocation()
        case .authorizedAlways:
            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
            provider.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("Location status is OK.")
            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
            provider.startUpdatingLocation()
        @unknown default:
            print("Unknown case found")
        }
    }

    func locationManager(_ locationManager: LocationManager, didChangeAccuracyAuthorization accuracyAuthorization: CLAccuracyAuthorization) {
        if accuracyAuthorization == .reducedAccuracy {
         // Perform an action in response to the new change in accuracy
        }
    }
    func locationProvider(_ provider: MapboxMaps.LocationProvider, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        self.myLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.Mapbox.camera.fly(to: CameraOptions(center: self.myLocation, zoom: self.zoomLevel, bearing: 0, pitch: 15))
        provider.stopUpdatingLocation()
    }
}
//extension LocationViewController: CLLocationManagerDelegate {
//    
//    // Handle incoming location events.
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location: CLLocation = locations.last!
//        self.myLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        manager.stopUpdatingLocation()
//    }
//    
//    // Handle authorization for the location manager.
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .restricted:
//            print("Location access was restricted.")
//        case .denied:
//            print("User denied access to location.")
//            UserDefaults.standard.set(false, forKey: Constant.locationAccessKey)
//            // Display the map using the default location.
//            PopupHelper.alertWithAppSetting(title: "Alert", message: "Please enable your location", controler: self)
//        case .notDetermined:
//            print("Location status not determined.")
//        case .authorizedAlways:
//            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
//        case .authorizedWhenInUse:
//            print("Location status is OK.")
//            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
//        @unknown default:
//            print("Unknown case found")
//        }
//    }
//    
//    // Handle location manager errors.
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        locationManager.stopUpdatingLocation()
//        print("Error: \(error)")
//    }
//}
