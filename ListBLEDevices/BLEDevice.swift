//
//  BLEDevice.swift
//  ListBLEDevices
//
//  Created by Yogesh Ranjan on 5/17/15.
//  Copyright (c) 2015 KSYR. All rights reserved.
//

import Foundation

public class BLEDevice:NSObject {
    
    var name: String? = nil
    var id: Int? = nil
    
    init(name: String, id: Int) {
        self.name = name;
        self.id = id;
        super.init()
    }
    
}



