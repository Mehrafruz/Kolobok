//
//  MapViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 21.10.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import YandexMapsMobile

class MapViewController: UIViewController {
    
    let mapView = YMKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var title = "Колобок"
        self.navigationItem.title = title
        
        view.backgroundColor = .white
        view.addSubview(mapView)
        addConstraints()
        
        let startLocation = YMKPoint(latitude: 55.7522, longitude: 37.6156)
        mapView.mapWindow.map.move(
            with: YMKCameraPosition.init(target: startLocation, zoom: 15, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.linear, duration: 1),
            cameraCallback: nil)
        // Do any additional setup after loading the view.
    }
    
    func addConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    

}
