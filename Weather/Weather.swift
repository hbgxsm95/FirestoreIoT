//
//  Weather.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit

class Weather {
    
    //MARK: Properties
    var cityName: String
    var cityTemperature: Double
    var cityHumidity: Double
    var cityWeather: String
    
    init?(cityName: String, cityTemperature: Double, cityHumidity: Double, cityWeather: String) {
        
        guard !cityName.isEmpty else {
            return nil
        }
        
        guard !cityWeather.isEmpty else {
            return nil
        }
        
        guard cityHumidity > 0 else {
            return nil
        }
        
        self.cityName = cityName
        self.cityTemperature = cityTemperature
        self.cityHumidity = cityHumidity
        self.cityWeather = cityWeather
    }
}
