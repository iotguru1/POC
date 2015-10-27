//
//  AddGeonotificationViewController.swift
//  ListBLEDevices
//
//  Created by Yogesh Ranjan on 6/7/15.
//  Copyright (c) 2015 KSYR. All rights reserved.
//

import UIKit
import MapKit

class AddGeotificationViewController: UITableViewController {

    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var entryType: UISegmentedControl!
    @IBOutlet weak var latitudeText: UITextField!
    @IBOutlet weak var longitudeText: UITextField!
    
    var delegate: AddGeotificationsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //this makes the unused row of the table view to disappear
        tableView.tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    
    
    @IBAction func cancelAddGeotification(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addNewGeotification(sender: AnyObject) {
        var latitude = (latitudeText.text as NSString).doubleValue
        var longitude = (longitudeText.text as NSString).doubleValue
        var coordinate = CLLocationCoordinate2D(latitude:latitude, longitude:longitude)//mapView.centerCoordinate
        var radius = (radiusTextField.text as NSString).doubleValue
        var identifier = NSUUID().UUIDString
        var note = notesTextField.text
        var eventType = (entryType.selectedSegmentIndex == 0) ? EventType.OnEntry : EventType.OnExit
        dismissViewControllerAnimated(true, completion: nil)
        // Add geotification
        let bleLocation = BLELocation(coordinate: coordinate, radius: radius, identifier: identifier, note: note, eventType: eventType)
        
        delegate!.addGeotification(bleLocation)
        
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
