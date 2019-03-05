//
//  Weather.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit

class WeatherBase {
    
    //MARK: Properties
    var cityTemperature: Double
    var cityHumidity: Double
    var cityWeather: String
    
    init?(cityTemperature: Double, cityHumidity: Double, cityWeather: String) {
        guard !cityWeather.isEmpty else {
            return nil
        }
        
        guard cityHumidity > 0 else {
            return nil
        }
        
        self.cityTemperature = cityTemperature
        self.cityHumidity = cityHumidity
        self.cityWeather = cityWeather
    }
}
