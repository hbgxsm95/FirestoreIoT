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
        loadSamplePis()

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
        
        let cellIdentifier = "PiTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PiTableViewCell  else {
            fatalError("The dequeued cell is not an instance of WeatherTableViewCell.")
        }
        
        let pi = pis[indexPath.row]
        
        // Configure the cell...
        cell.cpuImage.image = pi.cpuImage
        cell.cpuName.text = pi.name
        cell.geoInfo.text = pi.geoInfo
        cell.cpuTemperature.text = String(format:"%.1f °C", pi.cpuTemperature)
        cell.gpuTemperature.text = String(format:"%.1f °C", pi.gpuTemperature)
        cell.diskUsage.text = String(format:"%.1f ", pi.diskUsage) + "%"
        cell.memoryUsage.text = String(format:"%.1f ", pi.memoryUsage) + "%"
        
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
        
        
        
        guard let sensorTableViewController = segue.destination as? SensorTableViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedSensorCell = sender as? UIButton else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        guard let indexPath = tableView.indexPathForRow(at: selectedSensorCell.convert(CGPoint.zero, to: tableView)) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        sensorTableViewController.sensors = pis[indexPath.row].sensors
    }
    
    //MARK: Private Methods
    
    private func loadSamplePis() {
        let piImage = UIImage(named: "pi")
        let sensorImage = UIImage(named: "dht11")
        
        guard let sensor = Sensor(errorRate: 0.01, samplingRate: 30, sampledValue: 25, name: "Rogue", image: sensorImage) else {
            fatalError("Unable to instantiate Sensor DHT11")
        }
        
        guard let pi = Pi(name: "Iron", geoInfo: "San Francisco", cpuImage: piImage, gpuTemperature: 56, cpuTemperature: 65, memoryUsage: 24, diskUsage: 45) else {
            fatalError("Unable to instantiate Pi")
        }
        
        pi.sensors += [sensor]
        
        pis += [pi]
    }

}
