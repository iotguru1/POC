//
//  BLEDetailViewController.swift
//  ListBLEDevices
//
//  Created by Yogesh Ranjan on 5/25/15.
//  Copyright (c) 2015 KSYR. All rights reserved.
//

import UIKit

class BLEDetailViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var locationPicker: UIPickerView!
    
    @IBOutlet weak var signalStrengthPicker: UIPickerView!
    
    
    var locationPickerDataSource = ["Within 100m", "Between 100m - 200m", "Greater than 200m"]
    
    var signalStrengthDataSource = ["Weak", "Strong","Medium"]
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        self.locationPicker.dataSource = self
        self.locationPicker.delegate = self
        self.signalStrengthPicker.dataSource = self
        self.signalStrengthPicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == locationPicker) {
            return self.locationPickerDataSource.count
        } else {
            return self.signalStrengthDataSource.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (pickerView == locationPicker) {
            return self.locationPickerDataSource[row]
        } else {
            return self.signalStrengthDataSource[row]
        }
    }
    

}
