//
//  LocationController.swift
//  RockClimbing
//
//  Created by Sara Medernach on 5/4/20.
//  Copyright © 2020 Sara Medernach. All rights reserved.
//

import UIKit
import CoreLocation

class LocationController: NSObject, CLLocationManagerDelegate {

    static var locationManager:CLLocationManager = CLLocationManager()
    
    static var locationController:LocationController = LocationController()
    
    static var currentLocation:CLLocation? = nil
    
    static let NOTIFICATION_LOCATION_DID_UPDATE = "LOCATION_DID_UPDATE"
    
    static func startMonitoringLocation() {
        
        locationManager.delegate = locationController
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.distanceFilter = 100
        
        locationManager.startUpdatingLocation()
        
    }
    
    static func stopMonitoringLocation() {
        
        locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        LocationController.currentLocation = locations.last
        
        NotificationCenter.default.post(name: NSNotification.Name(LocationController.NOTIFICATION_LOCATION_DID_UPDATE), object: nil)
    }
    
}
