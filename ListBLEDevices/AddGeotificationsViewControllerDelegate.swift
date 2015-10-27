//
//  AddGeotificationProtocol.swift
//  ListBLEDevices
//
//  Created by Yogesh Ranjan on 6/8/15.
//  Copyright (c) 2015 KSYR. All rights reserved.
//

import Foundation
import MapKit


protocol AddGeotificationsViewControllerDelegate {
    func addGeotificationViewController(controller: AddGeotificationViewController, didAddCoordinate coordinate: CLLocationCoordinate2D,
        radius: Double, identifier: String, note: String, eventType: EventType)
    
    func addGeotification(bleLocation: BLELocation)
}



