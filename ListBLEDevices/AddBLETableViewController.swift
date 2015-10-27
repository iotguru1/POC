//
//  AddBLETableViewController.swift
//  ListBLEDevices
//
//  Created by Yogesh Ranjan on 5/28/15.
//  Copyright (c) 2015 KSYR. All rights reserved.
//

import UIKit
import MapKit

class AddBLETableViewController: UITableViewController {

    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var bleName: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var bleDevice: BLEDevice!
    
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Bangalore location
        let initialLocation = CLLocation(latitude:12.93370, longitude:77.66220)
        centerMapOnLoation(initialLocation)
        
        let bleLocation = BLELocation(locationName: "Bellandur Lake", coordinate: CLLocationCoordinate2D(latitude:12.93370, longitude:77.66220))
        mapView.addAnnotation(bleLocation)
        mapView.delegate = self
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func centerMapOnLoation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }
    
    override func tableView (tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0) {
            bleName.becomeFirstResponder()
        }
     }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveBLE" {
            bleDevice = BLEDevice(name: bleName.text, id: 1)
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
