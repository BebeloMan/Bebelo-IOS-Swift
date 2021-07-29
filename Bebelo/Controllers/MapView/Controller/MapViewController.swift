//
//  MapViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 02/08/2021.
//

import UIKit
import MapboxMaps
import CoreLocation
import Accelerate
import DKChainableAnimationKit
var selftimer:Timer!
public class CameraLocationConsumer: LocationConsumer {
    weak var mapView: MapView?
    var zoom: CGFloat?
    init(mapView: MapView,zoom: CGFloat) {
        self.mapView = mapView
        self.zoom = zoom
    }

    public func locationUpdate(newLocation: Location) {
        mapView?.camera.ease(
            to: CameraOptions(center: newLocation.coordinate, zoom: zoom),
            duration: 1.3)
    }
}
class MapViewController: UIViewController {
    enum TableState:String{
        case fulldown,halfdown,fullshow
    }
    //IBOUTLET'S
    @IBOutlet var MapboxView: UIView!
    @IBOutlet weak var tabTwo: UIView!
    @IBOutlet weak var tabThree: UIView!
    @IBOutlet weak var btnLive: UIButton!
    @IBOutlet weak var BarDetailTableView: UITableView!
    //@IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var vNav: UIView!
    @IBOutlet weak var vNav1: UIView!
    var isShowMore = false
    var isBarShow = false
    var height:CGFloat = 0
    let distanceFilter: CLLocationDistance = 50
    var myLocation = CLLocationCoordinate2D(latitude: Constant.Mad_latitude, longitude: Constant.Mad_longitude)
    var zoomLevel: CGFloat = 14.0
    //var lastZoomLevel: CGFloat = 15.0
    var pitchLevel: CGFloat = 0.0
    var bearingLevel: CGFloat = 0.0
    var annotaionArray = [AnnotationModel]()
    var barArray = [UserModel]()
    var weekArray: [WeekDayModelW]!
    var annotaionFilterArray = [AnnotationModel]()//filter
    var annotaionFilterArray1 = [AnnotationModel]()
    var pointAnnotationArray = [PointAnnotation]()
    var selectedAnnotation:AnnotationModel!
    var selectedBar:UserModel!
    var drinkPriceArray: [DrinkPricesModelW]! =  [DrinkPricesModelW]()
    var drinkOtherArray:[DrinkPrices1ModelW]!
    var drinkOtherArray1:[DrinkPrices1ModelW]!
    var isFirstAnimating = false
    var isLive = true
    var isMapLoad = false
    var isFirstTimeRun = true
    var pinTap = false
    var isProcessing = true
    var isAlreadyBarOpen = false
    var tableState:TableState! = .fulldown
    var pointAnnotationManager: PointAnnotationManager!
    var cameraLocationConsumer: CameraLocationConsumer!
    var Mapbox: MapView!
    private var markerSelected = false
    private var markerSelectedIndex:Int!
    var selectedCordinate : CLLocationCoordinate2D!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //let myResourceOptions = ResourceOptions(accessToken: "pk.eyJ1IjoiYWxpam9objIwNTAiLCJhIjoiY2t0bGx6ZnQwMDBodjJ3bjVobjB2cWQ5NyJ9.eJSofPyNRDi44COakLeVfw")
        let url = URL(string: "mapbox://styles/alijohn2050/ckz2x19fq002e14o41eg1s0ww")!
        if let loc = CommonHelper.getCachedMapLocData(){
            let option = CameraOptions(center: CLLocationCoordinate2D(latitude: loc.address_lat ?? Constant.Mad_latitude, longitude: loc.address_lng ?? Constant.Mad_longitude), zoom: loc.zoom ?? self.zoomLevel, bearing: loc.bearing ?? self.bearingLevel, pitch: loc.pitch ?? self.pitchLevel)
            let myMapInitOptions = MapInitOptions(cameraOptions: option,styleURI: StyleURI(url: url))
            self.Mapbox = MapView(frame: self.view.bounds, mapInitOptions: myMapInitOptions)
            self.Mapbox.backgroundColor = .white
            self.MapboxView.addSubview(self.Mapbox)
            self.Mapbox.mapboxMap.setCamera(to: option)
            
            //cameraLocationConsumer = CameraLocationConsumer(mapView: self.Mapbox,zoom: loc.zoom)
            
        }
        else{
            let myMapInitOptions = MapInitOptions(cameraOptions: CameraOptions(center: CLLocationCoordinate2D(latitude: 39.7128, longitude: -75.0060), zoom: zoomLevel),styleURI: StyleURI(url: url))
            self.Mapbox = MapView(frame: self.view.bounds, mapInitOptions: myMapInitOptions)
            self.Mapbox.backgroundColor = .white
            self.MapboxView.addSubview(self.Mapbox)
            
            //cameraLocationConsumer = CameraLocationConsumer(mapView: self.Mapbox,zoom: zoomLevel)
        }
        self.Mapbox.gestures.options.pitchEnabled = false
        //self.Mapbox.gestures.options.doubleTapToZoomInEnabled = false
        self.Mapbox.gestures.delegate = self
        //self.Mapbox.gestures.options.pinchRotateEnabled = false
        self.pointAnnotationManager = self.Mapbox.annotations.makePointAnnotationManager()
        self.pointAnnotationManager.delegate = self
        self.pointAnnotationManager.iconAllowOverlap = false
        //self.pointAnnotationManager.iconRotationAlignment = .viewport
        self.pointAnnotationManager.iconKeepUpright = true
        
        //self.Mapbox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleMapTap)))
        
        let configuration = Puck2DConfiguration(topImage: UIImage(named: "Me2"),pulsing: Puck2DConfiguration.Pulsing.default,showsAccuracyRing: true)
        
        //let configuration = Puck2DConfiguration.makeDefault(showBearing: true)
        self.Mapbox.location.options.puckType = .puck2D(configuration)
        self.Mapbox.location.options.puckBearingSource = .course
        
        //self.loaddummy()
//        let followPuckViewportState = self.Mapbox.viewport.makeFollowPuckViewportState(
//            options: FollowPuckViewportStateOptions(
//                padding: UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0),
//                bearing: .constant(0)))
//        let overviewViewportState = self.Mapbox.viewport.makeOverviewViewportState(
//            options: OverviewViewportStateOptions(
//                geometry: Point(self.myLocation),
//                padding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)))
//        let immediateTransition = self.Mapbox.viewport.makeImmediateViewportTransition()
//        // transition from idle (the default status) to the created followPuckViewportState with default transition
//        self.Mapbox.viewport.transition(to: followPuckViewportState) { success in
//            // the transition has been completed with a flag indicating whether the transition succeeded
//        }
//        self.Mapbox.viewport.transition(to: overviewViewportState, transition: immediateTransition) { success in
//            // the transition has been completed with a flag indicating whether the transition succeeded
//        }
        self.Mapbox.mapboxMap.onEvery(.cameraChanged, handler: { [weak self] _ in
            guard let selfs = self else { return }
            print("camera1e")
            
            if !selfs.pinTap{
                //selfs.handleMapTap()
            }
            
            CommonHelper.saveCachedMapLocData(LocationModel(address_lat: selfs.Mapbox.cameraState.center.latitude, address_lng: selfs.Mapbox.cameraState.center.longitude,zoom: selfs.Mapbox.cameraState.zoom,pitch: selfs.Mapbox.cameraState.pitch,bearing: selfs.Mapbox.cameraState.bearing))
              print("zoomlevel:\(selfs.Mapbox.cameraState.zoom)")
            if !selfs.isAlreadyBarOpen{
                switch selfs.Mapbox.cameraState.zoom{
                case 0...12:
                    if !selfs.isProcessing{
                       if selfs.isLive{
                           
                            selfs.reloadLive(selfs.annotaionArray,countrs:50)
                        }
                        else{
                            selfs.reloadNonLive(selfs.annotaionArray,countrs:50)
                        }
                    }
                
                case 13...15:
                    if !selfs.isProcessing{
                        if selfs.isLive{
                            selfs.reloadLive(selfs.annotaionArray,countrs:50)
                        }
                        else{
                            selfs.reloadNonLive(selfs.annotaionArray,countrs:50)
                        }
                    }
                case 15...20:
                    if !selfs.isProcessing{
                        if selfs.isLive{
                            selfs.reloadLive(selfs.annotaionArray,countrs:50)
                        }
                        else{
                            selfs.reloadNonLive(selfs.annotaionArray,countrs:50)
                        }
                    }
                default:
                    break
                }
            }
            
        })
        
        self.Mapbox.mapboxMap.onEvery(.mapIdle, handler: { [weak self] _ in
            guard let selfs = self else { return }
            print("camera2:\(selfs.Mapbox.cameraState.zoom)")
            
            

        })
        self.Mapbox.mapboxMap.onNext(.mapLoaded, handler: { [weak self] _ in
            guard let selfs = self else { return }
            print("camera3")
            
            //selfs.Mapbox.location.addLocationConsumer(newConsumer: selfs.cameraLocationConsumer)
            
            //selfs.preparemaps()
            
            //self.toggleAccuracyRadiusButton.isHidden = self.Mapbox.cameraState.zoom < 18.0
        })
        self.Mapbox.mapboxMap.onEvery(.sourceAdded, handler: { [weak self] _ in
            guard let self = self else { return }
            print("camera4")
            //self.toggleAccuracyRadiusButton.isHidden = self.Mapbox.cameraState.zoom < 18.0
        })
//        self.Mapbox.mapboxMap.onEvery(.renderFrameFinished, handler: { [weak self] _ in
//            guard let self = self else { return }
//            print("camera5")
//            //self.toggleAccuracyRadiusButton.isHidden = self.Mapbox.cameraState.zoom < 18.0
//        })
//        self.Mapbox.mapboxMap.onEvery(.renderFrameStarted, handler: { [weak self] _ in
//            guard let selfs = self else { return }
//            print("camera6")
//            //self.toggleAccu racyRadiusButton.isHidden = self.Mapbox.cameraState.zoom < 18.0
////            if selfs.Mapbox.cameraState.zoom < 10 {
////                selfs.Mapbox.mapboxMap.setCamera(to: CameraOptions(center: self?.Mapbox.cameraState.center, zoom: 10, bearing: selfs.Mapbox.cameraState.bearing, pitch: selfs.Mapbox.cameraState.pitch))
////            }
////            else if selfs.Mapbox.cameraState.zoom > 18{
////                selfs.Mapbox.mapboxMap.setCamera(to: CameraOptions(center: self?.Mapbox.cameraState.center, zoom: 18, bearing: selfs.Mapbox.cameraState.bearing, pitch: selfs.Mapbox.cameraState.pitch))
////            }
//        })
        //navigationBarSetup()
        //self.Mapbox.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(drage(_:))))
        let frame = self.BarDetailTableView.frame
        self.BarDetailTableView.frame = CGRect(x: -1, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width + 1, height: UIScreen.main.bounds.height)
        self.userLocationSetup()
        loadMap()
        //self.Mapbox.delegate = self
        //self.Mapbox.showsUserHeadingIndicator = true
        //self.Mapbox.compassView.isHidden = false
        //self.Mapbox.logoView.isHidden = true
        //self.Mapbox.attributionButton.isHidden = true
        //self.Mapbox.userTrackingMode = .none
        //self.Mapbox.allowsTilting = false
        //self.Mapbox.showsUserLocation = true
        //self.Mapbox.styleURL = URL(string: "mapbox://styles/alijohn2050/ckz2x19fq002e14o41eg1s0ww")
        if CommonHelper.getCachedMapLocData() == nil{
            self.Mapbox.camera.fly(to: CameraOptions(center: self.myLocation, zoom: 4500, bearing: CLLocationDirection(0), pitch: 0))
        }
//        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap))
//        for recognizer in self.Mapbox.gestureRecognizers! where recognizer is UITapGestureRecognizer {
//        singleTap.require(toFail: recognizer)
//            //self.Mapbox.removeGestureRecognizer(recognizer)
//        }
//        self.Mapbox.addGestureRecognizer(singleTap)
        
        self.loadBarTest()
        //self.loadBars()
        //self.getTestForUpdate()
        self.BarDetailTableView.drawCorner(roundTo: .top)
        self.isBarShow = false
        self.BarDetailTableView.isScrollEnabled = false
        self.BarDetailTableView.cornerRadius = 25
        self.BarDetailTableView.reloadData()
        self.loadAllDrinks()
        
