//
//  TodayWeather.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit

class Pi {
    //MARK: Properties
    //TODO: How to represent location
    var geoInfo: String
    var cpuUsage: Double
    var cpuTemperature: Double
    var memoryUsage: Double
    var diskUsage: Double
    var sensors = [Sensor]()
    
    init?(geoInfo: String, cpuUsage: Double, cpuTemperature: Double, memoryUsage: Double, diskUsage: Double) {
        
        guard cpuUsage > 0 && cpuUsage < 100 else {
            return nil
        }
        
        guard memoryUsage > 0 && memoryUsage < 100 else {
            return nil
        }
        
        guard diskUsage > 0 && diskUsage < 100 else {
            return nil
        }
        
        self.geoInfo = geoInfo
        self.cpuUsage = cpuUsage
        self.cpuTemperature = cpuTemperature
        self.memoryUsage = memoryUsage
        self.diskUsage = diskUsage
    }
}
