//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit

class PiTableViewController: UITableViewController {
    
    //MARK: Properties
    var pis = [Pi]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleWeathers()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pis.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "WeatherTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PiTableViewCell  else {
            fatalError("The dequeued cell is not an instance of WeatherTableViewCell.")
        }
        
        let weather = pis[indexPath.row]
        
        // Configure the cell...
        cell.cityName.text = weather.cityName
        cell.cityImage.image = weather.cityImage
        cell.cityTemperature.text = String(format:"%.1f °C", weather.cityTemperature)
        cell.cityAvgTemperature.text = String(format:"%.1f °C", weather.cityAvgTemperature)
        cell.cityHumidity.text = String(format:"%.1f ", weather.cityHumidity) + "%"
        cell.cityWeather.text = weather.cityWeather
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        
        
        guard let forecastTableViewController = segue.destination as? SensorTableViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedCityCell = sender as? UIButton else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        guard let indexPath = tableView.indexPathForRow(at: selectedCityCell.convert(CGPoint.zero, to: tableView)) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        
        
        guard let selectedCityWeather = pis[indexPath.row].forecastWeathers else { return }
        forecastTableViewController.weathers = selectedCityWeather
    }
    
    //MARK: Private Methods
    
    private func loadSampleWeathers() {
        let SFImage = UIImage(named: "SF")
        
        var forecastWeathers = [ForecastWeather]()
        guard let forecastWeather = ForecastWeather(date: "2019-03-04", cityTemperature: 23.01, cityHumidity: 41.3, cityWeather: "Rainy") else {
            fatalError("Unable to instantiate meal1")
        }
        forecastWeathers += [forecastWeather]
        
        guard let SFWeather = Pi(cityName: "San Francisco", cityImage: SFImage, cityTemperature: 20.7, cityAvgTemperature: 21.3, cityHumidity: 43, cityWeather: "Cloudy", forecastWeathers: forecastWeathers) else {
            fatalError("Unable to instantiate sf weather")
        }
        
        pis += [SFWeather]
    }

}
