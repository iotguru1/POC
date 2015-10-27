//
//  BLELocation.swift
//  ListBLEDevices
//
//  Created by Yogesh Ranjan on 6/3/15.
//  Copyright (c) 2015 KSYR. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

let kGeotificationLatitudeKey = "latitude"
let kGeotificationLongitudeKey = "longitude"
let kGeotificationRadiusKey = "radius"
let kGeotificationNoteKey = "note"
let kGeotificationIdentifierKey = "identifier"
let kGeotificationEventTypeKey = "eventType"

enum EventType: Int {
    case OnEntry = 0
    case OnExit
}

public class BLELocation : NSObject, NSCoding, MKAnnotation {
    var locationName: String? = nil
    //public var title: String? = nil
    public var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance? = nil
    var identifier: String? = nil
    //var subtitle: String
    var note: String? = nil
    var eventType: EventType? = nil
    
    init(locationName: String, coordinate: CLLocationCoordinate2D) {
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    public var title: String {
        if note != nil {
            return note!
        } else if (locationName != nil) {
            return locationName!
        } else {
            return "No Title"
        }
    }
    
    public var subtitle: String {
        var eventTypeString = (eventType == .OnEntry) ? "On Entry" : (eventType == .OnExit) ? "On Exit" : "On Spot"
        radius = radius != nil ? radius : 0
        
        return "Radius: \(radius!)m - \(eventTypeString)"
    }
    
    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String, note: String, eventType: EventType) {
        self.coordinate = coordinate
        self.radius = radius
        self.identifier = identifier
        self.note = note
        self.eventType = eventType
    }
    
    // MARK: NSCoding
    
    required public init(coder decoder: NSCoder) {
        let latitude = decoder.decodeDoubleForKey(kGeotificationLatitudeKey)
        let longitude = decoder.decodeDoubleForKey(kGeotificationLongitudeKey)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        radius = decoder.decodeDoubleForKey(kGeotificationRadiusKey)
        identifier = decoder.decodeObjectForKey(kGeotificationIdentifierKey) as! String
        note = decoder.decodeObjectForKey(kGeotificationNoteKey) as! String
        eventType = EventType(rawValue: decoder.decodeIntegerForKey(kGeotificationEventTypeKey))!
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeDouble(coordinate.latitude, forKey: kGeotificationLatitudeKey)
        coder.encodeDouble(coordinate.longitude, forKey: kGeotificationLongitudeKey)
        coder.encodeDouble(radius!, forKey: kGeotificationRadiusKey)
        coder.encodeObject(identifier, forKey: kGeotificationIdentifierKey)
        coder.encodeObject(note, forKey: kGeotificationNoteKey)
        coder.encodeInt(Int32(eventType!.rawValue), forKey: kGeotificationEventTypeKey)
    }
}
