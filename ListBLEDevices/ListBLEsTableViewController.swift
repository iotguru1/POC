//
//  ListBLEsTableViewController.swift
//  ListBLEDevices
//
//  Created by Yogesh Ranjan on 5/17/15.
//  Copyright (c) 2015 KSYR. All rights reserved.
//

import UIKit

class ListBLEsTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var BLEDevices = [BLEDevice]()
    
    var fileteredBLEDevices = [BLEDevice]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.BLEDevices = bleDevices
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.fileteredBLEDevices.count
        } else {
            return self.BLEDevices.count
        }
    }
    
//    override func tableView (tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("bleDetail", sender: tableView)
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "bleDetail" {
            let bleDetailViewController = segue.destinationViewController as! BLEDetailViewController
//            if sender as! UITableView == self.searchDisplayController!.searchResultsTableView {
//                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()
//                bleDetailViewController.title = (self.fileteredBLEDevices[indexPath!.row] as BLEDevice).name
//            } else {
                let indexPath = self.tableView!.indexPathForSelectedRow()
                let bleName  = (self.BLEDevices[indexPath!.row] as BLEDevice).name
            bleDetailViewController.title = bleName
            bleDetailViewController.detailItem = bleName
//            }
            
            //let className = reflect(sender)
            
            //let cell = sender as! ListBLEDevices.BLECell
            //bleDetailViewController.title = cell.nameLabel.text
//            if segue.identifier == "showDetail" {
//                if let indexPath = self.tableView.indexPathForSelectedRow() {
//                    let object = objects[indexPath.row] as! NSDate
//                    (segue.destinationViewController as! DetailViewController).detailItem = object
//                }
//            }
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("BLECell", forIndexPath: indexPath) as! BLECell
        var bleDevice: BLEDevice
        if tableView == self.searchDisplayController!.searchResultsTableView {
            bleDevice = self.fileteredBLEDevices[indexPath.row] as BLEDevice
        } else {
            bleDevice = self.BLEDevices[indexPath.row] as BLEDevice
        }
        
        
        
//        if let nameLabel = cell.viewWithTag(100) as? UILabel {
//            nameLabel.text = bleDevice.name
//        }
//        
//        if let idLabel = cell.viewWithTag(101) as? UILabel {
//            idLabel.text = String(stringInterpolationSegmeSnt: bleDevice.id!)
//            idLabel.textColor = UIColor.redColor()
//        }
//        
//        if let bleImage = cell.viewWithTag(102) as? UIImageView {
//            bleImage.image = getImageForDevice(bleDevice.id!)
//        }
        
        cell.nameLabel.text = bleDevice.name
        cell.idLabel.text = String(bleDevice.id!)
        cell.idLabel.textColor = UIColor.redColor()
        cell.bleImage.image = getImageForDevice(bleDevice.id!)
        
        return cell
    }
    
    func getImageForDevice(id: Int) -> UIImage? {
        switch id {
        case 1:
            return UIImage(named: "iPhone")
        case 2:
            return UIImage(named: "CSR")
        default:
            return nil
        }
    }
    
    func filterBLEDevices(searchString: String) {
        self.fileteredBLEDevices = self.BLEDevices.filter({
            (bleDevice: BLEDevice) -> Bool in
            let strMatch = bleDevice.name?.lowercaseString.rangeOfString(searchString.lowercaseString)
            return (strMatch != nil)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterBLEDevices(searchString)
        return true
    }
    
    @IBAction func cancelAddBLE(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func saveBLE (segue: UIStoryboardSegue) {
        if let addBLEViewController = segue.sourceViewController as? AddBLETableViewController {
            BLEDevices.append(addBLEViewController.bleDevice)
            
            let indexPath = NSIndexPath(forRow: BLEDevices.count - 1, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    


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
