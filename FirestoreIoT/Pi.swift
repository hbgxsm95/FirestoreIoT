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
    var name: String
    //TODO: How to represent location
    var geoInfo: String
    var cpuImage: UIImage?
    var gpuTemperature: Double
    var cpuTemperature: Double
    var memoryUsage: Double
    var diskUsage: Double
    var sensors = [Sensor]()
    
    init?(name: String, geoInfo: String, cpuImage: UIImage?, gpuTemperature: Double, cpuTemperature: Double, memoryUsage: Double, diskUsage: Double) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        guard !geoInfo.isEmpty else {
            return nil
        }
        
        guard memoryUsage > 0 && memoryUsage < 100 else {
            return nil
        }
        
        guard diskUsage > 0 && diskUsage < 100 else {
            return nil
        }
        
        self.name = name
        self.geoInfo = geoInfo
        self.cpuImage = cpuImage
        self.gpuTemperature = gpuTemperature
        self.cpuTemperature = cpuTemperature
        self.memoryUsage = memoryUsage
        self.diskUsage = diskUsage
        
    }
}