        //selftimer = Timer.scheduledTimer(timeInterval: 05.0, target: self, selector: #selector(self.timerLoadData), userInfo: nil, repeats: true)
        
        
        
//        self.annotaionArray = [
//            AnnotationModel(title: "Perrachica",price: "€57", image: "Group 21",image1: "Bar0", identifier: "Perrachica", identifier1: "Perrachica1",announce: .Announcement),
//            AnnotationModel(title: "Nice to meet you",price: "€30", image: "Group 58",image1: "Bar1", identifier: "Nice to meet you", identifier1: "Nice to meet you1",announce: .Free_table_on_the_terrace),
//            AnnotationModel(title: "Copas",price: "€90", image: "Group 21",image1: "Bar2", identifier: "Copas", identifier1: "Copas1",announce: .Both_announcement_and_free_table),
//            AnnotationModel(title: "dummy",price: "€20", image: "Group 58",image1: "Bar3", identifier: "dummy", identifier1: "dummy1"),
//            AnnotationModel(title: "Perrachica Lavapies",price: "€65", image: "Group 21",image1: "Bar0", identifier: "dumm", identifier1: "dumm1",announce: .Announcement)
//        ]
    }
    func preparemaps(){
        //do{
            //try self.Mapbox.mapboxMap.style.addImage(UIImage(named: "Rooftop")!, id: "Rooftop1")
            let loc = CommonHelper.getCachedMapLocData()
            var pointAnnotation = PointAnnotation(id: UUID().uuidString, point: Point(LocationCoordinate2D(latitude: loc?.address_lat ?? 0.0, longitude: loc?.address_lng ?? 0.0)))
            //pointAnnotation.iconImage = "Rooftop"
            pointAnnotation.iconAnchor = .center
            pointAnnotation.image = .init(image: UIImage(named: "Rooftop")!, name: "Rooftop")

            pointAnnotationManager.annotations.append(pointAnnotation)
//        }
//        catch let error{
//            print("errorr:\(error.localizedDescription)")
//        }
    }
    @objc func drage(_ gest:UIPanGestureRecognizer){
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.checkDailyData()
        self.userLocationSetup()
        
        if let save = CommonHelper.getOnlyShowData(){
            if let save1 = CommonHelper.getOnlyShowData1(){
                if save1.first?.isSelected != save.first?.isSelected {
                    PopupHelper.showAnimating(controler:self)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        if self.isLive{
                            if self.Mapbox.cameraState.zoom < 10{
                                self.reloadLive(self.annotaionArray,countrs: 20)
                            }
                            else{
                                self.reloadLive(self.annotaionArray,countrs: 20)
                            }
                        }
                        else{
                           if self.Mapbox.cameraState.zoom < 10{
                                self.reloadNonLive(self.annotaionArray,countrs: 50)
                            }
                            else{
                                self.reloadNonLive(self.annotaionArray,countrs: 50)
                            }
                        }
                    }
                    CommonHelper.saveOnlyShowData1(save)
                    return
                }
                if save1.last?.isSelected != save.last?.isSelected{
                    PopupHelper.showAnimating(controler:self)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        if self.isLive{
                            if self.Mapbox.cameraState.zoom < 10{
                                self.reloadLive(self.annotaionArray,countrs: 20)
                            }
                            else{
                                self.reloadLive(self.annotaionArray,countrs: 20)
                            }
                        }
                        else{
                            if self.Mapbox.cameraState.zoom < 10{
                                self.reloadNonLive(self.annotaionArray,countrs: 50)
                            }
                            else{
                                self.reloadNonLive(self.annotaionArray,countrs: 50)
                            }
                        }
                    }
                    CommonHelper.saveOnlyShowData1(save)
                    return
                }
            }
            else{
                PopupHelper.showAnimating(controler:self)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if self.isLive{
                        if self.Mapbox.cameraState.zoom < 10{
                            self.reloadLive(self.annotaionArray,countrs: 20)
                        }
                        else{
                            self.reloadLive(self.annotaionArray,countrs: 20)
                        }
                    }
                    else{
                        if self.Mapbox.cameraState.zoom < 10{
                            self.reloadNonLive(self.annotaionArray,countrs: 50)
                        }
                        else{
                            self.reloadNonLive(self.annotaionArray,countrs: 50)
                        }
                    }
                }
                CommonHelper.saveOnlyShowData1(save)
            }
        }
        

        if FirebaseData.getCurrentUserId().1{
            self.tabTwo.isHidden = true
            self.tabThree.isHidden = false
        }
        else{
            self.tabTwo.isHidden = false
            self.tabThree.isHidden = true
        }
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.userLocationSetup()
    }
    override func viewDidDisappear(_ animated: Bool) {
        CommonHelper.saveCachedMapLocData(LocationModel(address_lat: self.Mapbox.cameraState.center.latitude, address_lng: self.Mapbox.cameraState.center.longitude,zoom: self.Mapbox.cameraState.zoom,pitch: self.Mapbox.cameraState.pitch,bearing: self.Mapbox.cameraState.bearing))
    }
    @objc func timerLoadData(){
        self.loadBar1()
    }
    func showtableView(){
        
        self.loadAllDrinks()
        self.loadData()
        var heiht = UIScreen.main.bounds.height
        //var height1 = UIScreen.main.bounds.height
        switch self.tableState
        {
        case .fulldown:
            self.tableState = .halfdown
            switch heiht{
            case Globals.iphone_SE2_8_7_6s_6_hieght2,Globals.iphone_SE1_5_5s_5c_hieght1:
                heiht = heiht/2
                //height1 = height1/5
            case Globals.iphone_13Pro_13_12Pro_12_hieght6:
                heiht = heiht/1.9
                //height1 = height1/5.1
            case Globals.iphone_13m_12m_11pro_XS_X_hieght4:
                heiht = heiht/2
                //height1 = height1/5.2
            case Globals.iphone_11ProMax_11_XsMax_XR_hieght7:
                heiht = heiht/1.9
                //height1 = height1/5.3
            default:
                heiht = heiht/1.8
                //height1 = height1/5.4
            }
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionCurlUp, animations: {
                let tableFrame = self.BarDetailTableView.frame
                self.BarDetailTableView.frame = CGRect(x: tableFrame.origin.x, y: heiht, width: tableFrame.width, height: UIScreen.main.bounds.height)
            }, completion: nil)
            
        case .halfdown:
            //let tableFrame = self.BarDetailTableView.frame
            //self.BarDetailTableView.frame = CGRect(x: tableFrame.origin.x, y: UIScreen.main.bounds.height, width: tableFrame.width, height: UIScreen.main.bounds.height)
            var heiht = UIScreen.main.bounds.height
            //var height1 = UIScreen.main.bounds.height
            switch heiht{
            case Globals.iphone_SE2_8_7_6s_6_hieght2,Globals.iphone_SE1_5_5s_5c_hieght1:
                heiht = heiht/2
                //height1 = height1/5
            case Globals.iphone_13Pro_13_12Pro_12_hieght6:
                heiht = heiht/1.9
                //height1 = height1/5.1
            case Globals.iphone_13m_12m_11pro_XS_X_hieght4:
                heiht = heiht/2
                //height1 = height1/5.2
            case Globals.iphone_11ProMax_11_XsMax_XR_hieght7:
                heiht = heiht/1.9
                //height1 = height1/5.3
            default:
                heiht = heiht/1.8
                //height1 = height1/5.4
            }
//            UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionCurlUp, animations: {
//                self.BarDetailTableView.frame = CGRect(x: tableFrame.origin.x, y: heiht, width: tableFrame.width, height: UIScreen.main.bounds.height)
//            }, completion: nil)
            
        default:
            break
        }
        self.BarDetailTableView.reloadData()
    }
    //IBACTION'S
    func loadAllDrinks(){
        self.drinkPriceArray = [
            DrinkPricesModelW(drinkName: .Tanqueray, drinkImage: "dd1"),
            DrinkPricesModelW(drinkName: .Beefeater, drinkImage: "dd2"),
            DrinkPricesModelW(drinkName: .Brugal, drinkImage: "dd3")
            ]
        self.drinkOtherArray = [
            DrinkPrices1ModelW(drinkCategory: "Beer", drinks: [
                DrinkPricesModelW(drinkName: .Caña , drinkImage: "d4"),
                DrinkPricesModelW(drinkName: .Doble, drinkImage: "d5")
            ]),
            DrinkPrices1ModelW(drinkCategory: "Normales", drinks: [
                /*DrinkPricesModelW(drinkName: .Tanqueray, drinkImage: "d1"),
                DrinkPricesModelW(drinkName: .Beefeater, drinkImage: "d2"),
                DrinkPricesModelW(drinkName: .Brugal, drinkImage: "d3"),*/
                DrinkPricesModelW(drinkName: .Seagram_s, drinkImage: "d6"),
                DrinkPricesModelW(drinkName: .Bombay_Sapphire , drinkImage: "d7"),
                DrinkPricesModelW(drinkName: .Barceló , drinkImage: "d8"),
                DrinkPricesModelW(drinkName: .Santa_Teresa , drinkImage: "d9"),
                DrinkPricesModelW(drinkName: .Cacique , drinkImage: "d10"),
                DrinkPricesModelW(drinkName: .Captain_Morgan , drinkImage: "d11"),
                DrinkPricesModelW(drinkName: .Johnnie_Walker_Red , drinkImage: "d12"),
                DrinkPricesModelW(drinkName: .J_n_B , drinkImage: "d13"),
                DrinkPricesModelW(drinkName: .Absolut , drinkImage: "d14"),
            ]),
            DrinkPrices1ModelW(drinkCategory: "High roller", drinks: [
                DrinkPricesModelW(drinkName: .Nordés , drinkImage: "d15"),
                DrinkPricesModelW(drinkName: .Bulldog , drinkImage: "d16"),
                DrinkPricesModelW(drinkName: .Hendrick_s , drinkImage: "d17"),
                DrinkPricesModelW(drinkName: .Martin_Miller_s , drinkImage: "d18"),
                DrinkPricesModelW(drinkName: .Brockman_s , drinkImage: "d19"),
                DrinkPricesModelW(drinkName: .Havana_Club_7 , drinkImage: "d20"),
                DrinkPricesModelW(drinkName: .Johnnie_Walker_Black , drinkImage: "d21"),
                DrinkPricesModelW(drinkName: .Jack_Daniel_s , drinkImage: "d22"),
                DrinkPricesModelW(drinkName: .Grey_Goose , drinkImage: "d23"),
                DrinkPricesModelW(drinkName: .Belvedere , drinkImage: "d24"),
            ]),
            DrinkPrices1ModelW(drinkCategory: "War time", drinks: [
                DrinkPricesModelW(drinkName: .Larios , drinkImage: "d25"),
                DrinkPricesModelW(drinkName: .Negrita , drinkImage: "d26"),
                DrinkPricesModelW(drinkName: .Dyc , drinkImage: "d27")
            ])
            ]
        if self.drinkOtherArray1 == nil{
            self.drinkOtherArray1 = self.drinkOtherArray
        }
        
    }
    func loadData(){
        if let barData = self.selectedBar{
            
            if let drinkArray = barData.barBottle{
                self.drinkPriceArray.forEach { drinkPricesModel in
                    for var drink in drinkArray{
                        if drinkPricesModel.drinkName == drink.drinkName{
                            drinkPricesModel.drinkPrice = drink.drinkPrice
                            drink.drinkPrice = nil
                            break
                        }
                        
                    }
                }
                self.drinkOtherArray.forEach { drinkPrices1Model in
                    for drinkPrices in drinkPrices1Model.drinks{
                        for drinks in drinkArray{
                            if drinks.drinkName == drinkPrices.drinkName{
                                drinkPrices.drinkPrice = drinks.drinkPrice
                            }
                            
                        }
                    }
                }
                print("count:\(self.annotaionFilterArray.count)")
//                for coordinate in self.annotaionFilterArray {
//                    let point = PointAnnotation(coordinate: coordinate.location)
//                    point.image = .init(image: UIImage(named: coordinate.image)!, name: coordinate.image)
//
//                    //point.subtitle = "\(coordinate.barData.displayPrice ?? "0")€"
//                    let anno = self.Mapbox.annotations!.first(where: { annotation in
//                        guard let ann = annotation as? MGLPointAnnotation else {return false}
//                        return ann.title == coordinate.title
//                    })
//                    if anno == nil{
//                        self.Mapbox.addAnnotation(point)
//                    }
//
//                }
            }
        }
        self.drinkPriceArray.removeAll { drinkPricesModel in
            return drinkPricesModel.drinkPrice == "0" || drinkPricesModel.drinkPrice == nil
        }
        self.drinkOtherArray.removeAll { drinkPrices1Model in
            drinkPrices1Model.drinks.removeAll(where: { drinkPricesModel in
                return drinkPricesModel.drinkPrice == "0" || drinkPricesModel.drinkPrice == nil
            })
            return drinkPrices1Model.drinks.count == 0
        }
        self.BarDetailTableView.reloadData()
    }
    @IBAction func OptionBtnAction(_ sender: Any) {
        let optionView = self.getViewController(identifier: "MenuOptionViewController") as! MenuOptionViewController
        optionView.delegate = self
        optionView.selectedBar = self.selectedBar
        self.present(optionView, animated: false, completion: nil)
    }
    @IBAction func userLocationBtnAction(_ sender: Any) {
        self.Mapbox.camera.fly(to: CameraOptions(center:  self.myLocation, zoom: self.zoomLevel, bearing: self.bearingLevel, pitch: self.pitchLevel))
        CommonHelper.saveCachedMapLocData(LocationModel(address_lat: self.myLocation.latitude, address_lng: self.myLocation.longitude, zoom: self.zoomLevel, pitch: self.pitchLevel, bearing: self.bearingLevel))
    }
    @IBAction func backBtnAction(_ sender: Any) {
        if self.isShowMore{
            self.isBarShow = false
            self.isShowMore = false
            self.BarDetailTableView.reloadData()
        }
        else{
            self.isBarShow = false
            self.isShowMore = false
            self.BarDetailTableView.reloadSections([0,1], with: .none)
        }
        
        self.tableState = .halfdown
        self.BarDetailTableView.isScrollEnabled = false
        self.BarDetailTableView.cornerRadius = 25
        self.BarDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        
        
            var heiht = UIScreen.main.bounds.height
            switch heiht{
            case Globals.iphone_SE2_8_7_6s_6_hieght2,Globals.iphone_SE1_5_5s_5c_hieght1:
                heiht = heiht/2
            case Globals.iphone_13Pro_13_12Pro_12_hieght6:
                heiht = heiht/1.9
            case Globals.iphone_13m_12m_11pro_XS_X_hieght4:
                heiht = heiht/2
            case Globals.iphone_11ProMax_11_XsMax_XR_hieght7:
                heiht = heiht/1.9
            default:
                heiht = heiht/1.8
            }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionCurlDown, animations: {
            let tableFrame = self.BarDetailTableView.frame
            self.BarDetailTableView.frame = CGRect(x: tableFrame.origin.x, y: heiht, width: tableFrame.width, height: UIScreen.main.bounds.height)
        }, completion: nil)
        
        
    }
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        let translation = sender.location(in: view)
        let translation1 = sender.velocity(in: view)
        switch sender.state {
        case .changed:
            
            print("location: \(translation.y)")
            print("velocity: \(translation1.y)")
            guard translation.y <= self.height else { return }
        case .ended:
            
            if sender.velocity(in: self.view).y < -200{
                self.showfullview(sender)
                return
            }
            if sender.velocity(in: self.view).y < -100{
                self.showfullview(sender)
                return
            }
            if sender.velocity(in: self.view).y < -50{
                self.showfullview(sender)
                return
            }
            if sender.velocity(in: self.view).y < -10{
                self.showfullview(sender)
                return
            }
            if translation.y < 50{
                self.isBarShow = true
                self.BarDetailTableView.isScrollEnabled = true
                return
            }
            
            if translation.y > self.view.frame.height - 300 {
                self.selectedAnnotation = nil
                self.selectedBar = nil
                self.isShowMore = false
                self.isBarShow = false
                
                //self.Mapbox.deselectAnnotation(self.Mapbox.selectedAnnotations.first, animated: true)
                
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionCurlDown, animations: {
                    DispatchQueue.main.async {
                        self.pointAnnotationManager.annotations = self.pointAnnotationArray
                    }
                    let tableFrame = self.BarDetailTableView.frame
                    self.BarDetailTableView.frame = CGRect(x: tableFrame.origin.x, y: UIScreen.main.bounds.height, width: tableFrame.width, height: UIScreen.main.bounds.height)
                }, completion: nil)
                self.tableState = .fulldown
                
                
                return
            }
            else{
                self.isBarShow = false
                self.BarDetailTableView.isScrollEnabled = false
            }

        default:
            break
        }
    }
    @objc func showfullview(_ sender:Any){
        self.isBarShow = true
        self.BarDetailTableView.reloadSections([0,1,2], with: .none)
        self.tableState = .fullshow
        self.BarDetailTableView.cornerRadius = 0
        self.BarDetailTableView.isScrollEnabled = true
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionCurlUp, animations: {
            let tableFrame = self.BarDetailTableView.frame
            self.BarDetailTableView.frame = CGRect(x: tableFrame.origin.x, y: 0, width: tableFrame.width, height: UIScreen.main.bounds.height)
        }, completion: nil)
        
        
    }
    @IBAction func liveBtnAction(_ sender: Any) {
        
        DispatchQueue.main.async {
            PopupHelper.showAnimating(controler: self)
        }
        
        
        if self.isLive{
            self.isLive = false
            self.btnLive.setImage(#imageLiteral(resourceName: "Group 42"), for: .normal)
            DispatchQueue.background(delay: 1.0) {
                print("background")
            } completion: {
                print("main")
                if self.Mapbox.cameraState.zoom < 10{
                    self.reloadNonLive(self.annotaionArray,countrs:50)
                }
                else{
                    self.reloadNonLive(self.annotaionArray,countrs: 100)
                }
            }

            
        }
        else{
            self.isLive = true
            self.btnLive.setImage(#imageLiteral(resourceName: "Group 41"), for: .normal)
            DispatchQueue.background(delay: 1.0) {
                print("background")
            } completion: {
                print("main")
                if self.Mapbox.cameraState.zoom < 10{
                    self.reloadLive(self.annotaionArray,countrs:20)
                }
                else{
                    self.reloadLive(self.annotaionArray,countrs: 50)
                }
            }
            
        }
    }
    func loadMap(){
        //self.isMoving = false
        //self.Mapbox.showsUserHeadingIndicator = true
        
        self.Mapbox.ornaments.scaleBarView.isHidden = true
        self.Mapbox.ornaments.compassView.isHidden = false
        self.Mapbox.ornaments.logoView.isHidden = true
        self.Mapbox.ornaments.attributionButton.isHidden = true
        
        if let loc = CommonHelper.getCachedMapLocData(){
            //self.Mapbox.userTrackingMode = .none
            
            self.Mapbox.mapboxMap.setCamera(to: CameraOptions(center: CLLocationCoordinate2D(latitude: loc.address_lat ?? Constant.Mad_latitude, longitude: loc.address_lng ?? Constant.Mad_longitude), zoom: loc.zoom ?? self.zoomLevel, bearing: loc.bearing ?? self.bearingLevel, pitch: loc.pitch ?? self.pitchLevel))
        }
        else{
            self.Mapbox.camera.fly(to: CameraOptions(center: CLLocationCoordinate2D(latitude: self.myLocation.latitude, longitude: self.myLocation.longitude), zoom: self.zoomLevel, bearing: self.bearingLevel, pitch: self.pitchLevel))
            //self.Mapbox.userTrackingMode = .none
        }
    }
    @objc func saveLocation(){
        CommonHelper.saveCachedUserLocData(LocationModel(address_lat: self.Mapbox.cameraState.center.latitude, address_lng: self.Mapbox.cameraState.center.longitude, zoom: self.Mapbox.cameraState.zoom, pitch: self.Mapbox.cameraState.pitch, bearing: self.Mapbox.cameraState.bearing))
    }
    func removeAnnotation(){
//        for annotation in self.Mapbox.annotations!{
//            self.annotaionArray1.forEach { annotationModel in
//                if annotation.title == annotationModel.title{
//                    self.Mapbox.removeAnnotation(annotation)
//                }
//
//            }
//        }
        self.loadMap()
        //self.Mapbox.reloadStyle(self)
    }
    func loadweekday(){
        self.weekArray = [
            WeekDayModelW(name: "Monday".localized(), weekDay: weekfullDay.Monday.rawValue),
            WeekDayModelW(name: "Tuesday".localized(), weekDay: weekfullDay.Tuesday.rawValue),
            WeekDayModelW(name: "Wednesday".localized(), weekDay: weekfullDay.Wednesday.rawValue),
            WeekDayModelW(name: "Thursday".localized(), weekDay: weekfullDay.Thursday.rawValue),
            WeekDayModelW(name: "Friday".localized(), weekDay: weekfullDay.Friday.rawValue),
            WeekDayModelW(name: "Saturday".localized(), weekDay: weekfullDay.Saturday.rawValue),
            WeekDayModelW(name: "Sunday".localized(), weekDay: weekfullDay.Sunday.rawValue)
        ]
    }
    func saveuser(){
        CommonHelper.getCSVUserData { error, userData in
            if let error = error {
                PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                return
            }
            guard let userData = userData else {
                return
            }
            self.davedata2(userData)
            
//            var use = [UserModel]()
//            for i in 0..<5{
//                use.append(userData[i])
//            }
//            self.davedata(use)
            
        }
    }
    func savedrink(){
        CommonHelper.getCSVDrinkData { error, userData in
            if let error = error {
                PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                return
            }
            guard let userData = userData else {
                return
            }
            self.davedrinkdata(userData)
            
//            var use = [UserModel]()
//            for i in 0..<5{
//                use.append(userData[i])
//            }
//            self.davedata(use)
            
        }
    }
    func savebarhas(){
        CommonHelper.getCSVbarData { error, userData in
            if let error = error {
                PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                return
            }
            guard let userData = userData else {
                return
            }
            self.davedrinkdata(userData)
            
//            var use = [UserModel]()
//            for i in 0..<5{
//                use.append(userData[i])
//            }
//            self.davedata(use)
            
        }
    }
    func saveweek(){
        CommonHelper.getCSVweekData { error, userData in
            if let error = error {
                PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                return
            }
            guard let userData = userData else {
                return
            }
            self.davedrinkdata(userData)
            
//            var use = [UserModel]()
//            for i in 0..<5{
//                use.append(userData[i])
//            }
//            self.davedata(use)
            
        }
    }
    func davedata1(_ userData:[UserModel]){
        let userdta = userData.first { userdtaa in
            return userdtaa.isAdded == false
        }
        if var data = userdta{
//            FirebaseData.createUserData(email: data.cemail, password: data.cpassword) { result, error in
//                if let result = result {
//                    print("uid:\(result.user.uid)")
            data.uuid = data.uuid + 6000
            data.blat = data.blat + 0.00000100
            data.blng = data.blng + 0.00000100
            print("uuid2:\(data.uuid)")
            print("blat:\(data.blat ?? 0)")
            print("blng:\(data.blng ?? 0)")
                    FirebaseData.saveUserData(userData: data) { error in
                        if let error = error {
                            print("erorrr:\(error.localizedDescription)")
                            print("error:\(data.uuid)")
                            self.davedata1(userData)
                            //PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                            return
                        }
                        for var dta in userData{
                            if dta.uuid == data.uuid{
                                dta.isAdded = true
                            }
                        }
                        self.davedata1(userData)
                    }
//                }else {
//                    print("erorrr:\(error?.localizedDescription ?? "")")
//                    for dta in userData{
//                        if dta.cemail == data.cemail{
//                            dta.isAdded = true
//                        }
//                    }
//                    self.davedata(userData)
//                    return
//
//                }
                
            //}
        }
    }
    
    func davedata(_ userData:[UserModel]){
        let userdta = userData.first { userdtaa in
            return userdtaa.isAdded == false
        }
        var userd = [UserModel]()
        let countr = 0
        for (i,usee) in userData.enumerated(){
            if i <= 10{
                userd.append(usee)
            }
        }
        let dispatch = DispatchGroup()
        for data in userd{
            dispatch.enter()
            FirebaseData.getUserData1(uid: data.uuid) { error, userDataa in
                
                        if let error = error {
                            print("erorrr:\(error.localizedDescription)")
                            print("error:\(data.uuid)")
                            dispatch.leave()
                            //PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                            return
                        }
                guard let userDataa = userDataa else {
                    dispatch.leave()
                    return
                }
                FirebaseData.updateUserData1(userDataa.id!, dic: data) { error in
                    if let error = error {
                        print("erorrr:\(error.localizedDescription)")
                        print("error:\(data.uuid)")
                        dispatch.leave()
                        //PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                        return
                    }
                    dispatch.leave()
                    
                }
                        
                    }
            
        }
        dispatch.notify(queue: .main) {
            
            for (i,var dt) in userData.enumerated(){
                if i <= countr{
                    dt.isAdded = true
                    print("save:\(dt.uuid)")
                }
            }
            //self.davedata(userData,count: countr)
        }
        if let data = userdta{
//            FirebaseData.createUserData(email: data.cemail, password: data.cpassword) { result, error in
//                if let result = result {
//                    print("uid:\(result.user.uid)")

                    FirebaseData.saveUserData(userData: data) { error in
                        if let error = error {
                            print("erorrr:\(error.localizedDescription)")
                            print("error:\(data.uuid)")
                            self.davedata(userData)
                            //PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                            return
                        }
                        for var dta in userData{
                            if dta.uuid == data.uuid{
                                dta.isAdded = true
                            }
                        }
                        self.davedata(userData)
                    }
//                }else {
//                    print("erorrr:\(error?.localizedDescription ?? "")")
//                    for dta in userData{
//                        if dta.cemail == data.cemail{
//                            dta.isAdded = true
//                        }
//                    }
//                    self.davedata(userData)
//                    return
//
//                }

            //}
        }
        else{
            self.davedata(userData)
        }
    }
    func davedata2(_ userData:[UserModel]? = nil){
        guard var userData = userData else{return}
        userData.removeAll { yser in
            if yser.uuid <= 1486{
                return true
            }
            else{
                return false
            }
        }
        let userdta = userData.first { userdtaa in
            return userdtaa.isAdded == false
        }
        if let data = userdta{
            FirebaseData.getUserData1(uid: data.uuid) { error, userDataa in
                
                        if let error = error {
                            print("erorrr:\(error.localizedDescription)")
                            //print("error:\(data.uuid)")
                            //PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                            userData.removeAll { yser in
                                
                                if yser.uuid == data.uuid{
                                    print("error:\(data.uuid)")
                                    return true
                                }
                                else{
                                    return false
                                }
                            }
                            self.davedata2(userData)
                            return
                        }
                guard let userDataa = userDataa else {
                    userData.removeAll { yser in
                        
                        if yser.uuid == data.uuid{
                            print("error:\(data.uuid)")
                            return true
                        }
                        else{
                            return false
                        }
                    }
                    //5906+1863+1198
                    self.davedata2(userData)
                    return
                }
                FirebaseData.updateUserData1(userDataa.id!, dic: data) { error in
                    if let error = error {
                        print("erorrr:\(error.localizedDescription)")
                        //print("error:\(data.uuid)")
                        //PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                        userData.removeAll { yser in
                            
                            if yser.uuid == data.uuid{
                                print("error:\(data.uuid)")
                                return true
                            }
                            else{
                                return false
                            }
                        }
                        self.davedata2(userData)
                        return
                    }
                    userData.removeAll { yser in
                        
                        if yser.uuid == data.uuid{
                            print("save:\(data.uuid)")
                            return true
                        }
                        else{
                            return false
                        }
                    }
                    self.davedata2(userData)
                    
                }
                        
                    }

        }
        else{
            self.davedata2(userData)
        }
    }
    func davedrinkdata(_ userData:[UserModel]){
        for var dd in userData{
            if dd.uuid <= 1424{
                dd.isAdded = true
            }
        }
        let userdta = userData.first { userdtaa in
            return userdtaa.isAdded == false
        }
        if let data = userdta{
//            FirebaseData.createUserData(email: data.cemail, password: data.cpassword) { result, error in
//                if let result = result {
//                    print("uid:\(result.user.uid)")
            
            FirebaseData.getUserData1(uid: data.uuid) { error, userDataa in
                
                        if let error = error {
                            print("erorrr:\(error.localizedDescription)")
                            print("error:\(data.uuid)")
                            self.davedrinkdata(userData)
                            //PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                            return
                        }
                guard let userDataa = userDataa else {
                    self.davedrinkdata(userData)
                    return
                }
                FirebaseData.updateUserData1(userDataa.id!, dic: data) { error in
                    if let error = error {
                        print("erorrr:\(error.localizedDescription)")
                        print("error:\(data.uuid)")
                        self.davedrinkdata(userData)
                        //PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                        return
                    }
                    for var dta in userData{
                        if dta.uuid == data.uuid{
                            dta.isAdded = true
                            print("saved:\(dta.uuid)")
                        }
                    }
                    self.davedrinkdata(userData)
                }
                        
                    }
//                }else {
//                    print("erorrr:\(error?.localizedDescription ?? "")")
//                    for dta in userData{
//                        if dta.cemail == data.cemail{
//                            dta.isAdded = true
//                        }
//                    }
//                    self.davedata(userData)
//                    return
//
//                }
                
            //}
        }
        else{
            print("error:")
            self.davedrinkdata(userData)
        }
    }
    func dletData(_ userData:[UserModel]?){
        guard var userData = userData else {
            return
        }
        let userdta = userData.first { userdtaa in
            return userdtaa.isAdded == false
        }
        if let data = userdta{
            print("uuids:\(data.uuid)")
            FirebaseData.deleteUserData2(uid: data.id!) { error in
                        if let error = error {
                            print("erorrr:\(error.localizedDescription)")
                            print("error:\(data.uuid)")
                            //self.davedata1(userData)
                            //PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                            return
                        }
                for (i,dta) in userData.enumerated(){
                    if dta.uuid == data.uuid{
                        userData[i].isAdded = true
                    }
                }
//                userData.removeAll { dta in
//                    if dta.uuid == data.uuid{
//                        return true
//                    }
//                    else{
//                        return false
//                    }
//                }
                self.dletData(userData)
            }

        }
    }
    func loadBarTest1(){
        FirebaseData.getUserData2{error, userAddData in
            
            guard let userAddData = userAddData else {
                return
            }
            var arry = [UserModel]()
            for var data in userAddData{
                if data.uuid%10 == 0{
                    print("uiid:\(data.uuid)")
                    data.isAdded = false
                    arry.append(data)
                }
            }
            self.davedata1(arry)
            //self.dletData(arry)
        }
    }
    func getTestForUpdate(){
        if !isFirstAnimating{
            PopupHelper.showAnimating(controler:self)
        }
        
        FirebaseData.getUserTestListDate { error, userAddData,userChnageData,userDeleteData in
            //PopupHelper.stopAnimating(controler: self)
            //self.stopAnimating()
            guard var userAddData = userAddData,let  _ = userChnageData,let _ = userDeleteData else {
                return
            }
            var count:Int64 = 0
            for (i,_) in userAddData.enumerated(){
                count += 1
                userAddData[i].isAdded = false
                userAddData[i].uuid = count
            }
            //self.loadTestForUpdate(userAddData)

        }
    }
    func loadTestForUpdate(_ userDataa:[BarModelW]){
        if let dta = userDataa.first(where: { barModelW in
            return barModelW.updated == false
        }){
            FirebaseData.getUserFromEmailData(email: dta.cemail) { error, userData in
                guard var userData = userData else {return}
                if let weekday = dta.barWeekDay,let weekday1 = userData.barWeekDay{
                    for week in weekday{
                        for (i,week1) in weekday1.enumerated(){
                            if week.weekDay == week1.weekDay?.rawValue && week.name == week1.name{
                                userData.barWeekDay?[i].svalue = week.svalue
                                userData.barWeekDay?[i].evalue = week.evalue
                            }
                        }
                    }
                }
                FirebaseData.updateUserData1(userData.id!, dic: userData) { error in
                    print("updated")
                    for dtaa in userDataa{
                        if dta.cemail == dtaa.cemail{
                            dtaa.updated = true
                        }
                    }
                    self.loadTestForUpdate(userDataa)
                }
            }
        }
        else{
            print("updated all")
        }
            
    }
    func loadBars(){
        
        WebServicesHelper.callWebService(suburl:"10?a=\(Int.random(in: 0...1000))",action: .getallsstore, httpMethodName: .get) { indx,action,isNetwork, error, dataDict in
            
            
            if isNetwork{
                if let _ = error{
                    //PopupHelper.showAlertControllerWithError(forErrorMessage: err, forViewController: self)
                }
                else{
                    if let dic = dataDict as? Dictionary<String,Any>{
                        switch action {
                        case .getallsstore:
                            if let result = dic["result"] as? NSArray{
                                self.barArray.removeAll()
                                self.annotaionArray.removeAll()
                                var barArray = [BarModelW]()
                                for data2 in result{
                                    if let data1 = data2 as? NSDictionary{
                                        if let data = data1["bar_info"] as? NSDictionary{
                                            let status = data1[Constant.status] as? String
                                            let user = UserModelW(dic: data)
                                            user?.status = status
                                            
                                            do{
                                                let jsonDecoder = JSONDecoder()
                                                //jsonDecoder.dataDecodingStrategy = .base64
                                                let data1 = user?.bdetail.data(using: .utf8)
                                                let bar = try jsonDecoder.decode(BarModelW.self, from: data1!)
                                                
                                                bar.cemail = user?.cemail.replacingOccurrences(of: ",", with: ";")
                                                bar.updated = false
                                                barArray.append(bar)
                                                
                                                
                                            }
                                            catch let error{
                                                print(error.localizedDescription)
                                                //PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                                                PopupHelper.stopAnimating(controler: self)
                                                //return
                                            }
                                            
                                        }
                                    }
                                    
                                }
                                self.loadTestForUpdate(barArray)
                                
                            }
                            else if let message = dic["message"] as? String{
                                PopupHelper.showAlertControllerWithError(forErrorMessage: message, forViewController: self)
                            }
                            
                            
                        default:
                            break
                        }
                    }
                }
            }
            else{
                //PopupHelper.alertWithNetwork(title: "Network Connection".localized(), message: "Please connect your internet connection".localized(), controler: self)
                
            }
            
        }
    }
    func loadBarTest(){
        if !isFirstAnimating{
            PopupHelper.showAnimating(controler:self)
        }
//        FirebaseData.getUserListListener { error, userData in
//            guard var userAddData = userData else {
//                return
//            }
//            DispatchQueue.background {
//                print("background:")
//                userAddData.sort { user1, user2 in
//                    return user1.uuid > user2.uuid
//                }
//
//                if userAddData.count > 0{
//                    self.barArray.removeAll()
//                    for data in userAddData{
//                        if data.uuid%10 == 0{
//                            if String(data.uuid).count > 10{
//                                self.barArray.append(data)
//                            }
//
//                        }
//
//                    }
//                    userAddData.sort { user1, user2 in
//                        return user1.uuid < user2.uuid
//                    }
//                    for data in userAddData{
//                        if data.uuid%10 == 0{
//                            self.barArray.append(data)
//
//                        }
//
//                    }
//
//                }
//                self.annotaionArray.removeAll()
//                for dta in self.barArray{
//                    if dta.bname.contains("Picalagartos"){
//                        print("docid:\(dta.docId)")
//                    }
//                    let anotation = AnnotationModel(title: dta.bname,barImage: dta.image, location: CLLocationCoordinate2D(latitude: dta.blat ?? 0.0, longitude: dta.blng ?? 0.0),barHas: dta.barHas,weekDay: dta.barWeekDay,barId: dta.docId,barData: dta,uuid: dta.uuid)
//                    print("barss:\(dta.uuid)")
//                    for data in dta.barHas{
//                        if let top = OnlyShowModel(dictionary: data as AnyObject){
//                            if top.title == "Rooftops"{
//                                anotation.rooftop = top
//                            }
//                            else{
//                                anotation.terrace = top
//                            }
//                        }
//                    }
//                    if dta.isAnnounce{
//                        if dta.isFreeTable{
//                            anotation.announce = .Both_announcement_and_free_table
//                        }
//                        else{
//                            anotation.announce = .Announcement
//                        }
//                        anotation.annouceName = dta.announce
//                    }
//                    else{
//                        if dta.isFreeTable{
//                            anotation.announce = .Free_table_on_the_terrace
//                        }
//                        else{
//                            anotation.announce = .None
//                        }
//                    }
//                    switch anotation.announce {
//                    case .None:
//                        if let roof = anotation.rooftop{
//                            if roof.isSelected{
//                                anotation.pinImage = "Rooftop"
//                            }
//                            else{
//                                anotation.pinImage = "Bar"
//                            }
//                        }
//                        else{
//                            anotation.pinImage = "Bar"
//                        }
//
//
//                    case .Announcement:
//                        if let roof = anotation.rooftop{
//                            if roof.isSelected{
//                                anotation.pinImage = "RooftopBlue"
//                            }
//                            else{
//                                anotation.pinImage = "Group 21"
//                            }
//                        }
//                        else{
//                            anotation.pinImage = "Group 21"
//                        }
//
//                    case .Free_table_on_the_terrace:
//
//                        if let roof = anotation.rooftop{
//                            if roof.isSelected{
//                                anotation.pinImage = "RooftopRed"
//                            }
//                            else{
//                                anotation.pinImage = "Group 58"
//                            }
//                        }
//                        else{
//                            anotation.pinImage = "Group 58"
//                        }
//                    case .Both_announcement_and_free_table:
//                        if let roof = anotation.rooftop{
//                            if roof.isSelected{
//                                anotation.pinImage = "RooftopRed"
//                            }
//                            else{
//                                anotation.pinImage = "Group 58"
//                            }
//                        }
//                        else{
//                            anotation.pinImage = "Group 58"
//                        }
//                    default:
//                        break
//                    }
//                    anotation.isAdded = dta.isAdded
//                    self.annotaionArray.append(anotation)
//
//                }
//            } completion: {
//                print("mainthread:")
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                    self.isFirstTimeRun = true
//                    if self.isLive{
////                        if self.Mapbox.cameraState.zoom < 10{
//                            self.reloadLive(self.annotaionArray,countrs: 500)
////                        }
////                        else{
////                            self.reloadLive(self.annotaionArray,countrs: 500)
////                        }
//                    }
//                    else{
////                        if self.Mapbox.cameraState.zoom < 10{
//                            self.reloadNonLive(self.annotaionArray,countrs: 500)
////                        }
////                        else{
////                            self.reloadNonLive(self.annotaionArray,countrs: 500)
////                        }
//                    }
//                }
//            }
//
//
//        }
        FirebaseData.getUserListListener { error, userAddData,userChnageData,userDeleteData, type in
            //PopupHelper.stopAnimating(controler: self)
            //self.stopAnimating()
            guard var userAddData = userAddData,var userChnageData = userChnageData,var userDeleteData = userDeleteData else {
                return
            }
            print("barArrayCount:\(userAddData.count)")
//            switch type{
//            case .added:
//                print("add")
//            case .modified:
//                print("update")
//            case .removed:
//                print("delete")
//            default:
//                break
//            }
            DispatchQueue.background {
                print("background:")
                userAddData.sort { user1, user2 in
                    return user1.uuid > user2.uuid
                }
                userChnageData.sort { user1, user2 in
                    return user1.uuid > user2.uuid
                }
                userDeleteData.sort { user1, user2 in
                    return user1.uuid > user2.uuid
                }

                if userAddData.count > 0{
                    //self.barArray.removeAll()
                    if !self.isFirstAnimating{
                        self.isFirstAnimating = true
                        for data in userAddData{
                            self.barArray.append(data)
                        }
//                        for data in userAddData{
//                            if data.uuid%10 == 0{
//                                print(data.uuid)
//                                if String(data.uuid).count > 10{
//                                    self.barArray.append(data)
//                                }
//
//                            }
//
//                        }
//                        userAddData.sort { user1, user2 in
//                            return user1.uuid < user2.uuid
//                        }
//                        for data in userAddData{
//                            if data.uuid%10 == 0{
//                                self.barArray.append(data)
//
//                            }
//
//                        }
                    }
                    else{
                        var arr = [UserModel]()
                        for data in userAddData{
                            arr.append(data)

                        }
                        self.barArray.forEach { user in
                            arr.append(user)
                        }
                        self.barArray = arr
//                        for data in userAddData{
//                            if data.uuid%10 == 0{
//                                if String(data.uuid).count > 10{
//                                    arr.append(data)
//                                }
//
//                            }
//
//                        }
//                        self.barArray.forEach { user in
//                            arr.append(user)
//                        }
//                        self.barArray = arr
                    }
                    
//                    for data in userAddData{
//                        if data.uuid%10 != 0{
//                            self.barArray.append(data)
//                        }
//
//                    }

                }
                print("barArray:\(self.barArray.count)")

                if userChnageData.count > 0{
                    var arr = self.barArray
                    for (i,user1) in arr.enumerated(){
                        //user1.isAdded = true
                        userChnageData.forEach { user2 in
                            if user1.uuid == user2.uuid{
                                print("changed:\(user1.uuid)")
                                arr[i] = user2
                            }
                        }
                    }
                    self.barArray = arr
                }

                if userDeleteData.count > 0{
                    var arr = self.barArray
                    arr.removeAll { user1 in
                        for user2 in userDeleteData{
                            if user1.uuid == user2.uuid{
                                print("delete:\(user1.uuid)")
                              return true
                            }
                            else{
                                return false
                            }
                        }
                        return false
                    }
                    self.barArray = arr
                }
                
                var annoArray = [AnnotationModel]()
                for dta in self.barArray{
//                    if dta.bname.contains("Picalagartos"){
//                        print("docid:\(dta.id)")
//                    }
                    let anotation = AnnotationModel(title: dta.bname,barImage: dta.image, location: CLLocationCoordinate2D(latitude: dta.blat ?? 0.0, longitude: dta.blng ?? 0.0),barHas: dta.barHas,weekDay: dta.barWeekDay,barId: dta.id,barData: dta,uuid: dta.uuid)
                    print("barss:\(dta.uuid)")
                    for data in dta.barHas!{
                        if data.title == "Rooftops" || data.title == "Rooftop"{
                            anotation.rooftop = data
                        }
                        else{
                            anotation.terrace = data
                        }
                    }
                    if dta.isAnnounce{
                        if dta.isFreeTable{
                            anotation.announce = .Both_announcement_and_free_table
                        }
                        else{
                            anotation.announce = .Announcement
                        }
                        anotation.annouceName = dta.announce
                    }
                    else{
                        if dta.isFreeTable{
                            anotation.announce = .Free_table_on_the_terrace
                        }
                        else{
                            anotation.announce = .None
                        }
                    }
                    switch anotation.announce {
                    case .None:
                        if let roof = anotation.rooftop{
                            if roof.isSelected{
                                anotation.pinImage = "Rooftop"
                            }
                            else{
                                anotation.pinImage = "Bar"
                            }
                        }
                        else{
                            anotation.pinImage = "Bar"
                        }


                    case .Announcement:
                        if let roof = anotation.rooftop{
                            if roof.isSelected{
                                anotation.pinImage = "RooftopBlue"
                            }
                            else{
                                anotation.pinImage = "Group 21"
                            }
                        }
                        else{
                            anotation.pinImage = "Group 21"
                        }

                    case .Free_table_on_the_terrace:

                        if let roof = anotation.rooftop{
                            if roof.isSelected{
                                anotation.pinImage = "RooftopRed"
                            }
                            else{
                                anotation.pinImage = "Group 58"
                            }
                        }
                        else{
                            anotation.pinImage = "Group 58"
                        }
                    case .Both_announcement_and_free_table:
                        if let roof = anotation.rooftop{
                            if roof.isSelected{
                                anotation.pinImage = "RooftopRed"
                            }
                            else{
                                anotation.pinImage = "Group 58"
                            }
                        }
                        else{
                            anotation.pinImage = "Group 58"
                        }
                    default:
                        break
                    }
                    anotation.isAdded = dta.isAdded
                    annoArray.append(anotation)

                }
                self.annotaionArray = annoArray
            } completion: {
                print("mainthread:\(self.annotaionArray.count)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.isFirstTimeRun = true
                    if self.isLive{
                        if self.Mapbox.cameraState.zoom < 10{
                            self.reloadLive(self.annotaionArray,countrs: 20)
                        }
                        else{
                            self.reloadLive(self.annotaionArray,countrs: 50)
                        }
                    }
                    else{
                        if self.Mapbox.cameraState.zoom < 10{
                            self.reloadNonLive(self.annotaionArray,countrs: 20)
                        }
                        else{
                            self.reloadNonLive(self.annotaionArray,countrs: 50)
                        }
                    }
                }
            }



            self.loadMap()
        }
    }
    func loadBarTest2(){
        if !isFirstAnimating{
            PopupHelper.showAnimating(controler:self)
        }
        FirebaseData.getUserTestListData { error, userAddData,userChnageData,userDeleteData, type in

            guard let userAddData = userAddData,let _ = userChnageData,let _ = userDeleteData else {
                return
            }
            DispatchQueue.background {
                print("background:")
                if userAddData.count > 0{
                    //self.barArray.removeAll()
                    for data in userAddData{
                        if data.uuid%10 != 0{
                            print(data.uuid)
                            self.barArray.append(data)

                        }

                    }

                }
                print("barArray:\(self.barArray.count)")
                
            } completion: {
                print("mainthread:")
                self.dletData(self.barArray)
                
            }
        }
    }
    func loadBar1(){
        return
        if !isFirstAnimating{
            PopupHelper.showAnimating(controler:self)
        }
        FirebaseData.getUserListListener { error, userData in
            PopupHelper.stopAnimating(controler: self)
            guard let userData = userData else {
                return
            }
            
            self.barArray = userData
            self.annotaionArray.removeAll()
            for dta in userData{
                if dta.bname.contains("Picalagartos"){
                    print("docid:\(dta.id!)")
                }
                
                let anotation = AnnotationModel(title: dta.bname,barImage: dta.image, location: CLLocationCoordinate2D(latitude: dta.blat ?? 0.0, longitude: dta.blng ?? 0.0),barHas: dta.barHas,weekDay: dta.barWeekDay,barId: dta.id!,barData: dta)
                for data in dta.barHas!{
                    if data.title == "Rooftops"{
                        anotation.rooftop = data
                    }
                    else{
                        anotation.terrace = data
                    }
                }
                if dta.isAnnounce{
                    if dta.isFreeTable{
                        anotation.announce = .Both_announcement_and_free_table
                    }
                    else{
                        anotation.announce = .Announcement
                    }
                    anotation.annouceName = dta.announce
                }
                else{
                    if dta.isFreeTable{
                        anotation.announce = .Free_table_on_the_terrace
                    }
                    else{
                        anotation.announce = .None
                    }
                }
                switch anotation.announce {
                case .None:
                    if let roof = anotation.rooftop{
                        if roof.isSelected{
                            anotation.pinImage = "Rooftop"
                        }
                        else{
                            anotation.pinImage = "Bar"
                        }
                    }
                    else{
                        anotation.pinImage = "Bar"
                    }
                    
                    
                case .Announcement:
                    if let roof = anotation.rooftop{
                        if roof.isSelected{
                            anotation.pinImage = "RooftopBlue"
                        }
                        else{
                            anotation.pinImage = "Group 21"
                        }
                    }
                    else{
                        anotation.pinImage = "Group 21"
                    }
                    
                case .Free_table_on_the_terrace:
                    
                    if let roof = anotation.rooftop{
                        if roof.isSelected{
                            anotation.pinImage = "RooftopRed"
                        }
                        else{
                            anotation.pinImage = "Group 58"
                        }
                    }
                    else{
                        anotation.pinImage = "Group 58"
                    }
                case .Both_announcement_and_free_table:
                    if let roof = anotation.rooftop{
                        if roof.isSelected{
                            anotation.pinImage = "RooftopRed"
                        }
                        else{
                            anotation.pinImage = "Group 58"
                        }
                    }
                    else{
                        anotation.pinImage = "Group 58"
                    }
                default:
                    break
                }
                self.annotaionArray.append(anotation)
                
            }
            if self.isLive{
                self.reloadLive()
            }
            else{
                self.reloadNonLive()
            }
            self.loadMap()
        }
    }
    func reloadNonLive(_ annotaionArray:[AnnotationModel] = [],countrs:Int = 100,reCheck:Bool = false){
        if self.isFirstTimeRun{
            self.isFirstTimeRun = false
            self.isProcessing = true
            self.annotaionFilterArray.removeAll()
            self.annotaionFilterArray = annotaionArray
            
            self.filterNonLive()
            
//            var arr = [AnnotationModel]()
//            for (i,anno) in  self.annotaionFilterArray.enumerated(){
//                if i <= countrs{
//                    arr.append(anno)
//                }
//            }
//            self.annotaionFilterArray = arr
            if self.annotaionFilterArray.count > 0{
                print("count:\(self.annotaionFilterArray.count)")
                var pointArray = [PointAnnotation]()
                DispatchQueue.background {
                    for coordinate in self.annotaionFilterArray {
                        let curentloc = CLLocation(latitude: self.Mapbox.cameraState.center.latitude, longitude: self.Mapbox.cameraState.center.longitude)
                        let anno1loc = CLLocation(latitude: coordinate.location.latitude, longitude: coordinate.location.longitude)
                        var dist1 = curentloc.distance(from: anno1loc)
                        dist1 = dist1.metersToKilometer()
                        print("distance:\(dist1)")
                        if dist1 <= 2 //|| dist1 >= 10
                        {
                            if pointArray.count <= countrs{
                                coordinate.isAdded = true
                                var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                point.iconAnchor = .bottom
                                point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                var image:UIImage!
                                if coordinate.pinImage.contains("Rooftop"){
                                    
                                    image = UIImage(named: coordinate.pinImage)!
                                }
                                else /*if coordinate.pinImage.contains("Bar")*/{
                                    if let price = coordinate.barData.displayPrice{
                                        if price.first != "0"{
                                            image = UIImage(named: "Bar")!.drawImagesAndText1("\(price)€")
                                        }
                                        else{
                                            image = UIImage(named: "Bar")!.drawImagesAndText1("")
                                        }
                                        
                                    }
                                    else{
                                        image = UIImage(named: "Bar")!.drawImagesAndText1("")
                                    }
                                    
                                }
        //                        else{
        //                            point.iconAnchor = .bottom
        //                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "")€",isEvent: true)
        //                        }
                                point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.rooftop.isSelected.hashValue)")
                                //point.userInfo = coordinate.barData.dictionary
                                pointArray.append(point)
                            }
                            
                        }
                        
                        
                    }
                    print("count:\(pointArray.count)")
                    if pointArray.count == 0{
                        for coordinate in self.annotaionFilterArray{
                            if pointArray.count <= countrs{
                                var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                point.iconAnchor = .bottom
                                
                                point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                var image:UIImage!
                                if coordinate.pinImage.contains("Rooftop"){
                                    image = UIImage(named: coordinate.pinImage)!
                                }
                                else if coordinate.pinImage.contains("Bar"){
                                    
                                    if let price = coordinate.barData.displayPrice{
                                        if price.first != "0"{
                                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
                                        }
                                        else{
                                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                        }
                                    }
                                    else{
                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                    }
                                    
                                    
                                }
                                else{
                                    
                                    image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
                                }
                                point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
                                pointArray.append(point)
                            }
                            
                        }
                    }
                } completion: {
                    
                    DispatchQueue.main.async {
                        self.pointAnnotationManager.annotations = pointArray
                        self.pointAnnotationArray = pointArray
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        PopupHelper.stopAnimating(controler: self)
                        self.isProcessing = false
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    PopupHelper.stopAnimating(controler: self)
                }
            }
            
        }
        else{
            self.isProcessing = true
            var pointArray = [PointAnnotation]()
            DispatchQueue.background(delay: 1.0) {
                self.annotaionFilterArray = annotaionArray
                self.filterNonLive()
//                var arr = [AnnotationModel]()
//                for (i,anno) in  self.annotaionFilterArray.enumerated(){
//                    if i <= countrs{
//                        arr.append(anno)
//                    }
//                }
//                self.annotaionFilterArray = arr
                print("count:\(self.annotaionFilterArray.count)")
                
                for coordinate in self.annotaionFilterArray {
                    let curentloc = CLLocation(latitude: self.Mapbox.cameraState.center.latitude, longitude: self.Mapbox.cameraState.center.longitude)
                    let anno1loc = CLLocation(latitude: coordinate.location.latitude, longitude: coordinate.location.longitude)
                    var dist1 = curentloc.distance(from: anno1loc)
                    dist1 = dist1.metersToKilometer()
                    print("distance:\(dist1)")
                    if dist1 <= 2 //|| dist1 >= 10
                    {
                        if pointArray.count <= countrs{
                            coordinate.isAdded = true
                            var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                            point.iconAnchor = .bottom
                            point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                            var image:UIImage!
                            if coordinate.pinImage.contains("Rooftop"){
                                
                                image = UIImage(named: coordinate.pinImage)!
                            }
                            else /*if coordinate.pinImage.contains("Bar")*/{
                                if let price = coordinate.barData.displayPrice{
                                    if price.first != "0"{
                                        image = UIImage(named: "Bar")!.drawImagesAndText1("\(price)€")
                                    }
                                    else{
                                        image = UIImage(named: "Bar")!.drawImagesAndText1("")
                                    }
                                    
                                }
                                else{
                                    image = UIImage(named: "Bar")!.drawImagesAndText1("")
                                }
                                
                                
                            }
        //                        else{
        //                            point.iconAnchor = .bottom
        //                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "")€",isEvent: true)
        //                        }
                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.rooftop.isSelected.hashValue)")
                            
                            //point.userInfo = coordinate.barData.dictionary
                            pointArray.append(point)
                        }
                        
                    }
                    
                    print("count:\(pointArray.count)")
                    if pointArray.count == 0{
                        for coordinate in self.annotaionFilterArray{
                            if pointArray.count <= countrs{
                                var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                point.iconAnchor = .bottom
                                
                                point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                var image:UIImage!
                                if coordinate.pinImage.contains("Rooftop"){
                                    image = UIImage(named: coordinate.pinImage)!
                                }
                                else if coordinate.pinImage.contains("Bar"){
                                    
                                    if let price = coordinate.barData.displayPrice{
                                        if price.first != "0"{
                                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
                                        }
                                        else{
                                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                        }
                                    }
                                    else{
                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                    }
                                    
                                    
                                }
                                else{
                                    
                                    image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
                                }
                                point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
                                pointArray.append(point)
                            }
                        }
                    }
                }
            } completion: {
                DispatchQueue.main.async {
                    self.pointAnnotationManager.annotations = pointArray
                    self.pointAnnotationArray = pointArray
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    PopupHelper.stopAnimating(controler: self)
                    self.isProcessing = false
                }
            }

        }
        
        

    }
    func filterNonLive(){
        if let barhas = CommonHelper.getOnlyShowData(){
            if barhas.first!.isSelected{
                if barhas.last!.isSelected{
                    self.annotaionFilterArray.removeAll { annotationModel in
                        if annotationModel.rooftop!.isSelected || annotationModel.terrace!.isSelected{
                            return false
                            
                        }
                        else {
                            return true
                        }
                    }
                }
                else{
                    self.annotaionFilterArray.removeAll { annotationModel in
                        if !annotationModel.rooftop!.isSelected && annotationModel.terrace!.isSelected{
                            return false
                            
                        }
                        else {
                            return true
                        }
                    }
                }
            }
            else if barhas.last!.isSelected{
                self.annotaionFilterArray.removeAll { annotationModel in
                    if annotationModel.rooftop!.isSelected{
                        return false
                        
                    }
                    else {
                        return true
                    }
                }
            }
            else{
                
            }
        }
    }
    func reloadLive(_ annotaionArray:[AnnotationModel] = [],countrs:Int = 100,reCheck:Bool = false){
        
        if isFirstTimeRun{
            self.isFirstTimeRun = false
            self.isProcessing = true
            self.annotaionFilterArray = annotaionArray
                
            self.filterLive()
//            var arr = [AnnotationModel]()
//            for (i,anno) in  annotaionFilterArray.enumerated(){
//                if i <= countrs{
//                    arr.append(anno)
//                }
//            }
//            self.annotaionFilterArray = arr
            print("count:\(self.annotaionFilterArray.count)")
            if self.annotaionFilterArray.count > 0{
                var pointArray = [PointAnnotation]()
                DispatchQueue.background {
                    if self.pointAnnotationManager.annotations.count > 0{
                        for anno in self.pointAnnotationManager.annotations{
                            self.Mapbox.annotations.removeAnnotationManager(withId: anno.id)
                        }
                    }
                    switch self.Mapbox.cameraState.zoom{
                    case 0...5:
                        
                        for coordinate in self.annotaionFilterArray {
                            let curentloc = CLLocation(latitude: self.Mapbox.cameraState.center.latitude, longitude: self.Mapbox.cameraState.center.longitude)
                            let anno1loc = CLLocation(latitude: coordinate.location.latitude, longitude: coordinate.location.longitude)
                            var dist1 = curentloc.distance(from: anno1loc)
                            dist1 = dist1.metersToKilometer()
                            print("distance:\(dist1)")
                            if dist1 <= 4 //|| dist1 >= 10
                            {
                                if pointArray.count <= countrs{
                                    
                                    print("coordinate:\(coordinate.uuid)")
                                    coordinate.isAdded = true
                                    var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                    point.iconAnchor = .bottom
                                    
                                    point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                    var image:UIImage!
                                    if coordinate.pinImage.contains("Rooftop"){
                                        image = UIImage(named: coordinate.pinImage)!
                                    }
                                    else if coordinate.pinImage.contains("Bar"){
                                        
                                        if let price = coordinate.barData.displayPrice{
                                            if price.first != "0"{
                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
                                            }
                                            else{
                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                            }
                                        }
                                        else{
                                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                        }
                                        
                                        
                                    }
                                    else{
                                        
                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
                                    }
                                    point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
                                    //                        if coordinate.barData.isAnnounce{
                                    //                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)")
                                    //                        }
                                    //                        else if coordinate.barData.isFreeTable{
                                    //                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isFreeTable.hashValue)")
                                    //                        }
                                    //                        else{
                                    //                            point.image = .init(image: image, name: "\(coordinate.uuid)")
                                    //                        }
                                    
                                    
                                    //point.userInfo = coordinate.barData.dictionary
                                    pointArray.append(point)
                                }
                            }
                        }
//                        case 6...8:
//                            continue
                    case 6...10:
                        let grouparray = Dictionary(grouping: self.annotaionFilterArray, by: { AnnotationModel2 in
                            return AnnotationModel2.barData.rangeKm
                        })
                        for ids in grouparray.keys{
                            if let data = grouparray[ids]{
                                if data.count > 8{
                                    for i in 0..<9{
                                         let coordinate = data[i]
                                            print("coordinate:\(coordinate.uuid)")
                                            coordinate.isAdded = true
                                            var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                            point.iconAnchor = .bottom
                                            
                                            point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                            var image:UIImage!
                                            if coordinate.pinImage.contains("Rooftop"){
                                                image = UIImage(named: coordinate.pinImage)!
                                            }
                                            else if coordinate.pinImage.contains("Bar"){
                                                
                                                if let price = coordinate.barData.displayPrice{
                                                    if price.first != "0"{
                                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
                                                    }
                                                    else{
                                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                                    }
                                                }
                                                else{
                                                    image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                                }
                                                
                                                
                                            }
                                            else{
                                                
                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
                                            }
                                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
                                            pointArray.append(point)
                                        }
                                    
                                }
                                else{
                                    for coordinate in data{
                                        
                                            print("coordinate:\(coordinate.uuid)")
                                            coordinate.isAdded = true
                                            var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                            point.iconAnchor = .bottom
                                            
                                            point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                            var image:UIImage!
                                            if coordinate.pinImage.contains("Rooftop"){
                                                image = UIImage(named: coordinate.pinImage)!
                                            }
                                            else if coordinate.pinImage.contains("Bar"){
                                                
                                                if let price = coordinate.barData.displayPrice{
                                                    if price.first != "0"{
                                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
                                                    }
                                                    else{
                                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                                    }
                                                }
                                                else{
                                                    image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                                }
                                                
                                                
                                            }
                                            else{
                                                
                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
                                            }
                                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
                                            pointArray.append(point)
                                        }
                                    
                                }
                                
                            }
                        }
                    case 11...14:
                        let grouparray = Dictionary(grouping: self.annotaionFilterArray, by: { AnnotationModel2 in
                            return AnnotationModel2.barData.rangeKm
                        })
                        for ids in grouparray.keys{
                            if let data = grouparray[ids]{
                                if data.count > 15{
                                    for i in 0..<16{
                                         let coordinate = data[i]
                                            print("coordinate:\(coordinate.uuid)")
                                            coordinate.isAdded = true
                                            var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                            point.iconAnchor = .bottom
                                            
                                            point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                            var image:UIImage!
                                            if coordinate.pinImage.contains("Rooftop"){
                                                image = UIImage(named: coordinate.pinImage)!
                                            }
                                            else if coordinate.pinImage.contains("Bar"){
                                                
                                                if let price = coordinate.barData.displayPrice{
                                                    if price.first != "0"{
                                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
                                                    }
                                                    else{
                                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                                    }
                                                }
                                                else{
                                                    image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                                }
                                                
                                                
                                            }
                                            else{
                                                
                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
                                            }
                                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
                                            pointArray.append(point)
                                        }
                                    
                                }
                                else{
                                    for coordinate in data{
                                        
                                            print("coordinate:\(coordinate.uuid)")
                                            coordinate.isAdded = true
                                            var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                            point.iconAnchor = .bottom
                                            
                                            point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                            var image:UIImage!
                                            if coordinate.pinImage.contains("Rooftop"){
                                                image = UIImage(named: coordinate.pinImage)!
                                            }
                                            else if coordinate.pinImage.contains("Bar"){
                                                
                                                if let price = coordinate.barData.displayPrice{
                                                    if price.first != "0"{
                                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
                                                    }
                                                    else{
                                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                                    }
                                                }
                                                else{
                                                    image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                                }
                                                
                                                
                                            }
                                            else{
                                                
                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
                                            }
                                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
                                            pointArray.append(point)
                                        }
                                    
                                }
                                
                            }
                        }
                    case 15...18:
                        break
                        default:
                        break
                    }
                    
                    print("count:\(pointArray.count)")
                    if pointArray.count == 0{
                        for coordinate in self.annotaionFilterArray{
                            if pointArray.count <= countrs{
                                var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                point.iconAnchor = .bottom
                                
                                point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                var image:UIImage!
                                if coordinate.pinImage.contains("Rooftop"){
                                    image = UIImage(named: coordinate.pinImage)!
                                }
                                else if coordinate.pinImage.contains("Bar"){
                                    
                                    if let price = coordinate.barData.displayPrice{
                                        if price.first != "0"{
                                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
                                        }
                                        else{
                                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                        }
                                    }
                                    else{
                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                    }
                                    
                                    
                                }
                                else{
                                    
                                    image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
                                }
                                point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
                                pointArray.append(point)
                            }
                            
                        }
                    }
                } completion: {
                    
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionCurlUp, animations: {
                            self.pointAnnotationManager.annotations = pointArray
                            self.pointAnnotationArray = pointArray
                            print("pointArray:\(pointArray.count)")
                        }, completion: nil)
                        
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.isProcessing = false
                        PopupHelper.stopAnimating(controler: self)
                    }
                }
            }
            
        }
        else{
            self.annotaionFilterArray = annotaionArray
            self.isProcessing = true
            self.filterLive()
//            var arr = [AnnotationModel]()
//            for (i,anno) in  annotaionFilterArray.enumerated(){
//                if i <= countrs{
//                    arr.append(anno)
//                }
//            }
//            self.annotaionFilterArray = arr
            if self.annotaionFilterArray.count > 0{
                var pointArray = [PointAnnotation]()
                DispatchQueue.background(delay: 1.0) {
                    
                    switch self.Mapbox.cameraState.zoom{
                    case 0...9:
                        
                        for coordinate in self.annotaionFilterArray {
                            let curentloc = CLLocation(latitude: self.Mapbox.cameraState.center.latitude, longitude: self.Mapbox.cameraState.center.longitude)
                            let anno1loc = CLLocation(latitude: coordinate.location.latitude, longitude: coordinate.location.longitude)
                            var dist1 = curentloc.distance(from: anno1loc)
                            dist1 = dist1.metersToKilometer()
                            print("distance:\(dist1)")
                            if dist1 <= 4 //|| dist1 >= 10
                            {
                                if pointArray.count <= countrs{
                                    
                                    print("coordinate:\(coordinate.uuid)")
                                    coordinate.isAdded = true
                                    var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                    point.iconAnchor = .bottom
                                    
                                    point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                    var image:UIImage!
                                    if coordinate.pinImage.contains("Rooftop"){
                                        image = UIImage(named: coordinate.pinImage)!
                                    }
                                    else if coordinate.pinImage.contains("Bar"){
                                        
                                        if let price = coordinate.barData.displayPrice{
                                            if price.first != "0"{
                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
                                            }
                                            else{
                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                            }
                                        }
                                        else{
                                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                        }
                                        
                                        
                                    }
                                    else{
                                        
                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
                                    }
                                    point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
                                    //                        if coordinate.barData.isAnnounce{
                                    //                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)")
                                    //                        }
                                    //                        else if coordinate.barData.isFreeTable{
                                    //                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isFreeTable.hashValue)")
                                    //                        }
                                    //                        else{
                                    //                            point.image = .init(image: image, name: "\(coordinate.uuid)")
                                    //                        }
                                    
                                    
                                    //point.userInfo = coordinate.barData.dictionary
                                    pointArray.append(point)
                                }
                            }
                        }
//                        case 6...8:
//                            continue
                    case 10...13:
                        for coordinate in self.annotaionFilterArray {
                            let curentloc = CLLocation(latitude: self.Mapbox.cameraState.center.latitude, longitude: self.Mapbox.cameraState.center.longitude)
                            let anno1loc = CLLocation(latitude: coordinate.location.latitude, longitude: coordinate.location.longitude)
                            var dist1 = curentloc.distance(from: anno1loc)
                            dist1 = dist1.metersToKilometer()
                            print("distance:\(dist1)")
                            if dist1 <= 3 //|| dist1 >= 10
                            {
                                if pointArray.count <= countrs{
                                    
                                    print("coordinate:\(coordinate.uuid)")
                                    coordinate.isAdded = true
                                    var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                    point.iconAnchor = .bottom
                                    
                                    point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                    var image:UIImage!
                                    if coordinate.pinImage.contains("Rooftop"){
                                        image = UIImage(named: coordinate.pinImage)!
                                    }
                                    else if coordinate.pinImage.contains("Bar"){
                                        
                                        if let price = coordinate.barData.displayPrice{
                                            if price.first != "0"{
                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
                                            }
                                            else{
                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                            }
                                        }
                                        else{
                                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                        }
                                    }
                                    else{
                                        
                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
                                    }
                                    point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
                                    //                        if coordinate.barData.isAnnounce{
                                    //                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)")
                                    //                        }
                                    //                        else if coordinate.barData.isFreeTable{
                                    //                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isFreeTable.hashValue)")
                                    //                        }
                                    //                        else{
                                    //                            point.image = .init(image: image, name: "\(coordinate.uuid)")
                                    //                        }
                                    
                                    
                                    //point.userInfo = coordinate.barData.dictionary
                                    pointArray.append(point)
                                }
                            }
                        }
//                    case 11...14:
//                        let grouparray = Dictionary(grouping: self.annotaionFilterArray, by: { AnnotationModel2 in
//                            return AnnotationModel2.barData.rangeKm
//                        })
//                        for ids in grouparray.keys{
//                            if let data = grouparray[ids]{
//                                if data.count > 15{
//                                    for i in 0..<16{
//                                         let coordinate = data[i]
//                                            print("coordinate:\(coordinate.uuid)")
//                                            coordinate.isAdded = true
//                                            var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
//                                            point.iconAnchor = .bottom
//
//                                            point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
//                                            var image:UIImage!
//                                            if coordinate.pinImage.contains("Rooftop"){
//                                                image = UIImage(named: coordinate.pinImage)!
//                                            }
//                                            else if coordinate.pinImage.contains("Bar"){
//
//                                                if let price = coordinate.barData.displayPrice{
//                                                    if price.first != "0"{
//                                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
//                                                    }
//                                                    else{
//                                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
//                                                    }
//                                                }
//                                                else{
//                                                    image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
//                                                }
//
//
//                                            }
//                                            else{
//
//                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
//                                            }
//                                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
//                                            pointArray.append(point)
//                                        }
//
//                                }
//                                else{
//                                    for coordinate in data{
//
//                                            print("coordinate:\(coordinate.uuid)")
//                                            coordinate.isAdded = true
//                                            var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
//                                            point.iconAnchor = .bottom
//
//                                            point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
//                                            var image:UIImage!
//                                            if coordinate.pinImage.contains("Rooftop"){
//                                                image = UIImage(named: coordinate.pinImage)!
//                                            }
//                                            else if coordinate.pinImage.contains("Bar"){
//
//                                                if let price = coordinate.barData.displayPrice{
//                                                    if price.first != "0"{
//                                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
//                                                    }
//                                                    else{
//                                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
//                                                    }
//                                                }
//                                                else{
//                                                    image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
//                                                }
//
//
//                                            }
//                                            else{
//
//                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
//                                            }
//                                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
//                                            pointArray.append(point)
//                                        }
//
//                                }
//
//                            }
//                        }
                    case 14...18:
                        for coordinate in self.annotaionFilterArray {
                            let curentloc = CLLocation(latitude: self.Mapbox.cameraState.center.latitude, longitude: self.Mapbox.cameraState.center.longitude)
                            let anno1loc = CLLocation(latitude: coordinate.location.latitude, longitude: coordinate.location.longitude)
                            var dist1 = curentloc.distance(from: anno1loc)
                            dist1 = dist1.metersToKilometer()
                            print("distance:\(dist1)")
                            if dist1 <= 1 //|| dist1 >= 10
                            {
                                if pointArray.count <= countrs{
                                    
                                    print("coordinate:\(coordinate.uuid)")
                                    coordinate.isAdded = true
                                    var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                    point.iconAnchor = .bottom
                                    
                                    point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                    var image:UIImage!
                                    if coordinate.pinImage.contains("Rooftop"){
                                        image = UIImage(named: coordinate.pinImage)!
                                    }
                                    else if coordinate.pinImage.contains("Bar"){
                                        
                                        if let price = coordinate.barData.displayPrice{
                                            if price.first != "0"{
                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
                                            }
                                            else{
                                                image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                            }
                                        }
                                        else{
                                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                        }
                                        
                                        
                                    }
                                    else{
                                        
                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
                                    }
                                    point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
                                    //                        if coordinate.barData.isAnnounce{
                                    //                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)")
                                    //                        }
                                    //                        else if coordinate.barData.isFreeTable{
                                    //                            point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isFreeTable.hashValue)")
                                    //                        }
                                    //                        else{
                                    //                            point.image = .init(image: image, name: "\(coordinate.uuid)")
                                    //                        }
                                    
                                    
                                    //point.userInfo = coordinate.barData.dictionary
                                    pointArray.append(point)
                                }
                            }
                        }
                        default:
                        break
                    }
                    print("count:\(pointArray.count)")
                    if pointArray.count == 0{
                        for coordinate in self.annotaionFilterArray{
                            if pointArray.count <= countrs{
                                var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
                                point.iconAnchor = .bottom
                                
                                point.userInfo = ["pinImage":coordinate.pinImage ?? "","displayPrice":coordinate.barData.displayPrice ?? "","uuid":coordinate.uuid]
                                var image:UIImage!
                                if coordinate.pinImage.contains("Rooftop"){
                                    image = UIImage(named: coordinate.pinImage)!
                                }
                                else if coordinate.pinImage.contains("Bar"){
                                    
                                    if let price = coordinate.barData.displayPrice{
                                        if price.first != "0"{
                                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(price)€")
                                        }
                                        else{
                                            image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                        }
                                    }
                                    else{
                                        image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("")
                                    }
                                    
                                    
                                }
                                else{
                                    
                                    image = UIImage(named: coordinate.pinImage)!.drawImagesAndText1("\(coordinate.barData.displayPrice ?? "0")€",isEvent: true)
                                }
                                point.image = .init(image: image, name: "\(coordinate.uuid)\(coordinate.barData.isAnnounce.hashValue)\(coordinate.barData.isFreeTable.hashValue)\(coordinate.rooftop.isSelected.hashValue)\(coordinate.barData.displayPrice ?? "0")")
                                pointArray.append(point)
                            }
                            
                        }
                    }
                    
                } completion: {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionCurlUp, animations: {
                            self.pointAnnotationManager.annotations = pointArray
                            self.pointAnnotationArray = pointArray
                            print("pointArray:\(pointArray.count)")
                        }, completion: nil)
                        
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        PopupHelper.stopAnimating(controler: self)
                        self.isProcessing = false
                    }
                }
            }
            

            
        }
        
