//
//  Sensor.swift
//  FirestoreIoT
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit

class Sensor {
  //MARK: Properties
    var errorRate: Double
    var samplingRate: Double
    var sampledValue: Double
    var name: String
    
    
    init?(errorRate: Double, samplingRate: Double, sampledValue: Double, name: String) {
        
        guard samplingRate > 0 && samplingRate < 100 else {
            return nil
        }
        
        guard errorRate > 0 && errorRate < 100 else {
            return nil
        }
        
        self.errorRate = errorRate
        self.samplingRate = samplingRate
        self.sampledValue = sampledValue
        self.name = name
    }
}
