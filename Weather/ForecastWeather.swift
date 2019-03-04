//
//  ForecaseWeather.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit
class ForecastWeather: Weather {
    //MARK: Properties
    var date: String!
    
    init?(date: String, cityName: String, cityTemperature: Double, cityHumidity: Double, cityWeather: String) {
        
        super.init(cityName: cityName, cityTemperature: cityTemperature, cityHumidity: cityHumidity, cityWeather: cityWeather)
        
        guard !date.isEmpty else {
            return nil
        }
        self.date = date
    }
}
