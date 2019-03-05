//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit

class PiTableViewCell: UITableViewCell {

    @IBOutlet weak var cpuName: UILabel!
    @IBOutlet weak var geoInfo: UILabel!
    @IBOutlet weak var cpuImage: UIImageView!
    @IBOutlet weak var gpuTemperature: UILabel!
    @IBOutlet weak var cpuTemperature: UILabel!
    @IBOutlet weak var memoryUsage: UILabel!
    @IBOutlet weak var diskUsage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
