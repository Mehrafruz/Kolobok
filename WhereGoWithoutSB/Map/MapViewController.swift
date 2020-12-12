//
//  MapViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 21.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import YandexMapsMobile

var categoriesElements: [CategoryElements.Results] = []

class MapViewController: UIViewController{
    
    private let output: MapViewOutput
    let mapView = YMKMapView()
    private let userLocationButton = UIButton()
    
    private let customGrayColor = UIColor(red: 177/255, green: 190/255, blue: 197/255, alpha: 1)
    private let customBlackColor = UIColor(red: 31/255, green: 30/255, blue: 35/255, alpha: 1)
    
    
    

    init(output: MapViewOutput) {
        self.output = output
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
        let startLocation = YMKPoint(latitude: 55.7522, longitude: 37.6156)
        
        mapView.mapWindow.map.addCameraListener(with: self)
        
        mapView.mapWindow.map.move(
            with: YMKCameraPosition.init(target: startLocation, zoom: 15, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.linear, duration: 1),
            cameraCallback: nil)
        view.addSubview(mapView)
        setup()
        
    }
    
    private func setup() {
        [userLocationButton].forEach {
            mapView.addSubview($0)
        }
        
        setupLittleButton(button: userLocationButton, imageName: "location.fill", bgImageName: "", tintColor: customBlackColor)
        userLocationButton.addTarget(self, action: #selector(didClickedUserLocationButton), for: .touchUpInside)
        userLocationButton.backgroundColor = customGrayColor
        userLocationButton.alpha = 0.75
        
        addConstraints()
    }
    
    private func addConstraints() {
        [mapView, userLocationButton].forEach {
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
            userLocationButton.bottomAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: -100),
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
    
    
    
    
}


extension MapViewController: YMKMapCameraListener, YMKUserLocationObjectListener{
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
    
    func onCameraPositionChanged(with map: YMKMap,
                                 cameraPosition: YMKCameraPosition,
                                 cameraUpdateReason: YMKCameraUpdateReason,
                                 finished: Bool) {
        
    }
    
    
    @objc func didClickedUserLocationButton(){
        let scale = UIScreen.main.scale
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        userLocationLayer.setAnchorWithAnchorNormal(
            CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
            anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
        userLocationLayer.setObjectListenerWith(self)
        
        print ("didClickedUserLocationButton")
    }
    
}

extension MapViewController: MapViewInput{
    func update() {
        //тут добавляем все точки, видимо
    }
    
    
}
