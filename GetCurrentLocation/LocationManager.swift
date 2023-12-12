//
//  LocationManager.swift
//  GetCurrentLocation
//
//  Created by Refat E Ferdous on 12/12/23.
//

import Foundation
import CoreLocation

struct Location{
    let title : String
    let coordinates : CLLocationCoordinate2D
}

class LocationManager : NSObject{
    static let shared = LocationManager()
    
    public func findLocations(with query : String, completion : @escaping (([ Location]) -> Void)){
    let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(query) { places , error in
            guard let places = places , error == nil else{
                completion([])
                return
            }
            
            let models : [Location] = places.compactMap({ place in
                
                var name1 = ""
                
                if let locationName = place.name{
                    name1 += locationName
                }
                if let adminRegion = place.administrativeArea{
                    name1 += ", \(adminRegion)"
                }
                if let locality = place.locality{
                    name1 += ", \(locality)"
                }
                if let country = place.country{
                    name1 += ", \(country)"
                }
                
                print("\n \(place)\n\n")
                
                let result = Location(
                    title: name1,
                    coordinates: place.location!.coordinate
                )
                return result
            })
            completion(models)
        }
    }
}