//        var point = PointAnnotation(id: "\(FirebaseData.getCurrentUserId().0)", point: Point(self.myLocation))
//        point.iconAnchor = .bottom
//        point.image = .init(image: UIImage(named: "Me")!, name:"Me")
//        self.pointAnnotationManager.annotations.append(point)

    }
    func filterLive(){
        if let barhas = CommonHelper.getOnlyShowData(){
            if barhas.first!.isSelected{
                if barhas.last!.isSelected{
                    self.annotaionFilterArray.removeAll { annotationModel in
                        if annotationModel.rooftop!.isSelected || annotationModel.terrace.isSelected{
                            if self.isLive{
                                if annotationModel.barData.isopend{
                                    return true
                                }
                                else{
                                    return false
                                }
                            }
                            else{
                                return false
                            }
                        }
                        else {
                            return true
                        }
                    }
                }
                else{
                    self.annotaionFilterArray.removeAll { annotationModel in
                        if !annotationModel.rooftop!.isSelected && annotationModel.terrace!.isSelected{
                            if annotationModel.barData.isopend{
                                return true
                            }
                            else{
                                return false
                            }

                        }
                        else {
                            return true
                        }
                    }
                }
            }
            else if barhas.last!.isSelected{
                self.annotaionFilterArray.removeAll { annotationModel in
                    if annotationModel.rooftop!.isSelected{
                        if annotationModel.barData.isopend{
                            return true
                        }
                        else{
                            return false
                        }

                    }
                    else {
                        return true
                    }
                }
            }
            else{
                self.annotaionFilterArray.removeAll { annotationModel in
                    if annotationModel.barData.isopend{
                        return true
                    }
                    else{
                        return false
                    }
                }
            }
        }
        else{
            self.annotaionFilterArray.removeAll { annotationModel in
                if annotationModel.barData.isopend{
                    return true
                }
                else{
                    return false
                }
            }
        }
    }
