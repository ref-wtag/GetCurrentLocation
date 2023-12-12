//
//  ViewController.swift
//  GetCurrentLocation
//
//  Created by Refat E Ferdous on 12/11/23.
//

import UIKit
import CoreLocation
import MapKit
import FloatingPanel

class ViewController: UIViewController {
    
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        title = "Search Location"
        
        let panel = FloatingPanelController()
        panel.set(contentViewController: LocationSearchViewController())
        panel.addPanel(toParent : self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    
    
}
