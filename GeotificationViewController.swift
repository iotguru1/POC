//
//  GeotificationiewControllerViewController.swift
//  ListBLEDevices
//
//  Created by Yogesh Ranjan on 6/7/15.
//  Copyright (c) 2015 KSYR. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

let kSavedItemsKey = "savedItems"

class GeotificationViewController: UIViewController, AddGeotificationsViewControllerDelegate,MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var bleLocations = [BLELocation]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        //reset monitored regions
        for region in locationManager.monitoredRegions {
            if let circularRegion = region as? CLCircularRegion {
                locationManager.stopMonitoringForRegion(circularRegion)
            }
        }
        println("monitored regions>>>\(locationManager.monitoredRegions.count)")
        //locationManager.startUpdatingLocation()
        
        //set current location as the default region
        //let coordinate = mapView.userLocation.location?.coordinate
        //let region = MKCoordinateRegionMakeWithDistance(coordinate!, 100,100)
        //mapView.setRegion(region, animated:true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveAllGeotifications() {
        var items = NSMutableArray()
        for bleLocation in bleLocations {
            let item = NSKeyedArchiver.archivedDataWithRootObject(bleLocation)
            items.addObject(item)
        }
        NSUserDefaults.standardUserDefaults().setObject(items, forKey: kSavedItemsKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addGeotification") {
            let navigationViewController = segue.destinationViewController as! UINavigationController
            let addGeotificationViewController = navigationViewController.viewControllers.first as! AddGeotificationViewController
            addGeotificationViewController.delegate = self
        }
    }
    
    // MARK: Functions that update the model/associated views with geotification changes
    
    func addGeotification(bleLocation: BLELocation) {
        bleLocations.append(bleLocation)
        mapView.addAnnotation(bleLocation)
        //addRadiusOverlayForGeotification(bleLocation)
        updateGeotificationsCount()
        var radius = bleLocation.radius
        radius = (radius > locationManager.maximumRegionMonitoringDistance) ? locationManager.maximumRegionMonitoringDistance : radius
        bleLocation.radius = radius
        startMonitoringGeotification(bleLocation)
        saveAllGeotifications()
    }
    
    func updateGeotificationsCount() {
        title = "Geotifications (\(bleLocations.count))"
        navigationItem.rightBarButtonItem?.enabled = (bleDevices.count < 20)
    }
    
    func addGeotificationViewController(controller: AddGeotificationViewController, didAddCoordinate coordinate: CLLocationCoordinate2D, radius: Double, identifier: String, note: String, eventType: EventType) {
        //controller.dismissViewControllerAnimated(true, completion: nil)
        // Add geotification
        //let bleLocation = BLELocation(coordinate: coordinate, radius: radius, identifier: identifier, note: note, eventType: eventType)
        //addGeotification(bleLocation)
        //saveAllGeotifications()
    }
    
    func  mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView? {
        if let annotation = annotation as? BLELocation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            return view
        }
        return nil
    }
    
    @IBAction func zoomToCurrentLocation (sender:AnyObject) {
        zoomToUserLocationInMapView(mapView)
    }
    
    func zoomToUserLocationInMapView(mapView: MKMapView) {
        if let coordinate = mapView.userLocation.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 500000, 500000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func regionWithGeotification(bleLocation: BLELocation) -> CLCircularRegion {
        let  region = CLCircularRegion(center: bleLocation.coordinate, radius: bleLocation.radius!, identifier: bleLocation.identifier)
        //region.notifyOnEntry = (bleLocation.eventType == .OnEntry)
        //region.notifyOnExit = !region.notifyOnEntry
        region.notifyOnExit = true
        region.notifyOnEntry = true
        return region
    }
    
    func startMonitoringGeotification(bleLocation: BLELocation) {
        if (!CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion)) {
            showSimpleAlertWithTitle("Error", message: "Geofencing is not supported!", viewController: self)
            return
        }
        
        let region = regionWithGeotification(bleLocation)
        println(region.radius)
        println(region.notifyOnEntry)
        println(region.notifyOnExit)
        locationManager.startMonitoringForRegion(region)
        println("started monitoring ....")
    }
    
    func stopMonitoringGeotification (bleLocation: BLELocation) {
        for region in locationManager.monitoredRegions {
            if let circularRegion = region as? CLCircularRegion {
                if circularRegion.identifier == bleLocation.identifier {
                    locationManager.stopMonitoringForRegion(circularRegion)
                }
            }
        }
        println("stopped monitoring....")
    }
    
    func showSimpleAlertWithTitle(title: String!, #message: String, #viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(action)
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        var bleLocation = view.annotation as! BLELocation
        stopMonitoringGeotification(bleLocation)
        var index = find(bleLocations, bleLocation)
        bleLocations.removeAtIndex(index!)
        saveAllGeotifications()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Location Mananger failed with error...")
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        println("Monitoring failed for region with identifier..."+error.description)
    }
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        println("Monitoring Strated ..........")
    }
    
    func handleRegionEvent (region: CLRegion) {
        println("Geo fencing triggered...")
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("enter BLE region...")
        if region is CLCircularRegion {
            handleRegionEvent(region)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        println("Exit BLE region...")
        if region is CLCircularRegion {
            handleRegionEvent(region)
        }
    }

}
