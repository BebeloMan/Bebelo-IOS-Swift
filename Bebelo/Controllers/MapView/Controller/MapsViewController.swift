//
//  MapsViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 30/07/2021.
//

//import UIKit
//
//import Mapbox
//import MapboxMobileEvents
//
//import DKChainableAnimationKit
//class MapsViewController: UIViewController,MGLMapViewDelegate {
//    
//    //IBOUTLET'S
//    @IBOutlet weak var Mapbox: MGLMapView!
//    @IBOutlet weak var BarDetailTableView: UITableView!
//    @IBOutlet weak var tableHeight: NSLayoutConstraint!
//    @IBOutlet weak var vNav: UIView!
//    @IBOutlet weak var vNav1: UIView!
//    var annotaionArray = [AnnotationModel]()
//    var barArray = [UserModelW]()
//    var selectedAnnotation:AnnotationModel!
//    var selectedBar:UserModelW!
//    var drinkPriceArray: [DrinkPricesModelW]!
//    var drinkOtherArray:[DrinkPrices1ModelW]!
//    var barData:BarModelW!
//    //ARRAY'S
////    let headers_Array1 = [
////        "",
////        "",
////        "",
////        "",
////        "",
////        "",
////        ""
////    ]
////    let headers_Array11 = [
////        "",
////        "",
////        "",
////        "",
////        ""
////    ]
////    let headers_Array2 = [
////        "",
////        "",
////        "",
////        "",
////        "",
////        "Cerveza",
////        "copas",
////        "high rollar",
////        "copas",
////        ""
////    ]
////    let headers_Array22 = [
////        "",
////        "",
////        "",
////        "",
////        "Cerveza",
////        "copas",
////        "high rollar",
////        "copas",
////        ""
////    ]
////    let MainCategoryImages = [
////        "Bombay",
////        "Havanna",
////        "Jameson"
////    ]
////    let SubCategoryImages = ["Bombays","Bombays1","Bombays"]
////    let MainCategoryTitle = [
////        "Bombay Sapphire",
////        "Havanna Club",
////        "Jameson"
////    ]
//    
//    //CONSTANT'S
//    let ShowBarSegue = "ShowBar"
//    let distanceFilter: CLLocationDistance = 50
//    //VARIABLE'S
//    var isBarItemHide = false
//    //var delegate:MapViewController!
//    var isPreviousClose = false
//    var mapHeight:CGFloat = 0
//    var myLocation = CLLocationCoordinate2D()
//    var locationManager = CLLocationManager()
//    var isShowMore = false
//    var isBarShow = false
//    var isScrollTop = false
//    var zoomLevel: Float = 14.0
//    var isMapLoading = false
//    var delegate = MapViewController()
//    var viewTranslation = CGPoint(x: 0, y: 0)
//    var viewOrigin = CGPoint(x: 0, y: 0)
//    var height:CGFloat = 0
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.userLocationSetup()
//        self.Mapbox.delegate = self
//        //cell.Mapbox.showsUserLocation = false
//        self.Mapbox.showsUserHeadingIndicator = true
//        self.Mapbox.compassView.isHidden = true
//        self.Mapbox.logoView.isHidden = true
//        self.Mapbox.attributionButton.isHidden = true
//        self.Mapbox.userTrackingMode = .follow
//        self.Mapbox.allowsTilting = false
//        //cell.Mapbox.camera.centerCoordinate = self.selectedAnnotation.location
//        self.Mapbox.setCenter(self.selectedAnnotation.location, zoomLevel: Double(self.zoomLevel), animated: true)
//        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
//        for recognizer in self.Mapbox.gestureRecognizers! where recognizer is UITapGestureRecognizer {
//        singleTap.require(toFail: recognizer)
//        }
//        self.Mapbox.addGestureRecognizer(singleTap)
//        
//        self.loadAllDrinks()
//        self.loadData()
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        if isBarShow{
//            //self.vNav.isHidden = true
//            //self.vNav1.isHidden = true
//            //self.tableHeight.constant = UIScreen.main.bounds.height
//            //self.BarDetailTableView.cornerRadius = 0
//            //self.isBarShow = true
//            //self.BarDetailTableView.reloadData()
//            //self.BarDetailTableView.isScrollEnabled = true
//            //self.viewDidLayoutSubviews()
//        }
//        else{
//            self.tableHeight.constant = UIScreen.main.bounds.height/2.2
//            //hideOrUnhideNavItems()
//            self.vNav.isHidden = true
//            self.vNav1.isHidden = true
//            //self.navigationController?.navigationBar.shadowImage = UIImage()
//            self.BarDetailTableView.drawCorner(roundTo: .top)
//            self.isBarShow = false
//            self.BarDetailTableView.isScrollEnabled = false
//            self.BarDetailTableView.cornerRadius = 25
//            self.BarDetailTableView.reloadData()
//        }
//        
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if isBarShow{
//            
//            //self.navigationController?.navigationBar.isHidden = false
//            //self.tableHeight.constant = UIScreen.main.bounds.height - (self.navigationController!.navigationBar.frame.height + UIApplication.shared.statusBarFrame.height - 2)
//            
//        }
//        //self.viewOrigin = self.BarDetailTableView.frame.origin
//        //self.height = self.BarDetailTableView.frame.origin.y
//        self.Mapbox.setCenter(self.selectedAnnotation.location, zoomLevel: Double(self.zoomLevel), animated: true)
//        
//    }
//    func loadAllDrinks(){
//        
//        self.drinkPriceArray = [
//            DrinkPricesModelW(drinkName: .Tanqueray, drinkImage: "dd1"),
//            DrinkPricesModelW(drinkName: .Beefeater, drinkImage: "dd2"),
//            DrinkPricesModelW(drinkName: .Brugal, drinkImage: "dd3")
//            ]
//        self.drinkOtherArray = [
//            DrinkPrices1ModelW(drinkCategory: "Beer", drinks: [
//                DrinkPricesModelW(drinkName: .Caña , drinkImage: "d4"),
//                DrinkPricesModelW(drinkName: .Doble, drinkImage: "d5")
//            ]),
//            DrinkPrices1ModelW(drinkCategory: "Normales", drinks: [
//                DrinkPricesModelW(drinkName: .Tanqueray, drinkImage: "d1"),
//                DrinkPricesModelW(drinkName: .Beefeater, drinkImage: "d2"),
//                DrinkPricesModelW(drinkName: .Brugal, drinkImage: "d3"),
//                DrinkPricesModelW(drinkName: .Seagram_s, drinkImage: "d6"),
//                DrinkPricesModelW(drinkName: .Bombay_Sapphire , drinkImage: "d7"),
//                DrinkPricesModelW(drinkName: .Barceló , drinkImage: "d8"),
//                DrinkPricesModelW(drinkName: .Santa_Teresa , drinkImage: "d9"),
//                DrinkPricesModelW(drinkName: .Cacique , drinkImage: "d10"),
//                DrinkPricesModelW(drinkName: .Captain_Morgan , drinkImage: "d11"),
//                DrinkPricesModelW(drinkName: .Johnnie_Walker_Red , drinkImage: "d12"),
//                DrinkPricesModelW(drinkName: .J_n_B , drinkImage: "d13"),
//                DrinkPricesModelW(drinkName: .Absolut , drinkImage: "d14"),
//            ]),
//            DrinkPrices1ModelW(drinkCategory: "High roller", drinks: [
//                DrinkPricesModelW(drinkName: .Nordés , drinkImage: "d15"),
//                DrinkPricesModelW(drinkName: .Bulldog , drinkImage: "d16"),
//                DrinkPricesModelW(drinkName: .Hendrick_s , drinkImage: "d17"),
//                DrinkPricesModelW(drinkName: .Martin_Miller_s , drinkImage: "d18"),
//                DrinkPricesModelW(drinkName: .Brockman_s , drinkImage: "d19"),
//                DrinkPricesModelW(drinkName: .Havana_Club_7 , drinkImage: "d20"),
//                DrinkPricesModelW(drinkName: .Johnnie_Walker_Black , drinkImage: "d21"),
//                DrinkPricesModelW(drinkName: .Jack_Daniel_s , drinkImage: "d22"),
//                DrinkPricesModelW(drinkName: .Grey_Goose , drinkImage: "d23"),
//                DrinkPricesModelW(drinkName: .Belvedere , drinkImage: "d24"),
//            ]),
//            DrinkPrices1ModelW(drinkCategory: "War time", drinks: [
//                DrinkPricesModelW(drinkName: .Larios , drinkImage: "d25"),
//                DrinkPricesModelW(drinkName: .Negrita , drinkImage: "d26"),
//                DrinkPricesModelW(drinkName: .Dyc , drinkImage: "d27")
//            ])
//            ]
//        
//    }
//    func loadData(){
//        if let barData = self.selectedBar{
//            
//            do{
//                let jsonDecoder = JSONDecoder()
//                let data1 = barData.bdetail.data(using: .utf8)
//                let bar = try jsonDecoder.decode(BarModelW.self, from: data1!)
//                self.barData = bar
//                if let drinkArray = bar.barBottle{
//                    self.drinkPriceArray.forEach { drinkPricesModel in
//                        for drink in drinkArray{
//                            if drinkPricesModel.drinkName == drink.drinkName{
//                                drinkPricesModel.drinkPrice = drink.drinkPrice
//                                drink.drinkPrice = nil
//                                break
//                            }
//                        }
//                    }
//                    self.drinkOtherArray.forEach { drinkPrices1Model in
//                        loop: for drinkPrices in drinkPrices1Model.drinks{
//                            for drinks in drinkArray{
//                                if drinks.drinkName == drinkPrices.drinkName{
//                                    drinkPrices.drinkPrice = drinks.drinkPrice
//                                }
//                            }
//                        }
//                    }
//                    for coordinate in self.annotaionArray {
//                    let point = MGLPointAnnotation()
//                        point.coordinate = coordinate.location
//                        point.title = coordinate.title
//                        point.accessibilityHint = coordinate.image
//                        point.subtitle = coordinate.price
//                        let anno = self.Mapbox.annotations?.first(where: { annotation in
//                            guard let ann = annotation as? MGLPointAnnotation else {return false}
//                            return ann.title == coordinate.title
//                        })
//                        if anno == nil{
//                            self.Mapbox.addAnnotation(point)
//                        }
//                        
//                    }
//                }
//                
//            }
//            catch let error{
//                PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
//                PopupHelper.stopAnimating(controler: self)
//                return
//            }
//        }
//        self.drinkPriceArray.removeAll { drinkPricesModel in
//            return drinkPricesModel.drinkPrice == "0" || drinkPricesModel.drinkPrice == nil
//        }
//        self.drinkOtherArray.removeAll { drinkPrices1Model in
//            drinkPrices1Model.drinks.removeAll(where: { drinkPricesModel in
//                return drinkPricesModel.drinkPrice == "0" || drinkPricesModel.drinkPrice == nil
//            })
//            return drinkPrices1Model.drinks.count == 0
//        }
//        self.BarDetailTableView.reloadData()
//    }
//    @IBAction func OptionBtnAction(_ sender: Any) {
//        let optionView = self.getViewController(identifier: "MenuOptionViewController") as! MenuOptionViewController
//        //optionView.delegate = self
//        //optionView.modalPresentationStyle = .fullScreen
//        //self.tabBarController?.present(optionView, animated: false, completion: nil)
//        self.present(optionView, animated: false, completion: nil)
//    }
//    @IBAction func backBtnAction(_ sender: Any) {
//        self.vNav.isHidden = true
//        self.vNav1.isHidden = true
//        self.BarDetailTableView.animation.moveY(300).animateWithCompletion(0.1) {
//        
//        self.isBarShow = false
//        self.isShowMore = false
//        self.tableHeight.constant = UIScreen.main.bounds.height/2.2
//        //self.BarDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        self.BarDetailTableView.reloadData()
//        self.BarDetailTableView.isScrollEnabled = false
//        self.BarDetailTableView.cornerRadius = 25
//        }
//    }
//    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
//        let translation = sender.location(in: view)
//        let translation1 = sender.velocity(in: view)
//        switch sender.state {
//        case .changed:
//            
//            print("location: \(translation.y)")
//            print("velocity: \(translation1.y)")
//            guard translation.y <= self.height else { return }
////            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
////                //self.BarDetailTableView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
////                self.tableHeight.constant = self.viewTranslation.y
////            })
////            if sender.velocity(in: self.view).y < -400{
////                self.showfullview(sender)
////                return
////            }
////            self.tableHeight.constant =  self.view.frame.height - translation.y
////            if translation.y < 50{
////                //self.showfullviewAction(sender)
////                self.navigationController?.navigationBar.isHidden = false
////                self.isBarShow = true
////                self.BarDetailTableView.reloadData()
////                self.BarDetailTableView.isScrollEnabled = true
////
////            }
////            else if translation.y > self.view.frame.height - 200 {
////                self.dismiss(animated: true, completion: nil)
////            }
////            else{
////                self.navigationController?.navigationBar.isHidden = true
////                self.isBarShow = false
////                self.BarDetailTableView.reloadData()
////                self.BarDetailTableView.isScrollEnabled = false
////
////            }
//        case .ended:
//            
//            if sender.velocity(in: self.view).y < -400{
//                self.showfullview(sender)
//                return
//            }
//            if translation.y < 50{
//                //self.showfullviewAction(sender)
//                self.vNav.isHidden = false
//                self.vNav1.isHidden = false
//                self.isBarShow = true
//                self.BarDetailTableView.reloadData()
//                self.BarDetailTableView.isScrollEnabled = true
//            }
//            else if translation.y > self.view.frame.height - 200 {
//                self.dismiss(animated: true, completion: nil)
//            }
//            else{
//                self.vNav.isHidden = true
//                self.vNav1.isHidden = true
//                
//                self.isBarShow = false
//                self.BarDetailTableView.reloadData()
//                self.BarDetailTableView.isScrollEnabled = false
//            }
////            if viewTranslation.y < 200 {
////                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
////                    self.view.transform = .identity
////                })
////            } else {
////                dismiss(animated: true, completion: nil)
////            }
//        default:
//            break
//        }
//    }
//    @objc func showfullview(_ sender:Any){
//        self.BarDetailTableView.animation.makeHeight(UIScreen.main.bounds.height).moveY(-150).animateWithCompletion(0.05) {
//            
//            self.vNav.isHidden = false
//            self.vNav1.isHidden = false
//            self.tableHeight.constant = UIScreen.main.bounds.height - (self.vNav.frame.height - 2)
//            self.BarDetailTableView.cornerRadius = 0
//            self.isBarShow = true
//            self.BarDetailTableView.reloadData()
//            self.BarDetailTableView.isScrollEnabled = true
//        }
//        
//        
//        
//    }
//    @IBAction func showfullviewAction(_ sender: Any) {
//        //self.BarDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        self.tableHeight.constant = self.height
//        let navoptionView = self.getViewController(identifier: "NavSelectedBarDetailViewController") as! UINavigationController
//        
//        let optionView = self.getViewController(identifier: "SelectedBarDetailViewController") as! SelectedBarDetailViewController
//        optionView.delegate = self
//        optionView.selectedAnnotation = self.selectedAnnotation
//        navoptionView
//            .setViewControllers([optionView], animated: true)
//        navoptionView.modalPresentationStyle = .fullScreen
//        self.present(navoptionView, animated: true, completion: nil)
//    }
//    func userLocationSetup() {
//        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.distanceFilter = distanceFilter
//        locationManager.startUpdatingLocation()
//        locationManager.startUpdatingHeading()
//        locationManager.delegate = self
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let controller = segue.destination as? SelectedBarProfileViewController{
//            controller.delegate = self
//            //controller.delegate1 = self
//        }
//        if let controller = segue.destination as? SelectedBarDetailViewController{
//            controller.delegate = self
//            controller.selectedAnnotation = self.selectedAnnotation
//        }
//    }
//    
//}
//
////MARK:- Delegate Method's
//extension MapsViewController{
//    
//    func bardeatail(){
//        // Delegate methods which call My Bar Profile view controller
//        self.performSegue(withIdentifier: ShowBarSegue, sender: nil)
//    }
//    
//}
////MARK:- MAPBOX DELEGATES
//extension MapsViewController {
//    
//    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
//        
////        for (ii,i) in self.annotaionArray.enumerated(){
////            // Create point to represent where the symbol should be placed
////            let point = MGLPointFeature()
////            //var val = Double(i)
////            //val = val/100
////            //point.coordinate = CLLocationCoordinate2D(latitude: self.myLocation.latitude + val, longitude: self.myLocation.longitude + val)
////            //let cord = generateRandomCoordinates(250, max: 500,location: self.myLocation)
////            point.coordinate = i.location
////            point.identifier = i.title
////            // Create a data source to hold the point data
////            let shapeSource = MGLShapeSource(identifier: i.identifier, shape: point, options: nil)
////
////            // Create a style layer for the symbol
////            let shapeLayer = MGLSymbolStyleLayer(identifier: i.identifier1, source: shapeSource)
////            //shapeSource.performSelector(inBackground: #selector(self.tapAnotation(_:)), with: self)
////
////            // Add the image to the style's sprite
////            if let image = UIImage(named: i.image) {
////                style.setImage(image, forName: i.image)
////            }
////            style.setImage(UIImage(named: i.image)!, forName: i.image)
////            // Tell the layer to use the image in the sprite
////            shapeLayer.iconImageName = NSExpression(forConstantValue: i.image)
////            shapeLayer.text = NSExpression(forConstantValue: i.price)
////            shapeLayer.textFontSize = NSExpression(forConstantValue: 13)
////            shapeLayer.textFontNames = NSExpression(forConstantValue: ["Roboto Bold","Roboto Bold"])
////            // Add the source and style layer to the map
////            style.addSource(shapeSource)
////            style.addLayer(shapeLayer)
////            shapeLayer.accessibilityHint = "\(ii)"
////            shapeSource.accessibilityHint = "\(ii)"
////            style.accessibilityHint = "\(ii)"
////            point.accessibilityHint = "\(ii)"
////        }
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
//    @objc @IBAction func handleMapTap(sender: UITapGestureRecognizer) {
//        
//        if sender.state == .ended {
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
//        // This example is only concerned with point annotations.
//        guard let annotion = annotation as? MGLPointAnnotation else {
//            return nil
//        }
//        
//        // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
//        let reuseIdentifier = "\(annotion.coordinate.longitude)"
//        
//        // For better performance, always try to reuse existing annotations.
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
//        
//        // If there’s no reusable annotation view available, initialize a new one.
//        if annotationView == nil {
//            annotationView = BarAnnotationView(reuseIdentifier: reuseIdentifier, image: UIImage(named: annotion.accessibilityHint ?? "") ?? UIImage(), title: annotion.subtitle ?? "")
//        }
//        
//        return annotationView
//    }
//    func mapView(_ mapView: MGLMapView, didSelect annotationView: MGLAnnotationView) {
//        
//        //let touchLocation = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
//        let anotaion = self.annotaionArray.first { annotationModel in
//            return "\(annotationModel.location.longitude)" == annotationView.reuseIdentifier
//        }
//        let bar = self.barArray.first { barModel in
//            return barModel.bname == anotaion?.title
//        }
//        mapView.fly(to: mapView.camera) {
//            self.selectedAnnotation = anotaion
//            self.selectedBar = bar
//            self.BarDetailTableView.reloadData()
//        }
//        
//    }
//    
//}
//
////MARK:- HELPING METHOD'S
//extension MapsViewController{
//
//    func getViewController(identifier:String)-> UIViewController {
//        let vc = UIStoryboard.init(name: Constant.mainStoryboard, bundle: Bundle.main).instantiateViewController(identifier: identifier)
//        return vc
//    }
//    
//    func headerForTableView(tableView:UITableView)->UIView {
//        let headerView = UIView.init(frame: CGRect.init(x: Constant.tableviewHeaderXY, y: Constant.tableviewHeaderXY, width: tableView.frame.width, height: Constant.tableviewHeaderHeight))
//        headerView.backgroundColor = UIColor(named: "TableCell")
//        return headerView
//    }
//    
//    func labelForTableViewHeader(headerView:UIView) -> UILabel {
//        let headerTitle = UILabel()
//        let x: CGFloat = 21
//        let y: CGFloat = 10
//        let width: CGFloat = headerView.frame.width-20
//        let height: CGFloat = headerView.frame.height-20
//        
//        headerTitle.frame = CGRect.init(x: x, y: y, width: width, height: height)
//        headerTitle.textColor = UIColor(named: Constant.labelColor)
//        headerTitle.backgroundColor = .clear
//        headerTitle.font = UIFont(name: Constant.cabinFont, size: Constant.fontSize19)
//        return headerTitle
//    }
//    func labelForTableViewHeader1(headerView:UIView) -> UILabel {
//        let headerTitle = UILabel()
//        let x: CGFloat = 21
//        let y: CGFloat = 5
//        let width: CGFloat = headerView.frame.width-40
//        let height: CGFloat = headerView.frame.height-20
//        
//        headerTitle.frame = CGRect.init(x: x, y: y, width: width, height: height)
//        headerTitle.textColor = UIColor(named: Constant.labelColor)
//        headerTitle.backgroundColor = .clear
//        headerTitle.font = UIFont(name: Constant.cabinRFont, size: Constant.fontSize12)
//        headerTitle.textAlignment = .right
//        return headerTitle
//    }
//}
//
////MARK:- UITABLEVIEW DELEGATES AND DATASOURCE METHOD'S
//extension MapsViewController:UITableViewDelegate,UITableViewDataSource {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.y)
//        if scrollView.contentOffset.y <= 0.0 || scrollView.contentOffset.y < self.vNav.frame.height{
//            
////            self.BarDetailTableView.animation.moveY(20).animateWithCompletion(0.05) {
////
////            }
//            self.vNav.isHidden = false
//            self.vNav1.isHidden = false
//            self.tableHeight.constant = UIScreen.main.bounds.height - (self.vNav.frame.height - 2)
//        }else if scrollView.contentOffset.y >= self.vNav.frame.height{
////            self.BarDetailTableView.animation.moveY(-20).animateWithCompletion(0.05) {
////
////            }
//            self.vNav.isHidden = true
//            self.vNav1.isHidden = true
//            self.tableHeight.constant = UIScreen.main.bounds.height// + self.vNav.frame.height
//            
//        }
//        
//        
//    }
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        print("ttt:\(scrollView.contentOffset.y)")
//        if scrollView.contentOffset.y <= 0.0{
//            
//        }
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if isBarShow{
//            if isShowMore{
//                return self.drinkPriceArray.count + self.drinkOtherArray.count + 2
//            }else{
//                return self.drinkPriceArray.count + 2
//            }
//        }
//        else{
//            return self.drinkPriceArray.count + 3
//        }
//        
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = headerForTableView(tableView: tableView)
//        let headerTitle = labelForTableViewHeader(headerView: headerView)
//        if isBarShow{
//            if isShowMore{
//                switch section {
//                case 0,1,2,3:
//                    headerTitle.text = ""
//                case 4:
//                    if let bar = self.barData,let isSupliment = bar.barSupliment{
//                        
//                        if !isSupliment.isSupliment{
//                            let headerTitle1 = labelForTableViewHeader1(headerView: headerView)
//                            headerTitle1.text = "Suplemento terraza:\(isSupliment.rate!)\(isSupliment.type!)"
//                            headerView.addSubview(headerTitle1)
//                        }
//                        else if let hasterrace = bar.barHas.first{
//                            if hasterrace.isSelected{
//                                let headerTitle1 = labelForTableViewHeader1(headerView: headerView)
//                                headerTitle1.text = "No suplemento en terraza"
//                                headerView.addSubview(headerTitle1)
//                            }
//                        }
//                    }
//                    switch self.drinkOtherArray.count {
//                    case 1:
//                        
//                        headerTitle.text = self.drinkOtherArray[section - 4].drinkCategory.localized()
//                    case 2:
//                        headerTitle.text = self.drinkOtherArray[section - 4].drinkCategory.localized()
//                    case 3:
//                        headerTitle.text = self.drinkOtherArray[section - 4].drinkCategory.localized()
//                    case 4:
//                        headerTitle.text = self.drinkOtherArray[section - self.drinkOtherArray.count].drinkCategory.localized()
//                    default:
//                        headerTitle.text = ""
//                    }
//                    
//                case 5:
//                    
//                    switch self.drinkOtherArray.count {
//                    case 2:
//                        headerTitle.text = self.drinkOtherArray[section - 4].drinkCategory.localized()
//                    case 3:
//                        headerTitle.text = self.drinkOtherArray[section - 4].drinkCategory.localized()
//                    case 4:
//                        headerTitle.text = self.drinkOtherArray[section - self.drinkOtherArray.count].drinkCategory.localized()
//                    default:
//                        headerTitle.text = ""
//                    }
//                case 6:
//                    
//                    switch self.drinkOtherArray.count {
//                    
//                    case 3:
//                        headerTitle.text = self.drinkOtherArray[section - 4].drinkCategory.localized()
//                    case 4:
//                        headerTitle.text = self.drinkOtherArray[section - self.drinkOtherArray.count].drinkCategory.localized()
//                    default:
//                        headerTitle.text = ""
//                    }
//                case 7:
//                    switch self.drinkOtherArray.count {
//                    case 4:
//                        headerTitle.text = self.drinkOtherArray[section - self.drinkOtherArray.count].drinkCategory.localized()
//                    default:
//                        headerTitle.text = ""
//                        
//                    }
//                default:
//                    headerTitle.text = ""
//                    if let bar = self.barData,let isSupliment = bar.barSupliment{
//                        
//                        if !isSupliment.isSupliment{
//                            let headerTitle1 = labelForTableViewHeader1(headerView: headerView)
//                            headerTitle1.text = "Suplemento terraza:\(isSupliment.rate!)\(isSupliment.type!)"
//                            headerView.addSubview(headerTitle1)
//                        }
//                        else if let hasterrace = bar.barHas.first{
//                            if hasterrace.isSelected{
//                                let headerTitle1 = labelForTableViewHeader1(headerView: headerView)
//                                headerTitle1.text = "No suplemento en terraza"
//                                headerView.addSubview(headerTitle1)
//                            }
//                        }
//                    }
//                }
//                
//            }else{
//                headerTitle.text = ""
//                switch section {
//                case 4:
//                    if let bar = self.barData,let isSupliment = bar.barSupliment{
//                        
//                        if !isSupliment.isSupliment{
//                            let headerTitle1 = labelForTableViewHeader1(headerView: headerView)
//                            headerTitle1.text = "Suplemento terraza:\(isSupliment.rate!)\(isSupliment.type!)"
//                            headerView.addSubview(headerTitle1)
//                        }
//                        else if let hasterrace = bar.barHas.first{
//                            if hasterrace.isSelected{
//                                let headerTitle1 = labelForTableViewHeader1(headerView: headerView)
//                                headerTitle1.text = "No suplemento en terraza"
//                                headerView.addSubview(headerTitle1)
//                            }
//                        }
//                    }
//                default:
//                    break
//                }
//            }
//        }
//        else{
//            headerTitle.text = ""
//        }
//        
//        headerView.addSubview(headerTitle)
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if isBarShow{
//            if isShowMore{
//                switch section {
//                case 0:
//                    return 0
//                case 1,2,3:
//                    return 35
//                    
//                case 4:
//                    switch self.drinkOtherArray.count {
//                    case 1:
//                        return 50
//                    case 2:
//                        return 50
//                    case 3:
//                        return 50
//                    case 4:
//                        return 50
//                    default:
//                        return 20
//                    }
//                    
//                case 5:
//                    switch self.drinkOtherArray.count {
//                    
//                    case 2:
//                        return 50
//                    case 3:
//                        return 50
//                    case 4:
//                        return 50
//                    default:
//                        return 20
//                    }
//                case 6:
//                    switch self.drinkOtherArray.count {
//                    case 3:
//                        return 50
//                    case 4:
//                        return 50
//                    default:
//                        return 20
//                    }
//                case 7:
//                    switch self.drinkOtherArray.count {
//                    case 4:
//                        return 50
//                    default:
//                        return 20
//                    }
//                default:
//                    return 0
//                }
//            }
//            else{
//                switch section {
//                case 0:
//                    return 0
//                case 1,2,3:
//                    return 35
//                default:
//                    return 20
//                }
//            }
//        }
//        else{
//            switch section {
//            case 0:
//                return 0
//            case 1:
//                return 10
//            case 2,3,4:
//                return 35
//            default:
//                return 0
//            }
//        }
//        
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isBarShow{
//            if isShowMore{
//                switch section {
//                case 0,1,2,3:
//                    return 1
//                case 4:
//                    switch self.drinkOtherArray.count {
//                    case 1:
//                        return self.drinkOtherArray[section - 4].drinks.count
//                    case 2:
//                        return self.drinkOtherArray[section - 4].drinks.count
//                    case 3:
//                        return self.drinkOtherArray[section - 4].drinks.count
//                    case 4:
//                        return self.drinkOtherArray[section - self.drinkOtherArray.count].drinks.count
//                    default:
//                        return 1
//                    }
//                    
//                case 5:
//                    switch self.drinkOtherArray.count {
//                    case 2:
//                        return self.drinkOtherArray[section - 4].drinks.count
//                    case 3:
//                        return self.drinkOtherArray[section - 4].drinks.count
//                    case 4:
//                        return self.drinkOtherArray[section - self.drinkOtherArray.count].drinks.count
//                    default:
//                        return 1
//                    }
//                case 6:
//                    switch self.drinkOtherArray.count {
//                    case 3:
//                        return self.drinkOtherArray[section - 4].drinks.count
//                    case 4:
//                        return self.drinkOtherArray[section - self.drinkOtherArray.count].drinks.count
//                    default:
//                        return 1
//                    }
//                case 7:
//                    switch self.drinkOtherArray.count {
//                    case 4:
//                        return self.drinkOtherArray[section - self.drinkOtherArray.count].drinks.count
//                    default:
//                        return 1
//                    }
//                default:
//                    return 1
//                }
//            }else{
//                return 1
//            }
//        }
//        else{
//            return 1
//        }
//        
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if isBarShow{
//            if indexPath.section == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.barDetailTableViewCell) as! BarDetailTableViewCell
//                cell.selectedBackgroundView?.backgroundColor = .clear
//                cell.lblName.text = self.selectedAnnotation.title
//                if let bdetail = self.selectedBar.bdetail{
//                    do{
//                        let jsonDecoder = JSONDecoder()
//                        let data1 = bdetail.data(using: .utf8)
//                        let bar = try jsonDecoder.decode(BarModelW.self, from: data1!)
//                        let timing = calculateTiming(data: bar.barWeekDay)
//                        cell.lblOpen.text = timing.0
//                        cell.lblTime.text = timing.1
//                        cell.lblOpen.textColor = timing.2
//                    }
//                    catch let erro{
//                        print(erro.localizedDescription)
//                    }
//                }
//                cell.timingStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showTimingBtnAction(_:))))
//                cell.timingStack.isUserInteractionEnabled = false
//                let placeholdr = #imageLiteral(resourceName: "Image")
//                if let imgstr = self.selectedAnnotation.image1{
//                    if let url = URL(string: imgstr){
//                        cell.vImage.af.setImage(withURL: url, placeholderImage: placeholdr, imageTransition: .crossDissolve(0), runImageTransitionIfCached: true)
//                    }
//                    else{
//                        cell.vImage.image = placeholdr
//                    }
//                }
//                else{
//                    cell.vImage.image = placeholdr
//                }
//                for gestr in cell.gestureRecognizers ?? []{
//                    cell.removeGestureRecognizer(gestr)
//                }
//                switch self.selectedAnnotation.announce {
//                case .None:
//                    cell.lblAnnounce.isHidden = true
//                    cell.ivAnnounce.isHidden = true
//                    cell.lblTable.isHidden = true
//                    cell.ivTable.isHidden = true
//                    cell.ivBaja.isHidden = true
//                case .Announcement:
//                    cell.lblAnnounce.isHidden = false
//                    cell.ivAnnounce.isHidden = false
//                    cell.lblTable.isHidden = true
//                    cell.ivTable.isHidden = true
//                    cell.ivBaja.isHidden = false
//                    
//                    cell.lblAnnounce.text = self.selectedAnnotation.annouceName
//                    cell.ivAnnounce.image = #imageLiteral(resourceName: "Blue glow")
//                case .Free_table_on_the_terrace:
//                    cell.lblAnnounce.isHidden = false
//                    cell.ivAnnounce.isHidden = false
//                    cell.lblTable.isHidden = true
//                    cell.ivTable.isHidden = true
//                    cell.ivBaja.isHidden = true
//                    cell.lblAnnounce.text = "Free table on terrace"
//                    cell.ivAnnounce.image = #imageLiteral(resourceName: "Glow")
//                case .Both_announcement_and_free_table:
//                    cell.lblAnnounce.isHidden = false
//                    cell.ivAnnounce.isHidden = false
//                    cell.lblTable.isHidden = false
//                    cell.ivTable.isHidden = false
//                    cell.ivBaja.isHidden = false
//                    
//                    cell.lblAnnounce.text = self.selectedAnnotation.annouceName
//                    cell.ivAnnounce.image = #imageLiteral(resourceName: "Blue glow")
//                    cell.lblTable.text = "Free Table"
//                    cell.ivTable.image = #imageLiteral(resourceName: "Glow")
//                default:
//                    break
//                }
//                return cell
//            } else if indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3{
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.mainCategoryTableViewCell) as! MainCategoryTableViewCell
//                cell.ProductImage.image = UIImage(named: self.drinkPriceArray[indexPath.section - 1].drinkImage)
//                cell.ProductNameLabel.text = self.drinkPriceArray[indexPath.section - 1].drinkName.rawValue
//                if let price = self.drinkPriceArray[indexPath.section - 1].drinkPrice{
//                    if var price1 = Double(price){
//                        cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€"
//                    }
//                    
//                }
//                
//                cell.selectedBackgroundView?.backgroundColor = .clear
//                return cell
//            } else {
//                if isShowMore {
//                    switch indexPath.section {
//                    case 4:
//                        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.otherCategoryTableViewCell) as! OtherCategoryTableViewCell
//                        switch self.drinkOtherArray.count {
//                        case 1:
//                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkImage)
//                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkName.rawValue
//                            if let price = self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkPrice{
//                                if var price1 = Double(price){
//                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€"
//                                }
//                                
//                            }
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            return cell
//                        case 2:
//                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkImage)
//                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkName.rawValue
//                            if let price = self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkPrice{
//                                if var price1 = Double(price){
//                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€"
//                                }
//                                
//                            }
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            return cell
//                        case 3:
//                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkImage)
//                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkName.rawValue
//                            if let price = self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkPrice{
//                                if var price1 = Double(price){
//                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€"
//                                }
//                                
//                            }
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            return cell
//                        case 4:
//                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - self.drinkOtherArray.count].drinks[indexPath.row].drinkImage)
//                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - self.drinkOtherArray.count].drinks[indexPath.row].drinkName.rawValue
//                            if let price = self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkPrice{
//                                if var price1 = Double(price){
//                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€"
//                                }
//                                
//                            }
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            return cell
//                        default:
//                            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
//                            cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
//                            cell.TitleLabel.text = "Show less"
//                            cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector3"), for: .normal)
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
//                            return cell
//                        }
//                    case 5:
//                        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.otherCategoryTableViewCell) as! OtherCategoryTableViewCell
//                        switch self.drinkOtherArray.count {
//                        case 2:
//                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkImage)
//                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkName.rawValue
//                            if let price = self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkPrice{
//                                if var price1 = Double(price){
//                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€"
//                                }
//                                
//                            }
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            return cell
//                        case 3:
//                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkImage)
//                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkName.rawValue
//                            if let price = self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkPrice{
//                                if var price1 = Double(price){
//                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€"
//                                }
//                                
//                            }
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            return cell
//                        case 4:
//                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - self.drinkOtherArray.count].drinks[indexPath.row].drinkImage)
//                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - self.drinkOtherArray.count].drinks[indexPath.row].drinkName.rawValue
//                            if let price = self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkPrice{
//                                if var price1 = Double(price){
//                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€"
//                                }
//                                
//                            }
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            return cell
//                        default:
//                            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
//                            cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
//                            cell.TitleLabel.text = "Show less"
//                            cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector3"), for: .normal)
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
//                            return cell
//                        }
//                    case 6:
//                        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.otherCategoryTableViewCell) as! OtherCategoryTableViewCell
//                        switch self.drinkOtherArray.count {
//                        case 3:
//                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkImage)
//                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkName.rawValue
//                            if let price = self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkPrice{
//                                if var price1 = Double(price){
//                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€"
//                                }
//                                
//                            }
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            return cell
//                        case 4:
//                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - self.drinkOtherArray.count].drinks[indexPath.row].drinkImage)
//                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - self.drinkOtherArray.count].drinks[indexPath.row].drinkName.rawValue
//                            if let price = self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkPrice{
//                                if var price1 = Double(price){
//                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€"
//                                }
//                                
//                            }
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            return cell
//                        default:
//                            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
//                            cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
//                            cell.TitleLabel.text = "Show less"
//                            cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector3"), for: .normal)
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
//                            return cell
//                        }
//                    case 7:
//                        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.otherCategoryTableViewCell) as! OtherCategoryTableViewCell
//                        switch self.drinkOtherArray.count {
//                        case 4:
//                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - self.drinkOtherArray.count].drinks[indexPath.row].drinkImage)
//                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - self.drinkOtherArray.count].drinks[indexPath.row].drinkName.rawValue
//                            if let price = self.drinkOtherArray[indexPath.section - 4].drinks[indexPath.row].drinkPrice{
//                                if var price1 = Double(price){
//                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€"
//                                }
//                                
//                            }
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            return cell
//                        default:
//                            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
//                            cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
//                            cell.TitleLabel.text = "Show less"
//                            cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector3"), for: .normal)
//                            cell.selectedBackgroundView?.backgroundColor = .clear
//                            cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
//                            return cell
//                        }
//                    default:
//                        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
//                        cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
//                        cell.TitleLabel.text = "Show less"
//                        cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector3"), for: .normal)
//                        cell.selectedBackgroundView?.backgroundColor = .clear
//                        cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
//                        return cell
//                    }
//                } else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
//                    cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
//                    cell.TitleLabel.text = "Show More"
//                    cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector2"), for: .normal)
//                    cell.selectedBackgroundView?.backgroundColor = .clear
//                    cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
//                    return cell
//                }
//            }
//        }
//        else{
//            if indexPath.section == 0{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MapsTableViewCell
//                cell.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
//                cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showfullview(_:))))
//                
//                return cell
//            }
//            else
//            if indexPath.section == 1 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.barDetailTableViewCell) as! BarDetailTableViewCell
//                cell.selectedBackgroundView?.backgroundColor = .clear
//                cell.lblName.text = self.selectedAnnotation.title
//                if let bdetail = self.selectedBar.bdetail{
//                    do{
//                        let jsonDecoder = JSONDecoder()
//                        let data1 = bdetail.data(using: .utf8)
//                        let bar = try jsonDecoder.decode(BarModelW.self, from: data1!)
//                        let timing = calculateTiming(data: bar.barWeekDay)
//                        cell.lblOpen.text = timing.0
//                        cell.lblTime.text = timing.1
//                        cell.lblOpen.textColor = timing.2
//                    }
//                    catch let error{
//                        
//                    }
//                    
//                }
//                cell.timingStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showTimingBtnAction(_:))))
//                cell.timingStack.isUserInteractionEnabled = true
//                let placeholdr = #imageLiteral(resourceName: "Image")
//                if let imgstr = self.selectedAnnotation.image1{
//                    if let url = URL(string: imgstr){
//                        cell.vImage.af.setImage(withURL: url, placeholderImage: placeholdr, imageTransition: .crossDissolve(0), runImageTransitionIfCached: true)
//                    }
//                    else{
//                        cell.vImage.image = placeholdr
//                    }
//                }
//                else{
//                    cell.vImage.image = placeholdr
//                }
//                cell.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
//                cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showfullview(_:))))
//                switch self.selectedAnnotation.announce {
//                case .None:
//                    cell.lblAnnounce.isHidden = true
//                    cell.ivAnnounce.isHidden = true
//                    cell.lblTable.isHidden = true
//                    cell.ivTable.isHidden = true
//                    cell.ivBaja.isHidden = true
//                case .Announcement:
//                    cell.lblAnnounce.isHidden = false
//                    cell.ivAnnounce.isHidden = false
//                    cell.lblTable.isHidden = true
//                    cell.ivTable.isHidden = true
//                    cell.ivBaja.isHidden = false
//                    
//                    cell.lblAnnounce.text = self.selectedAnnotation.annouceName
//                    cell.ivAnnounce.image = #imageLiteral(resourceName: "Blue glow")
//                case .Free_table_on_the_terrace:
//                    cell.lblAnnounce.isHidden = false
//                    cell.ivAnnounce.isHidden = false
//                    cell.lblTable.isHidden = true
//                    cell.ivTable.isHidden = true
//                    cell.ivBaja.isHidden = true
//                    cell.lblAnnounce.text = "Free table on terrace"
//                    cell.ivAnnounce.image = #imageLiteral(resourceName: "Glow")
//                case .Both_announcement_and_free_table:
//                    cell.lblAnnounce.isHidden = false
//                    cell.ivAnnounce.isHidden = false
//                    cell.lblTable.isHidden = false
//                    cell.ivTable.isHidden = false
//                    cell.ivBaja.isHidden = false
//                    
//                    cell.lblAnnounce.text = self.selectedAnnotation.annouceName
//                    cell.ivAnnounce.image = #imageLiteral(resourceName: "Blue glow")
//                    cell.lblTable.text = "Free Table"
//                    cell.ivTable.image = #imageLiteral(resourceName: "Glow")
//                default:
//                    break
//                }
//                return cell
//            } else if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4{
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.mainCategoryTableViewCell) as! MainCategoryTableViewCell
//                cell.ProductImage.image = UIImage(named: self.drinkPriceArray[indexPath.section - 2].drinkImage)
//                cell.ProductNameLabel.text = self.drinkPriceArray[indexPath.section - 2].drinkName.rawValue
//                if let price = self.drinkPriceArray[indexPath.section - 2].drinkPrice{
//                    if var price1 = Double(price){
//                        cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€"
//                    }
//                    
//                }
//                cell.selectedBackgroundView?.backgroundColor = .clear
//                return cell
//            } else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
//                cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
//                cell.TitleLabel.text = "Show More"
//                cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector2"), for: .normal)
//                cell.selectedBackgroundView?.backgroundColor = .clear
//                cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
//                return cell
//            }
//        }
//        
//    }
//    
//    @objc func showMoreBtnAction(_ sender: UIButton){
//        if isShowMore {
//            isShowMore = false
//        }else{
//            isShowMore = true
//        }
//        //self.BarDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 2), at: .bottom, animated: false)
//        self.BarDetailTableView.reloadData()
//    }
//    @objc func showTimingBtnAction(_ sender: UIButton){
//        PopupHelper.alertTimingViewController(controler: self)
//    }
//    func calculateTiming(data:[WeekDayModelW]) -> (String?,String?,UIColor){
//        let time = Date().toMillisInt64()
//        var timestr = ""
//        var openClose = ""
//        var color = UIColor.black
//        for weekday in data{
//            if Date().weekFullDay == weekday.weekDay{
//                if time > weekday.svalue && time < weekday.evalue{
//                    timestr = "- Closes at \(weekday.evalue.timestampToTimeString()!)"
//                    openClose = "Open"
//                    color = .green
//                    break
//                }
//            }
//        }
//        if timestr == ""{
//            for week in data{
//                if Date().weekFullDay == week.weekDay{
//                   
//                    if time < week.svalue{
//                        timestr = "- Opens at \(week.svalue.timestampToTimeString()!)"
//                        openClose = "Closed"
//                        color = .red
//                        break
//                    }
//                }
//                
//            }
//        }
//        if timestr == ""{
//            timestr = "- Open on \(Date().add(days: 1).weekFullDay)"
//            openClose = "Closed"
//            color = .red
//        }
//        if isBarShow{
//            //self.BarDetailTableView.reloadSections([1], with: .automatic)
//        }
//        else{
//            //self.BarDetailTableView.reloadSections([0], with: .automatic)
//        }
//        
//        return (openClose,timestr,color)
//    
//    }
//}
//// MARK:- LOCATION METHOD'S EXTENSION
//extension MapsViewController: CLLocationManagerDelegate {
//    
//    // Handle incoming location events.
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location: CLLocation = locations.last!
//        self.myLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
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
