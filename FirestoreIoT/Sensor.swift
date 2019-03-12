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
    var samplingRate: Int
    var sampledValue: Double
    var model: String
    var image: UIImage?
    var name: String
    
    
    init?(errorRate: Double, samplingRate: Int, sampledValue: Double, model: String, image: UIImage?, name: String) {
        
        guard samplingRate > 0 && samplingRate < 100 else {
            return nil
        }
        
        guard errorRate > 0 && errorRate < 100 else {
            return nil
        }
        
        guard !model.isEmpty else {
            return nil
        }
        
        guard !name.isEmpty else{
            return nil
        }
        
        self.errorRate = errorRate
        self.samplingRate = samplingRate
        self.sampledValue = sampledValue
        self.model = model
        self.image = image
        self.name = name
    }
}