//    func reloadLive(_ annotaionArray:[AnnotationModel] = [],countrs:Int = 100,reCheck:Bool = false){
//
//        self.annotaionFilterArray.removeAll()
//        self.annotaionFilterArray = annotaionArray
//        print("countsarr\(self.annotaionFilterArray.count)")
//        //self.annotaionFilterArray = self.annotaionArray
//        if let barhas = CommonHelper.getOnlyShowData(){
//
//
//            if barhas.first!.isSelected{
//                if barhas.last!.isSelected{
//                    self.annotaionFilterArray.removeAll { annotationModel in
//                        if annotationModel.rooftop!.isSelected || annotationModel.terrace.isSelected{
//                            if self.isLive{
//                                if annotationModel.barData.isopend{
//                                    return true
//                                }
//                                else{
//                                    return false
//                                }
//                            }
//                            else{
//                                return false
//                            }
//                        }
//                        else {
//                            return true
//                        }
//                    }
//                }
//                else{
//                    self.annotaionFilterArray.removeAll { annotationModel in
//                        if annotationModel.rooftop!.isSelected && !annotationModel.terrace!.isSelected{
//                            if annotationModel.barData.isopend{
//                                return true
//                            }
//                            else{
//                                return false
//                            }
//
//                        }
//                        else {
//                            return true
//                        }
//                    }
//                }
//            }
//            else if barhas.last!.isSelected{
//                self.annotaionFilterArray.removeAll { annotationModel in
//                    if annotationModel.terrace!.isSelected{
//                        if annotationModel.barData.isopend{
//                            return true
//                        }
//                        else{
//                            return false
//                        }
//
//                    }
//                    else {
//                        return true
//                    }
//                }
//            }
//            else{
//                self.annotaionFilterArray.removeAll { annotationModel in
//                    if annotationModel.barData.isopend{
//                        return true
//                    }
//                    else{
//                        return false
//                    }
//                }
//            }
//        }
//        else{
//            self.annotaionFilterArray.removeAll { annotationModel in
//                if annotationModel.barData.isopend{
//                    return true
//                }
//                else{
//                    return false
//                }
//            }
//        }
//
//        var recheck = reCheck
//        if self.Mapbox.cameraState.zoom >= 10{
//            if self.isZoomOut{
//                recheck = true
//            }
//        }
//        if let myloc = CommonHelper.getCachedMapLocData(){
//            let curentloc = CLLocation(latitude: self.Mapbox.cameraState.center.latitude, longitude: self.Mapbox.cameraState.center.longitude)
//            let maploc = CLLocation(latitude: myloc.address_lat, longitude: myloc.address_lng)
//            var dist1 = curentloc.distance(from: maploc)
//            dist1 = dist1.metersToKilometer()
//            print("distance:\(dist1)")
//            if dist1 >= 5{
//                //PopupHelper.showAnimating(false, controler: self)
//                print("50 km true")
//                let loc = LocationModel()
//                loc.address_lat = self.Mapbox.cameraState.center.latitude
//                loc.address_lng = self.Mapbox.cameraState.center.longitude
//                CommonHelper.saveCachedMapLocData(loc)
//                recheck = true
//            }
//            else{
//                print("50 km false")
//            }
//        }
//        else{
//            let loc = LocationModel()
//            loc.address_lat = self.Mapbox.cameraState.center.latitude
//            loc.address_lng = self.Mapbox.cameraState.center.longitude
//            CommonHelper.saveCachedMapLocData(loc)
//        }
//
//        if isFirstTimeRun{
//            isFirstTimeRun = false
//            recheck = true
//        }
//        if recheck{
//            recheck = false
//            var data = [AnnotationModel]()
//            for dta in self.annotaionFilterArray{
//                let curentloc = CLLocation(latitude: self.Mapbox.cameraState.center.latitude, longitude: self.Mapbox.cameraState.center.longitude)
//                let anno1loc = CLLocation(latitude: dta.location.latitude, longitude: dta.location.longitude)
//                var dist1 = curentloc.distance(from: anno1loc)
//                dist1 = dist1.metersToKilometer()
//                if dist1 <= 10{
//                    print("true:\(dta.uuid)")
//                    data.append(dta)
//                }
//            }
//
//            self.pointAnnotationManager.annotations.removeAll()
//
//            self.annotaionFilterArray = data
//            self.annotaionFilterArray1 = data
//        }
//        else{
//            self.annotaionFilterArray = []
//        }
//
//        print("countsarr\(self.annotaionFilterArray.count)")
//        if self.annotaionFilterArray.count > 0{
//            print("count:\(self.annotaionFilterArray.count)")
//            self.isZoomOut = false
//            for coordinate in self.annotaionFilterArray {
//                DispatchQueue.background {
//                    coordinate.isAdded = true
//                    var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
//                    //let image = BarAnnotationView(image: UIImage(named: coordinate.image)!, title: "\(coordinate.price ?? "0")€").toImage()
//                    DispatchQueue.main.sync {
//                        var image:UIImage!
//                        if coordinate.image.contains("Bar"){
//                            image = self.makePin(image: coordinate.image, title: "\(coordinate.barData.displayPrice ?? "0")€")
//                        }
//                        else{
//                            image = UIImage(named: coordinate.image)
//                        }
//
//                        point.iconAnchor = .bottom
//                        point.image = .init(image: image, name: "\(coordinate.uuid)")
//
//                        self.pointAnnotationManager.annotations.append(point)
//                    }
//                    print("apend:\(coordinate.uuid)")
//
//                } completion: {
//
//                    DispatchQueue.main.async {
//                        PopupHelper.stopAnimating(controler: self)
//                    }
//                }
//            }
//
//        }
//        else{
//            if self.Mapbox.cameraState.zoom <= 10{
//                self.pointAnnotationManager.annotations.removeAll()
//                self.isZoomOut = true
//                var couuntr = 0
//                for coordinate in annotaionArray {
//                    DispatchQueue.background {
//                        if couuntr <= 20{
//                            coordinate.isAdded = true
//                            couuntr += 1
//                            var point = PointAnnotation(id: "\(coordinate.uuid)", point: Point(coordinate.location))
//                            //let image = BarAnnotationView(image: UIImage(named: coordinate.image)!, title: "\(coordinate.price ?? "0")€").toImage()
//                            DispatchQueue.main.sync {
//                                var image:UIImage!
//                                if coordinate.image.contains("Bar"){
//                                    image = self.makePin(image: coordinate.image, title: "\(coordinate.barData.displayPrice ?? "0")€")
//                                }
//                                else{
//                                    image = UIImage(named: coordinate.image)
//                                }
//
//                                point.iconAnchor = .bottom
//                                point.image = .init(image: image, name: "\(coordinate.uuid)")
//
//                                self.pointAnnotationManager.annotations.append(point)
//                            }
//                            print("apend:\(coordinate.uuid)")
//                        }
//
//
//                    } completion: {
//
//                        DispatchQueue.main.async {
//                            PopupHelper.stopAnimating(controler: self)
//                        }
//                    }
//                }
//            }
//            else{
//                self.isZoomOut = false
//            }
//            //self.pointAnnotationManager.annotations.removeAll()
//            DispatchQueue.main.async {
//                PopupHelper.stopAnimating(controler: self)
//            }
//        }
//
//
//
//
//    }
    func loaddummy() {
        //let loc = randomLocations.init().getMockLocationsFor(location: CLLocationCoordinate2D(latitude: self.Mapbox.cameraState.center.latitude, longitude: self.Mapbox.cameraState.center.longitude), itemCount: 2000)
        self.pointAnnotationManager.annotations.removeAll()
        for i in 0..<2000 {
            let cord = randomLocations().generateRandomCoordinates(10, max: 1000, location: CLLocationCoordinate2D(latitude: self.Mapbox.cameraState.center.latitude, longitude: self.Mapbox.cameraState.center.longitude))
            var point = PointAnnotation(id: "\(i)", point: Point(cord))
            //let image = BarAnnotationView(image: UIImage(named: coordinate.image)!, title: "\(coordinate.price ?? "0")€").toImage()
            var image:UIImage!
            image = UIImage(named: "Bar")
        
            point.iconAnchor = .bottom
            point.image = .init(image: image, name: "\(i)")
            
            self.pointAnnotationManager.annotations.append(point)
                
        }
        
    }
    func makePin(image: String,title:String) -> UIImage{
        let im = UIImage(named: image)!
        let imageView = UIImageView(image: im)
        let lblPrice = UILabel()
        let pinView = UIView(frame: CGRect(origin: .zero, size: im.size))
        pinView.clipsToBounds = true
        lblPrice.textAlignment = .center
        lblPrice.text = title
        lblPrice.textColor = .black
        if title.count > 3{
            lblPrice.font = UIFont(name: Constant.cabinSFont, size: 10)
        }
        else if title.count > 4{
            lblPrice.font = UIFont(name: Constant.cabinSFont, size: 8)
        }
        else if title.count > 5{
            lblPrice.font = UIFont(name: Constant.cabinSFont, size: 6)
        }
        else{
            lblPrice.font = UIFont(name: Constant.cabinSFont, size: 13)
        }
        pinView.addSubview(imageView)
        pinView.addSubview(lblPrice)
        lblPrice.frame = pinView.bounds
        lblPrice.frame.origin = CGPoint(x: pinView.bounds.origin.x, y: -3)
        imageView.clipsToBounds = true
        lblPrice.clipsToBounds = true
        print("prices:\(title)")
        let img1 = pinView.toImage1()
        return img1
        
    }
    func userLocationSetup() {

        self.Mapbox.location.delegate = self
        self.Mapbox.location.locationProvider.setDelegate(self)
        self.Mapbox.location.locationProvider.startUpdatingLocation()
        //locationManager = CLLocationManager()
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestAlwaysAuthorization()
        //locationManager.distanceFilter = distanceFilter
        //locationManager.startUpdatingLocation()
        //locationManager.startUpdatingHeading()
        //locationManager.delegate = self
    }
    func checkDailyData(){
        var isCheck = false
        if let date = UserDefaults.standard.value(forKey: Constant.checkDate) as? Int64{
            let date1 = date.timestampToDate()
            let today = Calendar.current
            if !today.isDateInToday(date1){
                isCheck = true
            }
        }
        else{
            isCheck = true
            let d  = Date().toMillisInt64()
            UserDefaults.standard.set(d, forKey: Constant.checkDate)
        }
        if isCheck{
            var data = [String:Any]()
            
            if FirebaseData.getCurrentUserId().1{
                FirebaseData.getUser2Data(uid: FirebaseData.getCurrentUserId().0) { error, userData in
                    guard let userData = userData else {
                        return
                    }
                    var param = [String:Any]()
                    param[User2Keys.user_id.rawValue] = userData.user_id ?? 1
                    WebServicesHelper.callWebServiceWithFileUpload(Parameters: param, action: .maindatarecord, httpMethodName: .post) {indx,action,isNetwork, error, dataDict in
                        
                        
                        if isNetwork{
                            if let _ = error{
                                //PopupHelper.showAlertControllerWithError(forErrorMessage: err, forViewController: self)
                            }
                            else{
                                if let _ = dataDict as? Dictionary<String,Any>{
                                    switch action {
                                    case .maindatarecord:
                                        
                                        var count:Int64 = 1
                                        if let daily = userData.dailyUse{
                                            count = daily
                                            count += 1
                                        }
                                        data[User2Keys.dailyUse.rawValue] = count
                                        data[User2Keys.timestamp.rawValue] = Date().toMillisInt64()
                                        data[User2Keys.updatedOn.rawValue] = Date().formattedWith(Globals.__yyyy_MM_dd)
                                        FirebaseData.updateUser2Data(FirebaseData.getCurrentUserId().0, dic: data) { error in
                                            
                                        }
                                        
                                    default:
                                        break
                                    }
                                }
                            }
                        }
                        else{
                            //PopupHelper.alertWithNetwork(title: "Network Connection".localized(), message: "Please connect your internet connection".localized(), controler: self)
                            
                        }
                    }
                    
                }
                
            }
            else{
                FirebaseData.getVisitorData(uid: FirebaseData.getCurrentUserId().0) { error, userData in
                    guard let userData = userData else {
                        return
                    }
                    var param = [String:Any]()
                    param[VisitorKeys.user_id.rawValue] = userData.user_id ?? 1
                    WebServicesHelper.callWebServiceWithFileUpload(Parameters: param, action: .maindatarecord, httpMethodName: .post) {indx,action,isNetwork, error, dataDict in
                        
                        
                        if isNetwork{
                            if let _ = error{
                                //PopupHelper.showAlertControllerWithError(forErrorMessage: err, forViewController: self)
                            }
                            else{
                                if let _ = dataDict as? Dictionary<String,Any>{
                                    switch action {
                                    case .maindatarecord:
                                        
                                        var count:Int64 = 1
                                        if let daily = userData.dailyUse{
                                            count = daily
                                            count += 1
                                        }
                                        data[User2Keys.dailyUse.rawValue] = count
                                        data[User2Keys.timestamp.rawValue] = Date().toMillisInt64()
                                        data[User2Keys.updatedOn.rawValue] = Date().formattedWith(Globals.__yyyy_MM_dd)
                                        FirebaseData.updateVisitorData(FirebaseData.getCurrentUserId().0, dic: data) { error in
                                            
                                        }
                                        
                                    default:
                                        break
                                    }
                                }
                            }
                        }
                        else{
                            //PopupHelper.alertWithNetwork(title: "Network Connection".localized(), message: "Please connect your internet connection".localized(), controler: self)
                            
                        }
                    }
                    
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let controller = segue.destination as? SelectedBarProfileViewController{
//            //controller.delegate = self.delegate
//            //controller.delegate1 = self
//        }
//        if let controller = segue.destination as? SelectedBarDetailViewController{
//            //controller.delegate = self
//        }
    }
    
}

//MARK:- Delegate Method's
extension MapViewController{
    
    func bardeatail(){
        // Delegate methods which call My Bar Profile view controller
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
}
//MARK:- MAPBOX DELEGATES
extension MapViewController:GestureManagerDelegate{
    func gestureManager(_ gestureManager: GestureManager, didBegin gestureType: GestureType) {
        
    }
    
    func gestureManager(_ gestureManager: GestureManager, didEnd gestureType: GestureType, willAnimate: Bool) {
        let point = gestureManager.singleTapGestureRecognizer.location(in: self.Mapbox)
        print("touchPoint:\(point)")
        let cords = self.Mapbox.mapboxMap.coordinate(for: point)
        self.selectedCordinate = cords
        print("touchCord:\(cords)")
        switch gestureType{
        case .singleTap:
            switch self.tableState{
            case .halfdown:
                self.handleMapTap()
            default:
                break
            }
        default:
            break
        }
    }
    
    func gestureManager(_ gestureManager: GestureManager, didEndAnimatingFor gestureType: GestureType) {
        
    }
    
    
}
extension MapViewController:AnnotationInteractionDelegate,ViewAnnotationUpdateObserver {
    func framesDidChange(for annotationViews: [UIView]) {
        
    }
    
    func visibilityDidChange(for annotationViews: [UIView]) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionCurlDown, animations: {
            for views in annotationViews{
                views.animation.easeInElastic.animate(1.0)
            }
        }, completion: nil)
    }
    
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        if annotations.count > 0{
            var annoArray = [(Double,Annotation)]()
            for anno in annotations{
                if let annoo = anno as? PointAnnotation{
                   let dis = annoo.point.coordinates.distance(to: self.selectedCordinate)
                    annoArray.append((dis,anno))
                }
            }
            annoArray.sort { val1, val2 in
                return val1.0 > val2.0
            }
            guard let annotation = annoArray.first?.1 else {
                return
            }
            self.pinTap = true
            print("annotations:\(annotation.id),\(annotations.count)")
            let anotaion = self.annotaionFilterArray.first { annotationModel in
                print("uuuuuid:\(annotationModel.uuid)")
                return "\(annotationModel.uuid)" == annotation.id
            }
            guard let anotaion = anotaion else {
                return
            }
            let bar = self.barArray.first { barModel in
                return barModel.uuid == anotaion.uuid
            }
            print("uuuuuuuuuid:\(anotaion.uuid)")
            self.isAlreadyBarOpen = true
            
            DispatchQueue.main.async {
                if let pointAnnotationManager = self.pointAnnotationManager,
                   let index = pointAnnotationManager.annotations.firstIndex(where: { $0.id == annotation.id }) {
                    
                    self.markerSelectedIndex = index
                    var annotation1 = pointAnnotationManager.annotations[index]
                    //var size = annotation1.image!.image.size
                    //size.height *= 1.3
                    //size.width *= 1.3
                    //annotation1.image = .init(image: UIImage().RBResizeImage(annotation1.image!.image, targetSize: size)!, name: annotation1.id)
                    if let info = annotation1.userInfo {
                        var pinImage = info["pinImage"] as! String
                        let displayPrice = info["displayPrice"] as? String
                        let uuid = info["uuid"] as! Int64
                        var image:UIImage!
                        if pinImage.contains("Rooftop"){
                            pinImage.append("s")
                            image = UIImage(named: pinImage)!
                        }
                        else if pinImage.contains("Bar"){
                            pinImage.append("rr")
                            if let price = displayPrice{
                                if price.first != "0"{
                                    image = UIImage(named: pinImage)!.drawImagesAndText1("\(price)€",isSelect: true)
                                }
                                else{
                                    image = UIImage(named: pinImage)!.drawImagesAndText1("",isSelect: true)
                                }
                                
                            }
                            else{
                                image = UIImage(named: pinImage)!.drawImagesAndText1("",isSelect: true)
                            }
                            
                            
                        }
                        else if pinImage.contains("21"){
                            pinImage.append("1")
                            image = UIImage(named: pinImage)!.drawImagesAndText1("\(displayPrice ?? "0")€",isEvent: true,isSelect: true)
                        }
                        else if pinImage.contains("58"){
                            pinImage.append("8")
                            image = UIImage(named: pinImage)!.drawImagesAndText1("\(displayPrice ?? "0")€",isEvent: true,isSelect: true)
                        }
                        else{
                            
                            image = UIImage(named: pinImage)!.drawImagesAndText1("\(displayPrice ?? "0")€",isEvent: true,isSelect: true)
                        }
                        annotation1.image = .init(image: image, name: "\(uuid)")
                        
                    }
                    
                    pointAnnotationManager.annotations[index] = annotation1
                    
                }
                
            }
            
            if CommonHelper.getCachedMapLocData() != nil{
                var point = self.Mapbox.mapboxMap.point(for: anotaion.location)
                point.y += 50
                let loc = self.Mapbox.mapboxMap.coordinate(for: point)
                self.Mapbox.camera.fly(to: CameraOptions(center: loc, zoom: self.Mapbox.cameraState.zoom , bearing: self.Mapbox.cameraState.bearing, pitch: self.Mapbox.cameraState.pitch)) { position in
                    CommonHelper.saveCachedMapLocData(LocationModel(address_lat: anotaion.location.latitude, address_lng: anotaion.location.longitude, zoom: self.Mapbox.cameraState.zoom, pitch: self.Mapbox.cameraState.pitch, bearing: self.Mapbox.cameraState.bearing))
                    

                    if let anno = self.selectedAnnotation{
                        if anno.uuid == anotaion.uuid{
                            return
                        }
                        else{
                            self.selectedAnnotation = anotaion
                            self.selectedBar = bar
                            self.showtableView()
                        }
                        
                    }
                    else{
                        self.selectedAnnotation = anotaion
                        self.selectedBar = bar
                        self.showtableView()
                    }
                }
            }
            else{
                self.Mapbox.camera.fly(to: CameraOptions(center: anotaion.location, zoom: 15, bearing: 0, pitch: 15)) { position in
                    
                    if let anno = self.selectedAnnotation{
                        if anno.uuid == anotaion.uuid{
                            return
                        }
                        else{
                            self.selectedAnnotation = anotaion
                            self.selectedBar = bar
                            self.showtableView()
                        }
                        
                    }
                    else{
                        self.selectedAnnotation = anotaion
                        self.selectedBar = bar
                        self.showtableView()
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.pinTap = false
            }
        }
        
        
    }
    
//    private func updateSelectedMarker(atPoint point: CGPoint,id:String) {
//        let options = RenderedQueryOptions(layerIds: [id], filter: nil)
//        self.Mapbox.mapboxMap.queryRenderedFeatures(at: point, options: options) { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let features):
//                if features.isEmpty {
//                    if self.markerSelected {
//                        self.updateMarker(selected: false)
//                    }
//                    return
//                }
//
//                if let geometry = features.first?.feature.geometry {
//                    try? self.Mapbox.mapboxMap.style.updateGeoJSONSource(withId: "gff",
//                                                                          geoJSON: .geometry(geometry))
//                }
//
//                if self.markerSelected {
//                    self.updateMarker(selected: false)
//                }
//
//                if !features.isEmpty {
//                    self.updateMarker(selected: true)
//                }
//            case .failure(let error):
//                PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
//            }
//        }
//    }
//
//    private func updateMarker(selected: Bool) {
//        try? Mapbox.mapboxMap.style.updateLayer(
//            withId: "gff",
//            type: SymbolLayer.self,
//            update: { (layer: inout SymbolLayer) throws in
//                layer.iconSize = .constant(selected ? 2 : 1)
//            })
//        markerSelected = selected
//    }
    @objc @IBAction func handleMapTap() {
        
        self.tableState = .fulldown
        self.selectedAnnotation = nil
        self.selectedBar = nil
        self.isShowMore = false
        self.isBarShow = false
        self.isAlreadyBarOpen = false
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionCurlDown, animations: {
            DispatchQueue.main.async {
                self.pointAnnotationManager.annotations = self.pointAnnotationArray
            }
            let tableFrame = self.BarDetailTableView.frame
            self.BarDetailTableView.frame = CGRect(x: tableFrame.origin.x, y: UIScreen.main.bounds.height, width: tableFrame.width, height: UIScreen.main.bounds.height)
        }, completion: nil)
        UIView.animate(withDuration: 15.0, delay: 2.0, options: .transitionCurlDown, animations: {
            DispatchQueue.main.async {
                self.pointAnnotationManager.annotations = self.pointAnnotationArray
            }
        }, completion: nil)
        self.Mapbox.camera.fly(to: CameraOptions(center: self.Mapbox.cameraState.center, zoom: self.Mapbox.cameraState.zoom, bearing: self.Mapbox.cameraState.bearing, pitch: self.Mapbox.cameraState.pitch)) { position in
            CommonHelper.saveCachedMapLocData(LocationModel(address_lat: self.Mapbox.cameraState.center.latitude, address_lng: self.Mapbox.cameraState.center.longitude, zoom: self.Mapbox.cameraState.zoom, pitch: self.Mapbox.cameraState.pitch, bearing: self.Mapbox.cameraState.bearing))
            
        }
        
        
    }
//    func mapView(_ mapView: MGLMapView, shouldChangeFrom oldCamera: MGLMapCamera, to newCamera: MGLMapCamera) -> Bool {
//        CommonHelper.saveCachedUserLocData(LocationModel(address_lat: self.Mapbox.centerCoordinate.latitude, address_lng: self.Mapbox.centerCoordinate.longitude, altitude: self.Mapbox.camera.altitude, pitch: self.Mapbox.camera.pitch, heading: self.Mapbox.camera.heading))
//        print("zoomLevel:\(self.Mapbox.camera.altitude)")
//        return true
//    }
//    func mapViewRegionIsChanging(_ mapView: MGLMapView) {
//        print("changing")
//        self.isMoving = true
//        if CommonHelper.getCachedUserLocData() == nil{
//            CommonHelper.saveCachedUserLocData(LocationModel(address_lat: self.myLocation.latitude, address_lng: self.myLocation.longitude, altitude: 4500, pitch: 15, heading: CLLocationDirection(0)))
//        }
//        else{
//            CommonHelper.saveCachedUserLocData(LocationModel(address_lat: self.Mapbox.centerCoordinate.latitude, address_lng: self.Mapbox.centerCoordinate.longitude, altitude: self.Mapbox.camera.altitude, pitch: self.Mapbox.camera.pitch, heading: self.Mapbox.camera.heading))
//        }
//
//
//
//    }
//    func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
//        print("Chnaged")
//        self.isMoving = false
//
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            if !self.isMoving{
//                if self.isLive{
//                    self.reloadLive(self.annotaionArray)
//                }
//                else{
//                    self.reloadNonLive(self.annotaionArray)
//                }
//            }
//
//        }
//        print("reason:\(reason)")
//
//    }
//
//    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
//        // This example is only concerned with point annotations.
//
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
//            if annotion.accessibilityHint!.contains("Roof"){
//                annotationView = BarAnnotationView1(reuseIdentifier: reuseIdentifier, image: UIImage(named: annotion.accessibilityHint ?? "") ?? UIImage())
//
//            }
//            else{
//                annotationView = BarAnnotationView(reuseIdentifier: reuseIdentifier, image: UIImage(named: annotion.accessibilityHint ?? "") ?? UIImage(), title: annotion.subtitle ?? "")
//            }
//
//        }
//
//        return annotationView
//    }
//    func mapView(_ mapView: MGLMapView, didSelect annotationView: MGLAnnotationView) {
//
//        //let touchLocation = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
//        let anotaion = self.annotaionFilterArray.first { annotationModel in
//            return "\(annotationModel.location.longitude)" == annotationView.reuseIdentifier
//        }
//        let bar = self.barArray.first { barModel in
//            return barModel.bname == anotaion?.title
//        }
////        mapView.fly(to: mapView.camera) {
////            //self.tapAnotation(annotion: anotaion,bar: bar)
////        }
//        if let locaction = CommonHelper.getCachedUserLocData(){
//            mapView.fly(to: MGLMapCamera(lookingAtCenter: anotaion?.location ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), altitude: locaction.altitude ?? 4500, pitch: locaction.pitch ?? 15, heading: locaction.heading ?? 0)) {
//                CommonHelper.saveCachedUserLocData(LocationModel(address_lat: anotaion!.location.latitude, address_lng: anotaion!.location.longitude, altitude: mapView.camera.altitude, pitch: mapView.camera.pitch, heading: mapView.camera.heading))
//
//                self.selectedAnnotation = anotaion
//                self.selectedBar = bar
//                self.showtableView()
//            }
//        }
//        else{
//            mapView.fly(to: MGLMapCamera(lookingAtCenter: (anotaion?.location)!, altitude: 4500, pitch: 15, heading: CLLocationDirection(0))) {
//                CommonHelper.saveCachedUserLocData(LocationModel(address_lat: anotaion!.location.latitude, address_lng: anotaion!.location.longitude, altitude: 4500, pitch: 15, heading: 0))
//
//                self.selectedAnnotation = anotaion
//                self.selectedBar = bar
//                self.showtableView()
//            }
//        }
//
//
//    }
//    func mapView(_ mapView: MGLMapView, didDeselect annotationView: MGLAnnotationView) {
//
//        handleMapTap()
//    }
    
    
}

//MARK:- HELPING METHOD'S
extension MapViewController{

    func getViewController(identifier:String)-> UIViewController {
        let vc = UIStoryboard.init(name: Constant.mainStoryboard, bundle: Bundle.main).instantiateViewController(identifier: identifier)
        return vc
    }
    
    func headerForTableView(tableView:UITableView)->UIView {
        let headerView = UIView.init(frame: CGRect.init(x: Constant.tableviewHeaderXY, y: Constant.tableviewHeaderXY, width: tableView.frame.width, height: Constant.tableviewHeaderHeight))
        headerView.backgroundColor = UIColor(named: "TableCell")
        return headerView
    }
    
    func labelForTableViewHeader(headerView:UIView) -> UILabel {
        let headerTitle = UILabel()
        let x: CGFloat = 21
        let y: CGFloat = 16
        let width: CGFloat = headerView.frame.width-20
        let height: CGFloat = headerView.frame.height-16
        
        headerTitle.frame = CGRect.init(x: x, y: y, width: width, height: height)
        headerTitle.textColor = UIColor(named: Constant.labelColor)
        headerTitle.backgroundColor = .clear
        headerTitle.font = UIFont(name: Constant.cabinFont, size: Constant.fontSize19)
        return headerTitle
    }
    func labelForTableViewHeader1(headerView:UIView) -> UILabel {
        let headerTitle = UILabel()
        let x: CGFloat = 21
        let y: CGFloat = 10
        let width: CGFloat = headerView.frame.width-40
        let height: CGFloat = headerView.frame.height-10
        
        headerTitle.frame = CGRect.init(x: x, y: y, width: width, height: height)
        headerTitle.textColor = UIColor(named: Constant.labelColor)
        headerTitle.backgroundColor = .clear
        headerTitle.font = UIFont(name: Constant.cabinRFont, size: Constant.fontSize12)
        headerTitle.textAlignment = .right
        return headerTitle
    }
}

//MARK:- UITABLEVIEW DELEGATES AND DATASOURCE METHOD'S
extension MapViewController:UITableViewDelegate,UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y <= 0.0 /*|| scrollView.contentOffset.y < self.vNav.frame.height*/{
            
//            self.BarDetailTableView.animation.moveY(20).animateWithCompletion(0.05) {
//
//            }
            //self.vNav.isHidden = false
            //self.vNav1.isHidden = false
            //self.tableHeight.constant = UIScreen.main.bounds.height - (self.vNav.frame.height - 2)
        }else{ //if scrollView.contentOffset.y >= self.vNav.frame.height{
//            self.BarDetailTableView.animation.moveY(-20).animateWithCompletion(0.05) {
//
//            }
            //self.vNav.isHidden = true
            //self.vNav1.isHidden = true
            //self.tableHeight.constant = UIScreen.main.bounds.height // + self.vNav.frame.height
            
        }
        
        
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("ttt:\(scrollView.contentOffset.y)")
        if scrollView.contentOffset.y <= 0.0{
            
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if isBarShow{
            if isShowMore{
                return self.drinkPriceArray.count + self.drinkOtherArray.count + 3
            }else{
                return self.drinkPriceArray.count + 3
            }
        }
        else{
            return self.drinkPriceArray.count + 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = headerForTableView(tableView: tableView)
        let headerTitle = labelForTableViewHeader(headerView: headerView)
        if isBarShow{
            if isShowMore{
                switch section {
                case 0,1,2,3,4:
                    headerTitle.text = ""
                    headerView.backgroundColor = .clear
                case 5:
                    if let bar = self.selectedBar,let isSupliment = bar.isSupliment{
                        
                        if isSupliment{
                            let headerTitle1 = labelForTableViewHeader1(headerView: headerView)
                            headerTitle1.text = "Hay suplemento de terraza"/*Suplemento terraza:\(isSupliment.rate!)\(isSupliment.type!)*/
                            headerView.addSubview(headerTitle1)
                        }
                        else if let hasterrace = bar.barHas?.first{
                            if hasterrace.isSelected{
                                let headerTitle1 = labelForTableViewHeader1(headerView: headerView)
                                headerTitle1.text = ""//"No suplemento en terraza"
                                headerView.addSubview(headerTitle1)
                            }
                            
                        }
                    }
                    switch self.drinkOtherArray.count {
                    case 1:
                        
                        headerTitle.text = self.drinkOtherArray[section - 5].drinkCategory.localized()
                    case 2:
                        headerTitle.text = self.drinkOtherArray[section - 5].drinkCategory.localized()
                    case 3:
                        headerTitle.text = self.drinkOtherArray[section - 5].drinkCategory.localized()
                    case 4:
                        headerTitle.text = self.drinkOtherArray[section - 5].drinkCategory.localized()
                    default:
                        headerTitle.text = ""
                        headerView.backgroundColor = .clear
                    }
                    
                case 6:
                    
                    switch self.drinkOtherArray.count {
                    case 2:
                        headerTitle.text = self.drinkOtherArray[section - 5].drinkCategory.localized()
                    case 3:
                        headerTitle.text = self.drinkOtherArray[section - 5].drinkCategory.localized()
                    case 4:
                        headerTitle.text = self.drinkOtherArray[section - 5].drinkCategory.localized()
                    default:
                        headerTitle.text = ""
                        headerView.backgroundColor = .clear
                    }
                case 7:
                    
                    switch self.drinkOtherArray.count {
                    
                    case 3:
                        headerTitle.text = self.drinkOtherArray[section - 5].drinkCategory.localized()
                    case 4:
                        headerTitle.text = self.drinkOtherArray[section - 5].drinkCategory.localized()
                    default:
                        headerTitle.text = ""
                        headerView.backgroundColor = .clear
                    }
                case 8:
                    switch self.drinkOtherArray.count {
                    case 4:
                        headerTitle.text = self.drinkOtherArray[section - 5].drinkCategory.localized()
                    default:
                        headerTitle.text = ""
                        headerView.backgroundColor = .clear
                        
                    }
                default:
                    headerTitle.text = ""
                    
                    if let bar = self.selectedBar,let isSupliment = bar.isSupliment{
                        
                        if isSupliment{
                            let headerTitle1 = labelForTableViewHeader1(headerView: headerView)
                            headerTitle1.text = "Hay suplemento de terraza"
                            headerView.addSubview(headerTitle1)
                        }
                        else if let hasterrace = bar.barHas?.first{
                            if hasterrace.isSelected{
                                let headerTitle1 = labelForTableViewHeader1(headerView: headerView)
                                headerTitle1.text = ""
                                headerView.addSubview(headerTitle1)
                            }
                            
                        }
                    }
                }
                
            }else{
                headerTitle.text = ""
                switch section {
                case 5:
                    if let bar = self.selectedBar,let isSupliment = bar.isSupliment{
                        
                        if isSupliment{
                            let headerTitle1 = labelForTableViewHeader1(headerView: headerView)
                            headerTitle1.text = "Hay suplemento de terraza"
                            headerView.addSubview(headerTitle1)
                        }
                        else if let hasterrace = bar.barHas?.first{
                            if hasterrace.isSelected{
                                let headerTitle1 = labelForTableViewHeader1(headerView: headerView)
                                headerTitle1.text = ""
                                headerView.addSubview(headerTitle1)
                            }
                            
                        }
                    }
                default:
                    break
                }
            }
        }
        else{
            headerTitle.text = ""
            headerView.backgroundColor = .clear
        }
        
        headerView.addSubview(headerTitle)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isBarShow{
            if isShowMore{
                switch section {
                case 0,1:
                    return 0
                case 2,3,4:
                    switch UIScreen.main.bounds.height{
                    case Globals.iphone_13ProMax_12ProMax_hieght8:
                        return 10
                    case Globals.iphone_11ProMax_11_XsMax_XR_hieght7:
                        return 10
                    default:
                        return 10
                    }
                    
                case 5:
                    switch self.drinkOtherArray.count {
                    case 1:
                        return 50
                    case 2:
                        return 50
                    case 3:
                        return 50
                    case 4:
                        return 50
                    default:
                        return 20
                    }
                    
                case 6:
                    switch self.drinkOtherArray.count {
                    
                    case 2:
                        return 50
                    case 3:
                        return 50
                    case 4:
                        return 50
                    default:
                        return 20
                    }
                case 7:
                    switch self.drinkOtherArray.count {
                    case 3:
                        return 50
                    case 4:
                        return 50
                    default:
                        return 20
                    }
                case 8:
                    switch self.drinkOtherArray.count {
                    case 4:
                        return 50
                    default:
                        return 20
                    }
                default:
                    return 0
                }
            }
            else{
                switch section {
                case 0,1:
                    return 0
                case 2,3,4:
                    switch UIScreen.main.bounds.height{
                    case Globals.iphone_13ProMax_12ProMax_hieght8:
                        return 10
                    case Globals.iphone_11ProMax_11_XsMax_XR_hieght7:
                        
                        return 10
                    case Globals.iphone_13Pro_13_12Pro_12_hieght6:
                        return 10
                    default:
                        return 10
                    }
                default:
                    return 20
                }
            }
        }
        else{
            switch section {
            case 0:
                return 0
            case 1:
                switch UIScreen.main.bounds.height{
                case Globals.iphone_11ProMax_11_XsMax_XR_hieght7:
                    return 0
                case Globals.iphone_11ProMax_11_XsMax_XR_hieght7:
                    
                    return 0
                case Globals.iphone_13Pro_13_12Pro_12_hieght6:
                    return 0
                default:
                    return 0
                }
            case 2,3,4:
                return 35
                
            default:
                return 0
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isBarShow{
            if isShowMore{
                switch section {
                case 0,1,2,3,4:
                    return 1
                case 5:
                    switch self.drinkOtherArray.count {
                    case 1:
                        return self.drinkOtherArray[section - 5].drinks.count
                    case 2:
                        return self.drinkOtherArray[section - 5].drinks.count
                    case 3:
                        return self.drinkOtherArray[section - 5].drinks.count
                    case 4:
                        return self.drinkOtherArray[section - 5].drinks.count
                    default:
                        return 1
                    }
                    
                case 6:
                    switch self.drinkOtherArray.count {
                    case 2:
                        return self.drinkOtherArray[section - 5].drinks.count
                    case 3:
                        return self.drinkOtherArray[section - 5].drinks.count
                    case 4:
                        return self.drinkOtherArray[section - 5].drinks.count
                    default:
                        return 1
                    }
                case 7:
                    switch self.drinkOtherArray.count {
                    case 3:
                        return self.drinkOtherArray[section - 5].drinks.count
                    case 4:
                        return self.drinkOtherArray[section - 5].drinks.count
                    default:
                        return 1
                    }
                case 8:
                    switch self.drinkOtherArray.count {
                    case 4:
                        return self.drinkOtherArray[section - 5].drinks.count
                    default:
                        return 1
                    }
                default:
                    return 1
                }
            }else{
                return 1
            }
        }
        else{
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isBarShow{
            if indexPath.section == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! HeaderTableViewCell
                return cell
            }
            else
            if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.barDetailTableViewCell) as! BarDetailTableViewCell
                cell.selectedBackgroundView?.backgroundColor = .clear
                cell.lblName.text = self.selectedAnnotation.title
                cell.btnInfo.isHidden = false
                cell.btnInfo.addTarget(self, action: #selector(self.showTimingBtnAction(_:)), for: .touchUpInside)
                if let bdetail = self.selectedBar{
                    if !bdetail.isopend{
                        cell.lblOpen.text = "Open".localized()
                        if let time = bdetail.displaytime{
                            if let inttime = Int64(time.replacingOccurrences(of: "'", with: "")){
                                let time = inttime.timestampToDate().formattedWith(Globals.__HH_mm)
//                                if time.contains("00:"){
//                                    time = time.replacingOccurrences(of: "00:", with: "24:")
//                                }
                                cell.lblTime.text = "- Closes at".localized() + " \(time)"
                            }
                        }
                        cell.lblOpen.textColor = .green
                    }
                    else{
                        if bdetail.closingtype == "int"{
                            cell.lblOpen.text = "Closed".localized()
                            if let time = bdetail.displaytime{
                                if let inttime = Int64(time.replacingOccurrences(of: "'", with: "")){
                                    let time = inttime.timestampToDate().formattedWith(Globals.__HH_mm)
//                                    if time.contains("00:"){
//                                        time = time.replacingOccurrences(of: "00:", with: "24:")
//                                    }
                                    cell.lblTime.text = "- Opens at".localized() + " \(time)"
                                }
                            }
                            //cell.lblTime.text = "- Opens at".localized() + " \(bdetail.displaytime.replacingOccurrences(of: "'", with: ""))"
                            cell.lblOpen.textColor = .red
                            
                        }
                        else{
                            cell.lblOpen.text = "Closed".localized()
                            cell.lblTime.text = "- Opens on".localized() + " " + "\(bdetail.displaytime!.replacingOccurrences(of: "'", with: ""))".localized()
                            cell.lblOpen.textColor = .red
                        }
                    }
                }
                cell.timingStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showTimingBtnAction(_:))))
                cell.timingStack.isUserInteractionEnabled = true
                let placeholdr = UIImage(named: "")//  #imageLiteral(resourceName: "Image")
                if let imgstr = self.selectedAnnotation.barImage{
                    if let url = URL(string: imgstr){
                        cell.vImage.af.setImage(withURL: url, placeholderImage: placeholdr, runImageTransitionIfCached: true)
                    }
                    else{
                        cell.vImage.image = placeholdr
                    }
                }
                else{
                    cell.vImage.image = placeholdr
                }
                for gestr in cell.gestureRecognizers ?? []{
                    cell.removeGestureRecognizer(gestr)
                }
                switch self.selectedAnnotation.announce {
                case .None:
                    cell.lblAnnounce.isHidden = true
                    cell.ivAnnounce.isHidden = true
                    cell.lblTable.isHidden = true
                    cell.ivTable.isHidden = true
                    cell.ivBaja.isHidden = true
                case .Announcement:
                    cell.lblAnnounce.isHidden = false
                    cell.ivAnnounce.isHidden = false
                    cell.lblTable.isHidden = true
                    cell.ivTable.isHidden = true
                    cell.ivBaja.isHidden = true
                    
                    cell.lblAnnounce.text = self.selectedAnnotation.annouceName
                    cell.ivAnnounce.image = #imageLiteral(resourceName: "Blue glow")
                case .Free_table_on_the_terrace:
                    cell.lblAnnounce.isHidden = false
                    cell.ivAnnounce.isHidden = false
                    cell.lblTable.isHidden = true
                    cell.ivTable.isHidden = true
                    cell.ivBaja.isHidden = true
                    cell.lblAnnounce.text = "Free table on terrace".localized()
                    cell.ivAnnounce.image = #imageLiteral(resourceName: "Red glow")
                case .Both_announcement_and_free_table:
                    cell.lblAnnounce.isHidden = false
                    cell.ivAnnounce.isHidden = false
                    cell.lblTable.isHidden = false
                    cell.ivTable.isHidden = false
                    cell.ivBaja.isHidden = true
                    
                    cell.lblAnnounce.text = self.selectedAnnotation.annouceName
                    cell.ivAnnounce.image = #imageLiteral(resourceName: "Blue glow")
                    cell.lblTable.text = "Free table on terrace".localized()
                    cell.ivTable.image = #imageLiteral(resourceName: "Glow")
                default:
                    break
                }
                return cell
            } else if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4{
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.mainCategoryTableViewCell) as! MainCategoryTableViewCell
                cell.ProductImage.image = UIImage(named: self.drinkPriceArray[indexPath.section - 2].drinkImage)
                cell.ProductNameLabel.text = self.drinkPriceArray[indexPath.section - 2].drinkName.rawValue
                if let price = self.drinkPriceArray[indexPath.section - 2].drinkPrice{
                    if let price1 = Double(price.replacingOccurrences(of: ",", with: ".")){
                        cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€".replacingOccurrences(of: ",", with: ".")
                    }
                    else{
                        cell.ProductPriceLabel.text = "-"
                    }
                }
                
                cell.selectedBackgroundView?.backgroundColor = .clear
                return cell
            } else {
                if isShowMore {
                    switch indexPath.section {
                    case 5:
                        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.otherCategoryTableViewCell) as! OtherCategoryTableViewCell
                        switch self.drinkOtherArray.count {
                        case 1:
                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkImage)
                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkName.rawValue
                            if let price = self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkPrice{
                                if let price1 = Double(price.replacingOccurrences(of: ",", with: ".")){
                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€".replacingOccurrences(of: ",", with: ".")
                                }
                                else{
                                    cell.ProductPriceLabel.text = "-"
                                }
                            }
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            return cell
                        case 2:
                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkImage)
                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkName.rawValue
                            if let price = self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkPrice{
                                if let price1 = Double(price.replacingOccurrences(of: ",", with: ".")){
                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€".replacingOccurrences(of: ",", with: ".")
                                }
                                else{
                                    cell.ProductPriceLabel.text = "-"
                                }
                            }
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            return cell
                        case 3:
                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkImage)
                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkName.rawValue
                            if let price = self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkPrice{
                                if let price1 = Double(price.replacingOccurrences(of: ",", with: ".")){
                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€".replacingOccurrences(of: ",", with: ".")
                                }
                                else{
                                    cell.ProductPriceLabel.text = "-"
                                }
                            }
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            return cell
                        case 4:
                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkImage)
                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkName.rawValue
                            if let price = self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkPrice{
                                if let price1 = Double(price.replacingOccurrences(of: ",", with: ".")){
                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€".replacingOccurrences(of: ",", with: ".")
                                }
                                else{
                                    cell.ProductPriceLabel.text = "-"
                                }
                            }
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            return cell
                        default:
                            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
                            cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
                            cell.TitleLabel.text = "Show Less".localized()
                            cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector3"), for: .normal)
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
                            return cell
                        }
                    case 6:
                        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.otherCategoryTableViewCell) as! OtherCategoryTableViewCell
                        switch self.drinkOtherArray.count {
                        case 2:
                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkImage)
                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkName.rawValue
                            if let price = self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkPrice{
                                if let price1 = Double(price.replacingOccurrences(of: ",", with: ".")){
                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€".replacingOccurrences(of: ",", with: ".")
                                }
                                else{
                                    cell.ProductPriceLabel.text = "-"
                                }
                            }
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            return cell
                        case 3:
                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkImage)
                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkName.rawValue
                            if let price = self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkPrice{
                                if let price1 = Double(price.replacingOccurrences(of: ",", with: ".")){
                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€".replacingOccurrences(of: ",", with: ".")
                                }
                                else{
                                    cell.ProductPriceLabel.text = "-"
                                }
                            }
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            return cell
                        case 4:
                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkImage)
                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkName.rawValue
                            if let price = self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkPrice{
                                if let price1 = Double(price.replacingOccurrences(of: ",", with: ".")){
                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€".replacingOccurrences(of: ",", with: ".")
                                }
                                else{
                                    cell.ProductPriceLabel.text = "-"
                                }
                            }
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            return cell
                        default:
                            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
                            cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
                            cell.TitleLabel.text = "Show Less".localized()
                            cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector3"), for: .normal)
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
                            return cell
                        }
                    case 7:
                        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.otherCategoryTableViewCell) as! OtherCategoryTableViewCell
                        switch self.drinkOtherArray.count {
                        case 3:
                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkImage)
                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkName.rawValue
                            if let price = self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkPrice{
                                if let price1 = Double(price.replacingOccurrences(of: ",", with: ".")){
                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€".replacingOccurrences(of: ",", with: ".")
                                }
                                else{
                                    cell.ProductPriceLabel.text = "-"
                                }
                                
                            }
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            return cell
                        case 4:
                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkImage)
                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkName.rawValue
                            if let price = self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkPrice{
                                if let price1 = Double(price.replacingOccurrences(of: ",", with: ".")){
                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€".replacingOccurrences(of: ",", with: ".")
                                }
                                else{
                                    cell.ProductPriceLabel.text = "-"
                                }
                                
                            }
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            return cell
                        default:
                            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
                            cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
                            cell.TitleLabel.text = "Show Less".localized()
                            cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector3"), for: .normal)
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
                            return cell
                        }
                    case 8:
                        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.otherCategoryTableViewCell) as! OtherCategoryTableViewCell
                        switch self.drinkOtherArray.count {
                        case 4:
                            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkImage)
                            cell.ProductNameLabel.text =  self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkName.rawValue
                            if let price = self.drinkOtherArray[indexPath.section - 5].drinks[indexPath.row].drinkPrice{
                                if let price1 = Double(price.replacingOccurrences(of: ",", with: ".")){
                                    cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€".replacingOccurrences(of: ",", with: ".")
                                }
                                else{
                                    cell.ProductPriceLabel.text = "-"
                                }
                                
                            }
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            return cell
                        default:
                            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
                            cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
                            cell.TitleLabel.text = "Show Less".localized()
                            cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector3"), for: .normal)
                            cell.selectedBackgroundView?.backgroundColor = .clear
                            cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
                            return cell
                        }
                    default:
                        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
                        cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
                        cell.TitleLabel.text = "Show Less".localized()
                        cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector3"), for: .normal)
                        cell.selectedBackgroundView?.backgroundColor = .clear
                        cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
                        return cell
                    }
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
                    cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
                    cell.TitleLabel.text = "Show More".localized()
                    cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector2"), for: .normal)
                    cell.selectedBackgroundView?.backgroundColor = .clear
                    cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
                    return cell
                }
            }
        }
        else{
            if indexPath.section == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MapsTableViewCell
                cell.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
                cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showfullview(_:))))
                
                return cell
            }
            else
            if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.barDetailTableViewCell) as! BarDetailTableViewCell
                cell.selectedBackgroundView?.backgroundColor = .clear
                if self.selectedAnnotation != nil{
                    cell.lblName.text = self.selectedAnnotation.title
                }
                
                cell.btnInfo.isHidden = true
                if let bdetail = self.selectedBar{
                    if !bdetail.isopend{
                        cell.lblOpen.text = "Open".localized()
                        if let time = bdetail.displaytime{
                            if let inttime = Int64(time.replacingOccurrences(of: "'", with: "")){
                                let time = inttime.timestampToDate().formattedWith(Globals.__HH_mm)
//                                if time.contains("00:"){
//                                    time = time.replacingOccurrences(of: "00:", with: "24:")
//                                }
                                cell.lblTime.text = "- Closes at".localized() + " \(time)"
                            }
                        }
                        cell.lblOpen.textColor = .green
                    }
                    else{
                        if bdetail.closingtype == "int"{
                            cell.lblOpen.text = "Closed".localized()
                            if let time = bdetail.displaytime{
                                if let inttime = Int64(time.replacingOccurrences(of: "'", with: "")){
                                    let time = inttime.timestampToDate().formattedWith(Globals.__HH_mm)
//                                    if time.contains("00:"){
//                                        time = time.replacingOccurrences(of: "00:", with: "24:")
//                                    }
                                    cell.lblTime.text = "- Opens at".localized() + " \(time)"
                                }
                            }
                            //cell.lblTime.text = "- Opens at".localized() + " \(bdetail.displaytime.replacingOccurrences(of: "'", with: ""))"
                            cell.lblOpen.textColor = .red
                            
                        }
                        else{
                            cell.lblOpen.text = "Closed".localized()
                            cell.lblTime.text = "- Opens on".localized() + " " + "\(bdetail.displaytime!.replacingOccurrences(of: "'", with: ""))".localized()
                            cell.lblOpen.textColor = .red
                        }
                    }
                }
                
                cell.timingStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showTimingBtnAction(_:))))
                cell.timingStack.isUserInteractionEnabled = false
                let placeholdr = UIImage(named: "")// #imageLiteral(resourceName: "Image")
                if self.selectedAnnotation != nil{
                    if let imgstr = self.selectedAnnotation.barImage{
                        if let url = URL(string: imgstr){
                            
                            cell.vImage.af.setImage(withURL: url, placeholderImage: placeholdr, runImageTransitionIfCached: true)
                        }
                        else{
                            cell.vImage.image = placeholdr
                        }
                    }
                    else{
                        cell.vImage.image = placeholdr
                    }
                    
                }
                else{
                    cell.vImage.image = placeholdr
                }
                
                cell.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
                cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showfullview(_:))))
                
                if self.selectedAnnotation != nil{
                    switch self.selectedAnnotation.announce {
                    case .None:
                        cell.lblAnnounce.isHidden = true
                        cell.ivAnnounce.isHidden = true
                        cell.lblTable.isHidden = true
                        cell.ivTable.isHidden = true
                        cell.ivBaja.isHidden = true
                    case .Announcement:
                        cell.lblAnnounce.isHidden = false
                        cell.ivAnnounce.isHidden = false
                        cell.lblTable.isHidden = true
                        cell.ivTable.isHidden = true
                        cell.ivBaja.isHidden = true
                        
                        cell.lblAnnounce.text = self.selectedAnnotation.annouceName
                        cell.ivAnnounce.image = #imageLiteral(resourceName: "Blue glow")
                    case .Free_table_on_the_terrace:
                        cell.lblAnnounce.isHidden = false
                        cell.ivAnnounce.isHidden = false
                        cell.lblTable.isHidden = true
                        cell.ivTable.isHidden = true
                        cell.ivBaja.isHidden = true
                        cell.lblAnnounce.text = "Free table on terrace".localized()
                        cell.ivAnnounce.image = #imageLiteral(resourceName: "Red glow")
                    case .Both_announcement_and_free_table:
                        cell.lblAnnounce.isHidden = false
                        cell.ivAnnounce.isHidden = false
                        cell.lblTable.isHidden = false
                        cell.ivTable.isHidden = false
                        cell.ivBaja.isHidden = true
                        
                        cell.lblAnnounce.text = self.selectedAnnotation.annouceName
                        cell.ivAnnounce.image = #imageLiteral(resourceName: "Blue glow")
                        cell.lblTable.text = "Free table on terrace".localized()
                        cell.ivTable.image = #imageLiteral(resourceName: "Glow")
                    default:
                        break
                    }
                }
                
                return cell
            } else if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4{
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.mainCategoryTableViewCell) as! MainCategoryTableViewCell
                cell.ProductImage.image = UIImage(named: self.drinkPriceArray[indexPath.section - 2].drinkImage)
                cell.ProductNameLabel.text = self.drinkPriceArray[indexPath.section - 2].drinkName.rawValue
                if let price = self.drinkPriceArray[indexPath.section - 2].drinkPrice{
                    if let price1 = Double(price.replacingOccurrences(of: ",", with: ".")){
                        cell.ProductPriceLabel.text = "\(price1.roundToPlace(places: 2))€".replacingOccurrences(of: ",", with: ".")
                    }
                    else{
                        cell.ProductPriceLabel.text = "-"
                    }
                    
                }
                cell.selectedBackgroundView?.backgroundColor = .clear
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.showMoreTableViewCell) as! ShowMoreTableViewCell
                cell.ShowMoreBtn.addTarget(self, action: #selector(showMoreBtnAction(_:)), for: .touchUpInside)
                cell.TitleLabel.text = "Show More".localized()
                cell.ShowMoreBtnImage.setImage(#imageLiteral(resourceName: "Vector2"), for: .normal)
                cell.selectedBackgroundView?.backgroundColor = .clear
                cell.ShowMoreBtn.layer.cornerRadius = cell.ShowMoreBtn.frame.height/2
                return cell
            }
        }
        
    }
    
    @objc func showMoreBtnAction(_ sender: UIButton){
        if isShowMore {
            isShowMore = false
            self.BarDetailTableView.reloadData()
        }else{
            if self.drinkOtherArray.count > 0{
                isShowMore = true
                self.BarDetailTableView.reloadData()
            }
            
        }
        //self.BarDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 2), at: .bottom, animated: false)
        
    }
    @objc func showTimingBtnAction(_ sender: UIButton){
        PopupHelper.alertTimingViewController(controler: self)
    }
    
    func calculateTimings(data:[WeekDayModelW],bname:String? = nil) -> (String?,String?,UIColor,Bool){
        
        let time = Date()
        
        let chours = time.hour(.cet)
        let cmins = time.minute(.cet)
        var openClose = ""
        var timestr = ""
        var color = UIColor.black
        var isClosed = false
        let weekFullDay = time.weekFullDay
        let ydate = time.subtract(days: 1)
        let yweekFullDay = ydate.weekFullDay
        
        let yesturdayWeekDay = data.filter { weekDayModelW in
            return yweekFullDay == weekDayModelW.weekDay
        }
        
        let curentWeekDay = data.filter { weekDayModelW in
            return weekFullDay == weekDayModelW.weekDay
        }
        
        
        var isyesturday = false
        if yesturdayWeekDay.count == 1 {
            if let svalue = yesturdayWeekDay.first?.svalue,let evalue = yesturdayWeekDay.first?.evalue{
                if svalue != 0 && evalue != 0{
                    let shours = svalue.timestampToDate().hour(.cet)
                    //let smins = svalue.timestampToDate().minute(.cet)
                    let ehours = evalue.timestampToDate().hour(.cet)
                    let emins = evalue.timestampToDate().minute(.cet)
                    if shours > ehours{
                        if ehours > chours{
                            timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                            openClose = "Open".localized()
                            color = .green
                            isClosed = false
                            isyesturday = true
                            
                            
                        }else if ehours == chours{
                            if emins > cmins{
                                timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                openClose = "Open".localized()
                                color = .green
                                isClosed = false
                                isyesturday = true
                            }
                        }
                        else{
                            
                        }
                    }
                }
            }
        }
        else if yesturdayWeekDay.count == 2 {
            for yweekDay in yesturdayWeekDay{
                if yweekDay.name != nil || yweekDay.name != ""{
                    if let svalue = yweekDay.svalue,let evalue = yweekDay.evalue{
                        if svalue != 0 && evalue != 0{
                            let shours = svalue.timestampToDate().hour(.cet)
                            //let smins = svalue.timestampToDate().minute(.cet)
                            let ehours = evalue.timestampToDate().hour(.cet)
                            let emins = evalue.timestampToDate().minute(.cet)
                            if shours > ehours{
                                if ehours > chours{
                                    timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                    openClose = "Open".localized()
                                    color = .green
                                    isClosed = false
                                    isyesturday = true
                                    break
                                }
                                else if ehours == chours{
                                    if emins > cmins{
                                        timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                        openClose = "Open".localized()
                                        color = .green
                                        isClosed = false
                                        isyesturday = true
                                        break
                                    }
                                }
                            }
                        }
                        
                    }
                }
                else{
                    if let svalue = yweekDay.svalue,let evalue = yweekDay.evalue{
                        if svalue != 0 && evalue != 0{
                            let shours = svalue.timestampToDate().hour(.cet)
                            //let smins = svalue.timestampToDate().minute(.cet)
                            let ehours = evalue.timestampToDate().hour(.cet)
                            let emins = evalue.timestampToDate().minute(.cet)
                            if shours > ehours{
                                if ehours > chours{
                                    timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                    openClose = "Open".localized()
                                    color = .green
                                    isClosed = false
                                    isyesturday = true
                                    break
                                }
                                else if ehours == chours{
                                    if emins > cmins{
                                        timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                        openClose = "Open".localized()
                                        color = .green
                                        isClosed = false
                                        isyesturday = true
                                        break
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
        
        if !isyesturday{
            if curentWeekDay.count == 1{
                if let svalue = curentWeekDay.first?.svalue,let evalue = curentWeekDay.first?.evalue{
                    if svalue != 0 && evalue != 0{
                        let shours = svalue.timestampToDate().hour(.cet)
                        let smins = svalue.timestampToDate().minute(.cet)
                        let ehours = evalue.timestampToDate().hour(.cet)
                        let emins = evalue.timestampToDate().minute(.cet)
                        if shours > ehours{
                            if  chours > shours {
                                timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                openClose = "Open".localized()
                                color = .green
                                isClosed = false
                            }
                            else if chours == ehours{
                                if cmins < emins{
                                    timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                    openClose = "Open".localized()
                                    color = .green
                                    isClosed = false
                                }
                            }
                            else if chours == shours{
                                if cmins > smins{
                                    timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                    openClose = "Open".localized()
                                    color = .green
                                    isClosed = false
                                }
                            }
//                            else {
//                                timestr = "- Opens at".localized() + " \(svalue.timestampToTimeString()!)"
//                                openClose = "Closed".localized()
//                                color = .red
//                                isClosed = true
//                            }
                        }
                        else{
                            if chours > shours && chours < ehours {
                                timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                openClose = "Open".localized()
                                color = .green
                                isClosed = false
                            }
                            else if chours == shours{
                                
                                if cmins > smins{
                                    if emins == 0{
                                        if cmins == emins{
                                            
                                        }
                                        else{
                                            timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                            openClose = "Open".localized()
                                            color = .green
                                            isClosed = false
                                        }
                                    }
                                    else{
                                        if cmins >= emins{
                                            
                                        }
                                        else{
                                            timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                            openClose = "Open".localized()
                                            color = .green
                                            isClosed = false
                                        }
                                    }
                                    if cmins == emins{
                                        
                                    }
                                    else{
                                        
                                    }
                                    
                                    
                                }
                            }
                            else if chours == ehours{
                                if cmins < emins{
                                    timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                    openClose = "Open".localized()
                                    color = .green
                                    isClosed = false
                                }
                            }
                        }
                        
                    }
                }
            }
            else if curentWeekDay.count == 2{
                for weekDay in curentWeekDay{
                    if weekDay.name != nil || weekDay.name != ""{
                        if let svalue = weekDay.svalue,let evalue = weekDay.evalue{
                            if svalue != 0 && evalue != 0{
                                let shours = svalue.timestampToDate().hour(.cet)
                                let smins = svalue.timestampToDate().minute(.cet)
                                let ehours = evalue.timestampToDate().hour(.cet)
                                let emins = evalue.timestampToDate().minute(.cet)
                                if shours > ehours{
                                    if  chours > shours {
                                        timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                        openClose = "Open".localized()
                                        color = .green
                                        isClosed = false
                                    }
                                    else if chours == ehours{
                                        if cmins < emins{
                                            timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                            openClose = "Open".localized()
                                            color = .green
                                            isClosed = false
                                        }
                                    }
                                    else if chours == shours{
                                        if cmins > smins{
                                            timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                            openClose = "Open".localized()
                                            color = .green
                                            isClosed = false
                                        }
                                    }
        //                            else {
        //                                timestr = "- Opens at".localized() + " \(svalue.timestampToTimeString()!)"
        //                                openClose = "Closed".localized()
        //                                color = .red
        //                                isClosed = true
        //                            }
                                }
                                else{
                                    if chours > shours && chours < ehours {
                                        timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                        openClose = "Open".localized()
                                        color = .green
                                        isClosed = false
                                    }
                                    else if chours == shours{
                                        
                                        if cmins > smins{
                                            if emins == 0{
                                                if cmins == emins{
                                                    
                                                }
                                                else{
                                                    timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                                    openClose = "Open".localized()
                                                    color = .green
                                                    isClosed = false
                                                }
                                            }
                                            else{
                                                if cmins >= emins{
                                                    
                                                }
                                                else{
                                                    timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                                    openClose = "Open".localized()
                                                    color = .green
                                                    isClosed = false
                                                }
                                            }
                                            if cmins == emins{
                                                
                                            }
                                            else{
                                                
                                            }
                                            
                                            
                                        }
                                    }
                                    else if chours == ehours{
                                        if cmins < emins{
                                            timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                            openClose = "Open".localized()
                                            color = .green
                                            isClosed = false
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    else{
                        if let svalue = weekDay.svalue,let evalue = weekDay.evalue{
                            if svalue != 0 && evalue != 0{
                                let shours = svalue.timestampToDate().hour(.cet)
                                let smins = svalue.timestampToDate().minute(.cet)
                                let ehours = evalue.timestampToDate().hour(.cet)
                                let emins = evalue.timestampToDate().minute(.cet)
                                if shours > ehours{
                                    if  chours > shours {
                                        timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                        openClose = "Open".localized()
                                        color = .green
                                        isClosed = false
                                    }
                                    else if chours == ehours{
                                        if cmins < emins{
                                            timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                            openClose = "Open".localized()
                                            color = .green
                                            isClosed = false
                                        }
                                    }
                                    else if chours == shours{
                                        if cmins > smins{
                                            timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                            openClose = "Open".localized()
                                            color = .green
                                            isClosed = false
                                        }
                                    }
        //                            else {
        //                                timestr = "- Opens at".localized() + " \(svalue.timestampToTimeString()!)"
        //                                openClose = "Closed".localized()
        //                                color = .red
        //                                isClosed = true
        //                            }
                                }
                                else{
                                    if chours > shours && chours < ehours {
                                        timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                        openClose = "Open".localized()
                                        color = .green
                                        isClosed = false
                                    }
                                    else if chours == shours{
                                        
                                        if cmins > smins{
                                            if emins == 0{
                                                if cmins == emins{
                                                    
                                                }
                                                else{
                                                    timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                                    openClose = "Open".localized()
                                                    color = .green
                                                    isClosed = false
                                                }
                                            }
                                            else{
                                                if cmins >= emins{
                                                    
                                                }
                                                else{
                                                    timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                                    openClose = "Open".localized()
                                                    color = .green
                                                    isClosed = false
                                                }
                                            }
                                            if cmins == emins{
                                                
                                            }
                                            else{
                                                
                                            }
                                            
                                            
                                        }
                                    }
                                    else if chours == ehours{
                                        if cmins < emins{
                                            timestr = "- Closes at".localized() + " \(evalue.timestampToTimeString()!)"
                                            openClose = "Open".localized()
                                            color = .green
                                            isClosed = false
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
        }
        if timestr == ""{
            for week in data{
                if Date().weekFullDay == week.weekDay{
                    if let svalue = week.svalue,svalue != 0{
                        let shours = svalue.timestampToDate().hour(.cet)
                        let smins = svalue.timestampToDate().minute(.cet)
                        if chours < shours /*&& mins < smins*/{
                            
                            timestr = "- Opens at".localized() + " \(week.svalue.timestampToTimeString()!)"
                            openClose = "Closed".localized()
                            color = .red
                            isClosed = true
                            break
  
                        }
                        else if chours == shours{
                            if cmins < smins{
                                timestr = "- Opens at".localized() + " \(week.svalue.timestampToTimeString()!)"
                                openClose = "Closed".localized()
                                color = .red
                                isClosed = true
                                break
                            }
                        }
                    }
                    
                }
                
            }
        }
        if timestr == ""{
            let weekday = Date().weekFullDay
            var isweek = false
            var weekname = ""
            for (i,week) in data.enumerated(){
                if weekday == week.weekDay{
                    isweek = true
                    weekname = week.weekDay
                    if let svalue = week.svalue,svalue != 0,let evalue = week.evalue,evalue != 0 {
                        if week.weekDay != nil{
                            timestr = "- Opens on".localized() + " " + "\(week.weekDay ?? weekname)".localized()
                            openClose = "Closed".localized()
                            color = .red
                            isClosed = true
                            
                        }
                        else{
                            timestr = "- Opens on".localized() + " " + "\(data[i-1].weekDay ?? weekname)".localized()
                            openClose = "Closed".localized()
                            color = .red
                            isClosed = true
                            
                        }
                        
                    }
                }
                else{
                    if isweek{
                        if let svalue = week.svalue,svalue != 0,let evalue = week.evalue,evalue != 0 {
                            if week.weekDay != nil{
                                timestr = "- Opens on".localized() + " " + "\(week.weekDay ?? weekname)".localized()
                                openClose = "Closed".localized()
                                color = .red
                                isClosed = true
                                break
                            }
                            
                        }
                    }
                    else{
                        if i != 0{
                            if (data[i-1].svalue == nil && data[i-1].evalue == nil) || (data[i-1].svalue == 0 && data[i-1].evalue == 0){
                                if let svalue = week.svalue,svalue != 0,let evalue = week.evalue,evalue != 0 {
                                    timestr = "- Opens on".localized() + " "  + "\(week.weekDay ?? weekname)".localized()
                                    openClose = "Closed".localized()
                                    color = .red
                                    isClosed = true
                                    break
                                }
                            }
                            else{
                                
                            }
                        }
                        else{
                            if let svalue = week.svalue,svalue != 0,let evalue = week.evalue,evalue != 0 {
                                timestr = "- Opens on".localized() + " " + "\(week.weekDay ?? weekname)".localized()
                                openClose = "Closed".localized()
                                color = .red
                                isClosed = true
                                
                            }
                        }
                        
                    }
                }
                
                
            }
            
        }
        if timestr == ""{
            timestr = "- Opening Soon".localized()
            openClose = "Closed".localized()
            color = .red
            isClosed = true
        }
        if isBarShow{
            //self.BarDetailTableView.reloadSections([1], with: .automatic)
        }
        else{
            //self.BarDetailTableView.reloadSections([0], with: .automatic)
        }
        
        return (openClose,timestr,color,isClosed)
    
    }

}

// MARK:- LOCATION METHOD'S EXTENSION
extension MapViewController: LocationPermissionsDelegate,LocationProviderDelegate {
    func locationProvider(_ provider: LocationProvider, didUpdateHeading newHeading: CLHeading) {
        
    }
    
    func locationProvider(_ provider: LocationProvider, didFailWithError error: Error) {
        
    }
    
    func locationProviderDidChangeAuthorization(_ provider: LocationProvider) {
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
    func locationProvider(_ provider: LocationProvider, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        self.myLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        if !UserDefaults.standard.bool(forKey: Constant.isFirstTime1){
            UserDefaults.standard.set(true, forKey: Constant.isFirstTime1)
            CommonHelper.saveCachedUserLocData(LocationModel(address_lat: self.myLocation.latitude, address_lng: self.myLocation.longitude, zoom: self.zoomLevel, pitch: self.pitchLevel, bearing: self.bearingLevel))
        }
        if CommonHelper.getCachedMapLocData() == nil{
            let option = CameraOptions(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), zoom: self.zoomLevel, bearing: self.bearingLevel, pitch: self.pitchLevel)
            self.Mapbox.mapboxMap.setCamera(to: option)
            
        }
        self.Mapbox.location.overrideLocationProvider(with: provider)
        //provider.stopUpdatingLocation()
    }
}
