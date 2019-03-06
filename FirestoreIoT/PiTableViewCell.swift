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
    var action : (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func watchButton(_ sender: Any) {
        if let btnAction = self.action{
            btnAction()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
