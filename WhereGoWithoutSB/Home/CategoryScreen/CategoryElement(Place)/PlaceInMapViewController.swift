//
//  PlaceInMapViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 10.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import YandexMapsMobile

class PlaceInMapViewController: UIViewController {
    
    private var lat: Double
    private var lon: Double
    private let routeButton = UIButton()
    private let contentView = UIView()
    private let mapView = YMKMapView()
    private let goBackButton = UIButton()
    private let userLocationButton = UIButton()
    private var userLocationLayer: YMKUserLocationLayer?
    
    init(lat: Double, lon: Double){
        self.lat = lat
        self.lon = lon
        super.init(nibName: nil, bundle: nil)
        userLocationLayer = YMKMapKit.sharedInstance().createUserLocationLayer(with: mapView.mapWindow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let TARGET_LOCATION = YMKPoint(latitude: self.lat, longitude: self.lon)
        
        
        mapView.mapWindow.map.addCameraListener(with: self)
        
        
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: TARGET_LOCATION, zoom: 15, azimuth: 0, tilt: 0))
        let mapObjects = mapView.mapWindow.map.mapObjects
        let placemark = mapObjects.addPlacemark(with: TARGET_LOCATION)
        placemark.setIconWith(UIImage(named: "pointInMapBlack")!)
        
        setup()
        
        mapView.mapWindow.map.addTapListener(with: self)
        mapView.mapWindow.map.addInputListener(with: self)
    }
    
    
    private func setup(){
        setupLittleButton(button: goBackButton, imageName: "", bgImageName: "arrow.left", tintColor: ColorPalette.black)
        setupLittleButton(button: userLocationButton, imageName: "location.fill", bgImageName: "", tintColor: ColorPalette.black)
        setupButton(button: routeButton, title: "Маршрут", color: ColorPalette.gray, textColor: ColorPalette.black)
        goBackButton.addTarget(self, action: #selector(didClickedGoBackButton), for: .touchUpInside)
        routeButton.addTarget(self, action: #selector(didclickedRouteButton), for: .touchUpInside)
        
        userLocationButton.addTarget(self, action: #selector(didClickedUserLocationButton), for: .touchUpInside)
        userLocationButton.backgroundColor = ColorPalette.gray
        userLocationButton.alpha = 0.75
        routeButton.alpha = 0.75
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        view.addSubview(contentView)
        contentView.addSubview(mapView)
        
        [goBackButton, userLocationButton, routeButton].forEach {
            mapView.addSubview($0)
        }
        
        addConstraints()
    }
    
    private func addConstraints(){
        [contentView, mapView, goBackButton, userLocationButton, routeButton].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.85).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            goBackButton.widthAnchor.constraint(equalToConstant: 30),
            goBackButton.heightAnchor.constraint(equalToConstant: 30),
            goBackButton.topAnchor.constraint(equalTo: self.mapView.topAnchor, constant: 20),
            goBackButton.leftAnchor.constraint(equalTo: self.mapView.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            userLocationButton.widthAnchor.constraint(equalToConstant: 50),
            userLocationButton.heightAnchor.constraint(equalToConstant: 50),
            userLocationButton.bottomAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: -170),
            userLocationButton.rightAnchor.constraint(equalTo: self.mapView.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            routeButton.widthAnchor.constraint(equalToConstant: 80),
            routeButton.heightAnchor.constraint(equalToConstant: 45),
            routeButton.bottomAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: -100),
            routeButton.rightAnchor.constraint(equalTo: self.mapView.rightAnchor, constant: -15)
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
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    @objc
    func didClickedGoBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didclickedRouteButton(){
        if let url = URL(string: "https://yandex.ru/maps/?rtext=~\(lat),\(lon)") {
            UIApplication.shared.open(url)
        }
    }
    
}

extension PlaceInMapViewController: YMKLayersGeoObjectTapListener, YMKMapInputListener, YMKTrafficDelegate,YMKMapCameraListener, YMKUserLocationObjectListener{ //MKUserLocationObjectListener
    func onObjectAdded(with view: YMKUserLocationView) {

        let pinPlacemark = view.pin.useCompositeIcon()
        
        pinPlacemark.setIconWithName("userLocation",
            image: UIImage(named:"userLocation")!,
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
    
    
    @objc func didClickedUserLocationButton(){
        let scale = UIScreen.main.scale
        userLocationLayer?.setVisibleWithOn(true)
        userLocationLayer?.isHeadingEnabled = true
        userLocationLayer?.setAnchorWithAnchorNormal(
            CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
            anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
        userLocationLayer?.setObjectListenerWith(self)
        mapView.mapWindow.map.move( with: userLocationLayer?.cameraPosition() ?? YMKCameraPosition.init(target: YMKPoint(latitude: self.lat, longitude: self.lon), zoom: 12, azimuth: 0, tilt: 0))
    }
    
    func onTrafficChanged(with trafficLevel: YMKTrafficLevel?) {
        
    }
    
    func onTrafficLoading() {
        
    }
    
    func onTrafficExpired() {
        
    }
    
    
    
    func onCameraPositionChanged(with map: YMKMap, cameraPosition: YMKCameraPosition, cameraUpdateReason: YMKCameraUpdateReason, finished: Bool) {
        
    }
    
    func onObjectTap(with event: YMKGeoObjectTapEvent) -> Bool {
        let event = event
        let metadata = event.geoObject.metadataContainer.getItemOf(YMKGeoObjectSelectionMetadata.self)
        if let selectionMetadata = metadata as? YMKGeoObjectSelectionMetadata {
            mapView.mapWindow.map.selectGeoObject(withObjectId: selectionMetadata.id, layerId: selectionMetadata.layerId)
            return true
        }
        return false
    }
    
    func onMapTap(with map: YMKMap, point: YMKPoint) {
        mapView.mapWindow.map.deselectGeoObject()
    }
    
    func onMapLongTap(with map: YMKMap, point: YMKPoint) {
        
    }
    
    
}
