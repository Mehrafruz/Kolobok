//
//  MapViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 21.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import YandexMapsMobile

var globalCategoriesElements: [CategoryElements.Results] = []

class MapViewController: UIViewController{
    
    private let output: MapViewOutput
    let mapView = YMKMapView()
    private let userLocationButton = UIButton()
    private let filterButton = UIButton()
    private var points = [YMKPoint]()
    var collection: YMKClusterizedPlacemarkCollection?
    
    private var userLocationLayer: YMKUserLocationLayer?
    
    
    
    init(output: MapViewOutput) {
        self.output = output
        userLocationLayer = YMKMapKit.sharedInstance().createUserLocationLayer(with: mapView.mapWindow)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        output.categoriesElementsIsLoad(categories: "park,questroom,art-space,museums,bar,clubs,attractions", page: 1, pageSize: 500)
        output.categoriesElementsIsLoad(categories: "park,questroom,art-space,museums,bar,clubs,attractions", page: 2, pageSize: 500)
        output.categoriesElementsIsLoad(categories: "park,questroom,art-space,museums,bar,clubs,attractions", page: 3, pageSize: 500)
        output.categoriesElementsIsLoad(categories: "park,questroom,art-space,museums,bar,clubs,attractions", page: 4, pageSize: 500)
        output.categoriesElementsIsLoad(categories: "park,questroom,art-space,museums,bar,clubs,attractions", page: 5, pageSize: 500)

//        output.categoriesElementsIsLoad(categories: "", page: 1, pageSize: 500)
//        output.categoriesElementsIsLoad(categories: "", page: 2, pageSize: 500)
//        output.categoriesElementsIsLoad(categories: "", page: 3, pageSize: 500)
//        output.categoriesElementsIsLoad(categories: "", page: 4, pageSize: 500)
//        output.categoriesElementsIsLoad(categories: "", page: 5, pageSize: 500)
//        output.categoriesElementsIsLoad(categories: "", page: 6, pageSize: 500)
//        output.categoriesElementsIsLoad(categories: "", page: 7, pageSize: 500)
//        output.categoriesElementsIsLoad(categories: "", page: 8, pageSize: 500)
//        output.categoriesElementsIsLoad(categories: "", page: 9, pageSize: 500)
//

        mapView.mapWindow.map.addCameraListener(with: self)
        mapView.mapWindow.map.move(with: YMKCameraPosition.init(target: YMKPoint(latitude: 55.752, longitude: 37.61556), zoom: 12, azimuth: 0, tilt: 0))
        view.addSubview(mapView)
        setup()
        //_ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(loadMapElements), userInfo: nil, repeats: false)
    }
    
