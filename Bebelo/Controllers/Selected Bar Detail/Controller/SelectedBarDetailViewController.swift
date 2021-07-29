//
//  SelectedBarDetailViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 09/07/2021.
//

import UIKit
import MapboxMaps
//import MapboxMobileEvents

//import SemiModalViewController
class SelectedBarDetailViewController: UIViewController {
    
    //IBOUTLET'S
    @IBOutlet weak var BarDetailTableView: UITableView!
    var annotaionArray = [AnnotationModel]()
    var selectedAnnotation:AnnotationModel!
    //ARRAY'S
    let headers_Array1 = [
        "",
        "",
        ""
    ]
    let headers_Array2 = [
        "",
        "",
        "Cerveza",
        "copas",
        "high rollar",
        "copas",
        ""
    ]
    let MainCategoryImages = [
        "Bombay-1",
        "Bombay",
        "image 4"
    ]
    let MainCategoryTitle = [
        "Bombay Sapphire",
        "Havanna Club",
        "Jameson"
    ]
    
    //CONSTANT'S
    let ShowBarSegue = "ShowBar"
    let distanceFilter: CLLocationDistance = 50
    //VARIABLE'S
    var isBarItemHide = false
    var delegate:MapViewController!
    var isPreviousClose = false
    var mapHeight:CGFloat = 0
    var myLocation = CLLocationCoordinate2D()
    var locationManager = CLLocationManager()
    var isShowMore = false
    var isScrollTop = false
    var zoomLevel: Float = 14.0
    var isMapLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userLocationSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.mapHeight = self.BarDetailTableView.frame.height
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mapHeight = self.BarDetailTableView.frame.height
        //self.BarDetailTableView.reloadData()
    }
    //IBACTION'S
    @IBAction func OptionBtnAction(_ sender: Any) {
        let optionView = self.getViewController(identifier: "MenuOptionViewController") as! MenuOptionViewController
        //optionView.delegate = self
        //optionView.modalPresentationStyle = .fullScreen
        //self.tabBarController?.present(optionView, animated: false, completion: nil)
        self.present(optionView, animated: false, completion: nil)
    }
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true){
            
        }
    }
    @IBAction func CloseBtnAction(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showfullviewAction(_ sender: Any) {
        if isPreviousClose == false{
//            self.dismissSemiModalViewWithCompletion {
//                self.delegate.showFullView()
//            }
            
        }
    }
    func userLocationSetup() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = distanceFilter
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        locationManager.delegate = self
//        let camera = GMSCameraPosition.camera(
        //            withLatitude: initialLatLng,
        //            longitude: initialLatLng,
        //            zoom: zoomLevel
        //        )
        
        
        
        
//        MapView.camera = camera
//        MapView.settings.myLocationButton = false
//        MapView.isMyLocationEnabled = true
//        MapView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SelectedBarProfileViewController{
            //controller.delegate = self.delegate
            //controller.delegate = self
        }
        if let controller = segue.destination as? SelectedBarDetailViewController{
            //controller.delegate = self.delegate
        }
    }
    
}

//MARK:- Delegate Method's
extension SelectedBarDetailViewController{
    
