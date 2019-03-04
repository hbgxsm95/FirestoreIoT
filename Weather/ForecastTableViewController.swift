//
//  ForecastTableViewController.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit

class ForecastTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var weathers = [ForecastWeather]()
    
    let dayOfWeek = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSampleWeathers()
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weathers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ForecastTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ForecastTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ForecastTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let weather = weathers[indexPath.row]
        
        cell.forecastDate.text = weather.date
        cell.dateImage.image = UIImage(named: dayOfWeek[getDayOfWeek(weather.date)! - 1])
        cell.cityWeather.text = weather.cityWeather
        cell.cityTemperature.text = String(format:"%.1f °C", weather.cityTemperature)
        cell.cityHumidity.text = String(format:"%.1f °C", weather.cityHumidity)
        return cell
    }
    
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func loadSampleWeathers() {
        
        guard let weather = ForecastWeather(date: "2019-03-04", cityName: "San Francisco", cityTemperature: 23.01, cityHumidity: 41.3, cityWeather: "Rainy") else {
            fatalError("Unable to instantiate meal1")
        }
        
        weathers += [weather]
    }

}
