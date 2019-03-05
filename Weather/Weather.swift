//
//  TodayWeather.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit

class Weather: WeatherBase {
    //MARK: Properties
    var cityName: String?
    var cityImage: UIImage?
    var cityAvgTemperature: Double!
    var forecastWeathers: [ForecastWeather]?
    
    init?(cityName: String, cityImage: UIImage?, cityTemperature: Double, cityAvgTemperature: Double?, cityHumidity: Double, cityWeather: String, forecastWeathers: [ForecastWeather]) {
        super.init(cityTemperature: cityTemperature, cityHumidity: cityHumidity, cityWeather: cityWeather)
        self.cityName = cityName
        self.cityImage = cityImage
        self.cityAvgTemperature = cityAvgTemperature
        self.forecastWeathers = forecastWeathers
    }
}