    func bardeatail(){
        // Delegate methods which call My Bar Profile view controller
        self.performSegue(withIdentifier: "ShowBar", sender: nil)
        //let cont = self.storyboard!.instantiateViewController(withIdentifier: "MenuOptionViewController") as! MenuOptionViewController
        //cont.delegate = self
        //self.present(cont, animated: true, completion: nil)
        
    }
    
}
//MARK:- MAPBOX DELEGATES
//extension SelectedBarDetailViewController {
//    
//    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
//        
//        for (ii,i) in self.annotaionArray.enumerated(){
//            // Create point to represent where the symbol should be placed
//            let point = MGLPointAnnotation()
//            //var val = Double(i)
//            //val = val/100
//            //point.coordinate = CLLocationCoordinate2D(latitude: self.myLocation.latitude + val, longitude: self.myLocation.longitude + val)
//            let cord = generateRandomCoordinates(250, max: 500,location: self.myLocation)
//            point.coordinate = cord
//            // Create a data source to hold the point data
//            let shapeSource = MGLShapeSource(identifier: i.identifier, shape: point, options: nil)
//            
//            // Create a style layer for the symbol
//            let shapeLayer = MGLSymbolStyleLayer(identifier: i.identifier1, source: shapeSource)
//            //shapeSource.performSelector(inBackground: #selector(self.tapAnotation(_:)), with: self)
//            
//            // Add the image to the style's sprite
//            if let image = UIImage(named: i.image) {
//                style.setImage(image, forName: i.image)
//            }
//            style.setImage(UIImage(named: i.image)!, forName: i.image)
//            // Tell the layer to use the image in the sprite
//            shapeLayer.iconImageName = NSExpression(forConstantValue: i.image)
//            shapeLayer.text = NSExpression(forConstantValue: i.price)
//            shapeLayer.textFontSize = NSExpression(forConstantValue: 13)
//            shapeLayer.textFontNames = NSExpression(forConstantValue: ["Roboto Bold","Roboto Bold"])
//            // Add the source and style layer to the map
//            style.addSource(shapeSource)
//            style.addLayer(shapeLayer)
//            shapeLayer.accessibilityHint = "\(ii)"
//            shapeSource.accessibilityHint = "\(ii)"
//            style.accessibilityHint = "\(ii)"
//            point.accessibilityHint = "\(ii)"
//        }
//    }
//    func generateRandomCoordinates(_ min: UInt32, max: UInt32,location:CLLocationCoordinate2D)-> CLLocationCoordinate2D {
//        //Get the Current Location's longitude and latitude
//        let currentLong = location.longitude
//        let currentLat = location.latitude
//
//        //1 KiloMeter = 0.00900900900901° So, 1 Meter = 0.00900900900901 / 1000
//        let meterCord = 0.00900900900901 / 1000
//
//        //Generate random Meters between the maximum and minimum Meters
//        let randomMeters = UInt(arc4random_uniform(max) + min)
//
//        //then Generating Random numbers for different Methods
//        let randomPM = arc4random_uniform(6)
//
//        //Then we convert the distance in meters to coordinates by Multiplying the number of meters with 1 Meter Coordinate
//        let metersCordN = meterCord * Double(randomMeters)
//
//        //here we generate the last Coordinates
//        if randomPM == 0 {
//            return CLLocationCoordinate2D(latitude: currentLat + metersCordN, longitude: currentLong + metersCordN)
//        }else if randomPM == 1 {
//            return CLLocationCoordinate2D(latitude: currentLat - metersCordN, longitude: currentLong - metersCordN)
//        }else if randomPM == 2 {
//            return CLLocationCoordinate2D(latitude: currentLat + metersCordN, longitude: currentLong - metersCordN)
//        }else if randomPM == 3 {
//            return CLLocationCoordinate2D(latitude: currentLat - metersCordN, longitude: currentLong + metersCordN)
//        }else if randomPM == 4 {
//            return CLLocationCoordinate2D(latitude: currentLat, longitude: currentLong - metersCordN)
//        }else {
//            return CLLocationCoordinate2D(latitude: currentLat - metersCordN, longitude: currentLong)
//        }
//
//    }
//    @objc func tapAnotation(_ sender:UIGestureRecognizer){
//        mapHeight = self.BarDetailTableView.frame.height/2.1
//        self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
//        isScrollTop = true
//    }
//    @objc @IBAction func handleMapTap(sender: UITapGestureRecognizer) {
//        let mapView = sender.view as! MGLMapView
//    if sender.state == .ended {
//    // Limit feature selection to just the following layer identifiers.
//        var layerIdentifiers: Set<String>! = []
//        for i in self.annotaionArray{
//            layerIdentifiers.insert(i.identifier)
//            layerIdentifiers.insert(i.identifier1)
//        }
//        
//        // Try matching the exact point first.
//        let point = sender.location(in: sender.view!)
//        for feature in mapView.visibleFeatures(at: point, styleLayerIdentifiers: layerIdentifiers)
//    where feature is MGLPointFeature {
//    guard let selectedFeature = feature as? MGLPointFeature else {
//    fatalError("Failed to cast selected feature as MGLPointFeature")
//    }
//    //showCallout(feature: selectedFeature)
//        self.tapAnotation(sender)
//    return
//    }
//     
//    let touchCoordinate = mapView.convert(point, toCoordinateFrom: mapView)
//    let touchLocation = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
//     
//    // Otherwise, get all features within a rect the size of a touch (44x44).
//    let touchRect = CGRect(origin: point, size: .zero).insetBy(dx: -22.0, dy: -22.0)
//    let possibleFeatures = mapView.visibleFeatures(in: touchRect, styleLayerIdentifiers: Set(layerIdentifiers)).filter { $0 is MGLPointFeature }
//     
//    // Select the closest feature to the touch center.
//    let closestFeatures = possibleFeatures.sorted(by: {
//    return CLLocation(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude).distance(from: touchLocation) < CLLocation(latitude: $1.coordinate.latitude, longitude: $1.coordinate.longitude).distance(from: touchLocation)
//    })
//    if let feature = closestFeatures.first {
//    guard let closestFeature = feature as? MGLPointFeature else {
//    fatalError("Failed to cast selected feature as MGLPointFeature")
//    }
//    //showCallout(feature: closestFeature)
//    return
//    }
//     
//    // If no features were found, deselect the selected annotation, if any.
//    mapView.deselectAnnotation(mapView.selectedAnnotations.first, animated: true)
//    }
//    }
//    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
//        //showBarDetailInSemiModel()
//        mapHeight = self.BarDetailTableView.frame.height/2.1
//        self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
//        isScrollTop = true
//    }
//    
//    func mapView(_ mapView: MGLMapView, didSelect annotationView: MGLAnnotationView) {
//        //showBarDetailInSemiModel()
//        mapHeight = self.BarDetailTableView.frame.height/2.1
//        self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
//        isScrollTop = true
//    }
//    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
//        mapHeight = self.BarDetailTableView.frame.height/2.1
//        self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
//        isScrollTop = true
//        }
//    func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
//        mapHeight = self.BarDetailTableView.frame.height/2.1
//        self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
//        isScrollTop = true
//    }
//    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
//        if annotation is MGLUserLocation && mapView.userLocation != nil {
//            return MGLUserLocationAnnotationView(annotation: annotation, reuseIdentifier: "ShouldntBeAssigned")
//            }
//        else{
//            let view = MGLAnnotationView(annotation: annotation, reuseIdentifier: "id")
//            view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(self.tapAnotation(_:))))
//            return view
//        }
//        
//    }
//}

