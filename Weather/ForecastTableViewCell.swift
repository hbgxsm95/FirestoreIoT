//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var dateImage: UIImageView!
    @IBOutlet weak var cityWeather: UILabel!
    @IBOutlet weak var cityTemperature: UILabel!
    @IBOutlet weak var cityHumidity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