    private func setup() {
        [userLocationButton, filterButton].forEach {
            mapView.addSubview($0)
        }
        
        setupLittleButton(button: userLocationButton, imageName: "location.fill", bgImageName: "", tintColor: ColorPalette.black)
        setupLittleButton(button: filterButton, imageName: "slider.horizontal.3", bgImageName: "", tintColor: ColorPalette.black)
        userLocationButton.addTarget(self, action: #selector(didClickedUserLocationButton), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(didClickedFilterButton), for: .touchUpInside)
        addConstraints()
    }
    
    private func addConstraints() {
        [mapView, userLocationButton, filterButton].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userLocationButton.widthAnchor.constraint(equalToConstant: 50),
            userLocationButton.heightAnchor.constraint(equalToConstant: 50),
            userLocationButton.bottomAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: -50),
            userLocationButton.rightAnchor.constraint(equalTo: self.mapView.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            filterButton.widthAnchor.constraint(equalToConstant: 50),
            filterButton.heightAnchor.constraint(equalToConstant: 50),
            filterButton.bottomAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: -50),
            filterButton.leftAnchor.constraint(equalTo: self.mapView.leftAnchor, constant: 30)
        ])
        
    }
    
    @objc
    func loadMapElements(){
        output.categoriesElementsIsLoad(categories: "park,questroom,art-space,museums,bar,clubs,attractions", page: 1, pageSize: 200)
    }
    
    func setupLittleButton(button: UIButton, imageName: String, bgImageName: String, tintColor: UIColor) {
        button.setImage( UIImage(systemName: imageName), for: UIControl.State.normal)
        button.setBackgroundImage( UIImage(systemName: bgImageName), for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.tintColor = tintColor
        button.backgroundColor = ColorPalette.gray
        button.alpha = 0.75
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func setupButton(button: UIButton, title: String, color: UIColor, textColor: UIColor){
           button.setTitle(title, for: UIControl.State.normal)
           button.setTitleColor(textColor, for: UIControl.State.normal)
           button.titleLabel?.font = UIFont(name: "POEVeticaVanta", size: 15)
           button.backgroundColor = color
           button.layer.zPosition = 1.5
           button.layer.cornerRadius = 20
           button.clipsToBounds = true
           button.layer.shadowRadius = 4.0
           button.layer.shadowOpacity = 0.6
           button.layer.masksToBounds = false
           button.layer.shadowOffset = CGSize(width: 0, height: 4)
       }
    
     let filterViewController = FilterViewController()
    
}


extension MapViewController: YMKMapCameraListener, YMKUserLocationObjectListener, YMKClusterListener,  YMKMapObjectTapListener{
    
    func onObjectAdded(with view: YMKUserLocationView) {
        let pinPlacemark = view.pin.useCompositeIcon()
        
        pinPlacemark.setIconWithName("location.circle",
                                     image: UIImage(systemName:"location.circle")!,
                                     style:YMKIconStyle(
                                        anchor: CGPoint(x: 0, y: 0) as NSValue,
                                        rotationType:YMKRotationType.rotate.rawValue as NSNumber,
                                        zIndex: 0,
                                        flat: true,
                                        visible: true,
                                        scale: 1.5,
                                        tappableArea: nil))
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {
        
    }
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {
        
    }
    
    func onCameraPositionChanged(with map: YMKMap,
                                 cameraPosition: YMKCameraPosition,
                                 cameraUpdateReason: YMKCameraUpdateReason,
                                 finished: Bool) {
        
    }
    
    
    @objc
     func didClickedUserLocationButton(){
        //let scale = UIScreen.main.scale
        userLocationButton.pulsate()
        userLocationLayer?.setVisibleWithOn(true)
        userLocationLayer?.isHeadingEnabled = true
       // userLocationLayer?.setAnchorWithAnchorNormal(CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale), anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
        //userLocationLayer?.setObjectListenerWith(self)
        mapView.mapWindow.map.move( with: userLocationLayer?.cameraPosition() ?? YMKCameraPosition.init(target: YMKPoint(latitude: 55.752, longitude: 37.61556), zoom: 12, azimuth: 0, tilt: 0))
    }
    
   
    
    @objc
    func didClickedFilterButton(){
        filterViewController.delegate = self
        filterButton.pulsate()
        output.didSelectFilter()
    }
    
    
    
    func onClusterAdded(with cluster: YMKCluster) {
        
    }
    
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        guard let userPoint = mapObject as? YMKPlacemarkMapObject else {
            print (point)
            return true
        }
        output.didSelect(at: userPoint.userData as! Int)
        return true
    }
}

extension MapViewController: MapViewInput{
    
    func update() {
       
        collection = mapView.mapWindow.map.mapObjects.addClusterizedPlacemarkCollection(with: self)
        collection?.addTapListener(with: self)
        
        for i in 0..<globalCategoriesElements.count{
            points.append(YMKPoint(latitude: globalCategoriesElements[i].coords.lat, longitude: globalCategoriesElements[i].coords.lon))
            let placeMark = collection?.addPlacemark(with: YMKPoint(latitude: globalCategoriesElements[i].coords.lat, longitude: globalCategoriesElements[i].coords.lon),
                                    image: UIImage(named: "pointInMapBlackMini")!,
                                    style: YMKIconStyle.init())
            placeMark?.userData = i
        }
        collection?.clusterPlacemarks(withClusterRadius: 10, minZoom: 5)
        
        mapView.mapWindow.map.move(
            with: YMKCameraPosition.init(target: YMKPoint(latitude: 55.752, longitude: 37.61556), zoom: 12, azimuth: 0, tilt: 0))
    }
    
    
}

extension MapViewController: FilterWillApplied{
    
    func applyFilter(categories: String, page: Int) {
        mapView.mapWindow.map.mapObjects.clear()
        globalCategoriesElements.removeAll()
        output.categoriesElementsIsLoad(categories: categories, page: page, pageSize: 500)
    }
    
    
}
