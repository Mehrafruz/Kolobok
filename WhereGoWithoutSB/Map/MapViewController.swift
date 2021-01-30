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
        output.categoriesElementsIsLoad()
        mapView.mapWindow.map.addCameraListener(with: self)
        view.addSubview(mapView)
        setup()
       

        
    }
    
    private func setup() {
        [userLocationButton].forEach {
            mapView.addSubview($0)
        }
        
        setupLittleButton(button: userLocationButton, imageName: "location.fill", bgImageName: "", tintColor: ColorPalette.black)
        userLocationButton.addTarget(self, action: #selector(didClickedUserLocationButton), for: .touchUpInside)
        userLocationButton.backgroundColor = ColorPalette.gray
        userLocationButton.alpha = 0.75
        
        addConstraints()
    }
    
    private func addConstraints() {
        [mapView, userLocationButton ].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userLocationButton.widthAnchor.constraint(equalToConstant: 50),
            userLocationButton.heightAnchor.constraint(equalToConstant: 50),
            userLocationButton.bottomAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: -160),
            userLocationButton.rightAnchor.constraint(equalTo: self.mapView.rightAnchor, constant: -30)
        ])
        
    }
    
    
    func setupLittleButton(button: UIButton, imageName: String, bgImageName: String, tintColor: UIColor) {
        button.setImage( UIImage(systemName: imageName), for: UIControl.State.normal)
        button.setBackgroundImage( UIImage(systemName: bgImageName), for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.tintColor = tintColor
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
    
    
    @objc func didClickedUserLocationButton(){
        let scale = UIScreen.main.scale
        userLocationLayer?.setVisibleWithOn(true)
        userLocationLayer?.isHeadingEnabled = true
        userLocationLayer?.setAnchorWithAnchorNormal(CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale), anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
        userLocationLayer?.setObjectListenerWith(self)
        mapView.mapWindow.map.move( with: userLocationLayer?.cameraPosition() ?? YMKCameraPosition.init(target: points[54], zoom: 12, azimuth: 0, tilt: 0))
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
            with: YMKCameraPosition.init(target: points[54], zoom: 12, azimuth: 0, tilt: 0))
    }
    
    
}
