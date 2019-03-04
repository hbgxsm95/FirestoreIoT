//
//  TodayWeather.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit

class TodayWeather: Weather {
    //MARK: Properties
    var cityImage: UIImage?
    var cityAvgTemperature: Double!
    
    init?(cityName: String, cityImage: UIImage?, cityTemperature: Double, cityAvgTemperature: Double?, cityHumidity: Double, cityWeather: String) {
        super.init(cityName: cityName, cityTemperature: cityTemperature, cityHumidity: cityHumidity, cityWeather: cityWeather)
        self.cityImage = cityImage
        self.cityAvgTemperature = cityAvgTemperature
    }
}
