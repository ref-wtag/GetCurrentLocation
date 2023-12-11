//
//  ViewController.swift
//  GetCurrentLocation
//
//  Created by Refat E Ferdous on 12/11/23.
//

import UIKit
import CoreLocation
import MapKit

//import PlaygroundSupport
//PlaygroundPage.current.needsIndefiniteExecution = true

class ViewController: UIViewController {

    
    let locationManager = CLLocationManager()
    
    var lat : Double = 0.0
    var lon : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLocation()
    }
    
    func getCurrentLocation(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.global().async { [self] in
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
           // locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        }
    }

    func getCityName(){
        print("here1")
        let location = CLLocation(latitude: lat, longitude: lon)
        location.fetchCityAndCountry { city, country, error in
            print("city = \(city)")
            print("country = \(country)")
            print("error = \(city)")
            
            
            guard let city = city, let country = country, error == nil else {
                print("executing this")
                return }
            print(city + ", " + country)
            print("hello there")
        }
        print("here2")
    }
}

extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue : CLLocationCoordinate2D = manager.location?.coordinate else{return}
        print("location = \(locationValue.latitude) \(locationValue.longitude)")
        
        self.lat = locationValue.latitude
        self.lon = locationValue.longitude
        self.getCityName()
    }
}

extension CLLocation{
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.administrativeArea, $0?.first?.country, $1) }
    }
    
}