//MARK:- HELPING METHOD'S
extension SelectedBarDetailViewController{
    
    func navigationBarSetup() {
        self.navigationController?.navigationBar.isHidden = false
        let yourBackImage = UIImage(named: Constant.navigationBackImage)
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
    }
    
    func hideOrUnhideNavItems() {
        if isBarItemHide == true{
            //CloseBtn.isHidden = true
            //OptionMenuBtn.isHidden = true
            //NavBarImage.isHidden = false
        }else{
            //CloseBtn.isHidden = false
            //OptionMenuBtn.isHidden = false
            //NavBarImage.isHidden = true
        }
    }
    
    func getViewController(identifier:String)-> UIViewController {
        let vc = UIStoryboard.init(name: Constant.mainStoryboard, bundle: Bundle.main).instantiateViewController(identifier: identifier)
        return vc
    }
    
    func headerForTableView(tableView:UITableView)->UIView {
        let headerView = UIView.init(frame: CGRect.init(x: Constant.tableviewHeaderXY, y: Constant.tableviewHeaderXY, width: tableView.frame.width, height: Constant.tableviewHeaderHeight))
        headerView.backgroundColor = UIColor(named: "Background 4")
        return headerView
    }
    
    func labelForTableViewHeader(headerView:UIView) -> UILabel {
        let headerTitle = UILabel()
        let x: CGFloat = 21
        let y: CGFloat = 25.33
        let width: CGFloat = headerView.frame.width-20
        let height: CGFloat = headerView.frame.height-20
        
        headerTitle.frame = CGRect.init(x: x, y: y, width: width, height: height)
        headerTitle.textColor = UIColor(named: Constant.labelColor)
        headerTitle.backgroundColor = .clear
        headerTitle.font = UIFont(name: Constant.cabinFont, size: Constant.fontSize19)
        return headerTitle
    }
}

//MARK:- UITABLEVIEW DELEGATES AND DATASOURCE METHOD'S
extension SelectedBarDetailViewController:UITableViewDelegate,UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y <= 0.0{
            if !isShowMore && !isScrollTop{
                isScrollTop = true
                mapHeight = self.BarDetailTableView.frame.height
                self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
            else{
                
                //isScrollTop = false
                //self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .automatic)
            }
            
        }
        if let indexPath = self.BarDetailTableView.indexPathsForVisibleRows?.last{
            if indexPath.section == 0 || indexPath.section == 1{
                self.navigationController?.navigationBar.isHidden = false
            }
            else if indexPath.section == 3{
                self.navigationController?.navigationBar.isHidden = false
            }
        }
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("ttt:\(scrollView.contentOffset.y)")
        if scrollView.contentOffset.y <= 0.0{
            self.dismiss(animated: true){
                
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if isShowMore{
            return headers_Array2.count
        }else{
            return self.headers_Array1.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = headerForTableView(tableView: tableView)
        let headerTitle = labelForTableViewHeader(headerView: headerView)
        
        if isShowMore{
            headerTitle.text = self.headers_Array2[section]
        }else{
            headerTitle.text = self.headers_Array1[section]
        }
        headerView.addSubview(headerTitle)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1{
            return 0
        }else{
            if isShowMore{
                if section != self.headers_Array2.count - 1{
                    return 60
                }
                else{
                    return 0
                }
                
            }else{
                return 0
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return self.MainCategoryTitle.count
        }
        else{
            if isShowMore{
                if section != self.headers_Array2.count - 1{
                    return self.MainCategoryImages.count
                }
                else{
                    return 1
                }
                
            }else{
                return 1
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return UITableView.automaticDimension
        }
        else{
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MapTableViewCell
//            cell.selectedBackgroundView?.backgroundColor = .clear
//
//            cell.Mapbox.delegate = self
//            //cell.Mapbox.showsUserLocation = false
//            cell.Mapbox.showsUserHeadingIndicator = true
//            cell.Mapbox.compassView.isHidden = true
//            cell.Mapbox.logoView.isHidden = true
//            cell.Mapbox.attributionButton.isHidden = true
//            if cell.Mapbox.tag != 1 {
//                cell.Mapbox.tag = 1
//                cell.Mapbox.userTrackingMode = .follow
//            }
//            let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
//            for recognizer in cell.Mapbox.gestureRecognizers! where recognizer is UITapGestureRecognizer {
//            singleTap.require(toFail: recognizer)
//            }
//            cell.Mapbox.addGestureRecognizer(singleTap)
//            return cell
//        }else
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.barDetailTableViewCell) as! BarDetailTableViewCell
            cell.selectedBackgroundView?.backgroundColor = .clear
            cell.lblName.text = self.selectedAnnotation.title
            cell.vImage.image = UIImage(named: self.selectedAnnotation.barImage)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.mainCategoryTableViewCell) as! MainCategoryTableViewCell
            cell.ProductImage.image = UIImage(named: self.MainCategoryImages[indexPath.row])
            cell.ProductNameLabel.text = self.MainCategoryTitle[indexPath.row]
            cell.selectedBackgroundView?.backgroundColor = .clear
            return cell
        } else {
            if isShowMore {
                if indexPath.section != headers_Array2.count - 1{
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constant.otherCategoryTableViewCell) as! OtherCategoryTableViewCell
                    cell.ProductImage.image = UIImage(named: self.MainCategoryImages[indexPath.row])
                    cell.ProductNameLabel.text = self.MainCategoryTitle[indexPath.row]
                    cell.selectedBackgroundView?.backgroundColor = .clear
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
                    cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
                    cell.TitleLabel.text = "Show less"
                    cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector3"), for: .normal)
                    cell.selectedBackgroundView?.backgroundColor = .clear
                    return cell
                }
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
                cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
                cell.TitleLabel.text = "Show More"
                cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector2"), for: .normal)
                cell.selectedBackgroundView?.backgroundColor = .clear
                return cell
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    @objc func showMoreBtnAction(_ sender: UIButton){
        if isShowMore {
            isShowMore = false
        }else{
            isShowMore = true
        }
        self.BarDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 2), at: .bottom, animated: true)
        self.BarDetailTableView.reloadData()
        
    }
}
// MARK:- LOCATION METHOD'S EXTENSION
extension SelectedBarDetailViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        self.myLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
//        let camera = GMSCameraPosition.camera(
//            withLatitude: location.coordinate.latitude,
//            longitude: location.coordinate.longitude,
//            zoom: zoomLevel
//        )
//        self.MapView.camera = camera
//        self.MapView.animate(to: camera)
        
        //Change current/my location icon
        //        userLocationMarker = GMSMarker(position: location.coordinate)
        //        userLocationMarker.icon = UIImage(named: "Me")
        //        userLocationMarker.rotation = CLLocationDegrees(m)
       // userLocationMarker.map = self.MapView
        //self.placeMarkOnGoogleMap(location: location)
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            UserDefaults.standard.set(false, forKey: Constant.locationAccessKey)
            // Display the map using the default location.
            PopupHelper.alertWithAppSetting(title: "Alert", message: "Please enable your location", controler: self)
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways:
            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
        case .authorizedWhenInUse:
            print("Location status is OK.")
            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
        @unknown default:
            print("Unknown case found")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    //    //MARK: CHANGE CURRENT LOCATION ICON DEGREE FOR ROUTATION
    //    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    //        let direction = -newHeading.trueHeading as Double
    //        userLocationMarker.icon = self.imageRotatedByDegrees(degrees: CGFloat(direction), image: UIImage(named: "Me")!)
    //    }
    //
    //    func imageRotatedByDegrees(degrees: CGFloat, image: UIImage) -> UIImage{
    //        let size = image.size
    //
    //        UIGraphicsBeginImageContext(size)
    //        let context = UIGraphicsGetCurrentContext()
    //
    //        context!.translateBy(x: 0.5*size.width, y: 0.5*size.height)
    //        context!.rotate(by: CGFloat(DegreesToRadians(degrees: Double(degrees))))
    //
    //        image.draw(in: CGRect(origin: CGPoint(x: -size.width*0.5, y: -size.height*0.5), size: size))
    //        let newImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //
    //        return newImage!
    //    }
    //
    //    func setLatLonForDistanceAndAngle(userLocation: CLLocation) -> Double {
    //        let lat1 = DegreesToRadians(degrees: userLocation.coordinate.latitude)
    //        let lon1 = DegreesToRadians(degrees: userLocation.coordinate.longitude)
    //
    //        let lat2 = DegreesToRadians(degrees: 37.7833);
    //        let lon2 = DegreesToRadians(degrees: -122.4167);
    //
    //        let dLon = lon2 - lon1;
    //
    //        let y = sin(dLon) * cos(lat2);
    //        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    //        var radiansBearing = atan2(y, x);
    //        if(radiansBearing < 0.0)
    //        {
    //            radiansBearing += 2*M_PI;
    //        }
    //
    //        return radiansBearing;
    //    }
}
