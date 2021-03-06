//
//  ForecastTableViewController.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import os.log
import FirebaseUI

class SensorTableViewController: UITableViewController {
    
    //MARK: Properties
    var masterId: String?
    var sensors = [Sensor]()
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToSensorList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? FiltersViewController, let model = sourceViewController.model.text, let sortBy = sourceViewController.sortByTextField.text {
            //Mark:
            //TODO: Update the result
            // Clear the table view firstly.
            sensors.removeAll()
            self.tableView.reloadData()
            
            // Update the table view
            let db = Firestore.firestore()
            var query = db.collection("sensor").whereField("masterId", isEqualTo: self.masterId)
            if model != "ALL"{
                query = query.whereField("model", isEqualTo: model).order(by: sortBy)
            } else if !sortBy.isEmpty {
                query = query.order(by: sortBy)
            }
            // Whether I need to build index here?
            query.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        // Load all the sensors
                        let fetchedData = document.data()
                        let name = document.documentID
                        let model = fetchedData["model"] as? String ?? ""
                        let errorRate = fetchedData["errorRate"] as? Double ?? 0.0
                        let samplingRate = fetchedData["samplingRate"] as? Int ?? 0
                        let sampledValue = fetchedData["sampledValue"] as? Double ?? 0.0
                        let sensorImage = UIImage(named: model)
                        guard let sensor = Sensor(errorRate: errorRate, samplingRate: samplingRate, sampledValue: sampledValue, model: model, image: sensorImage, name: name) else {
                            fatalError("Unable to instantiate Sensor")
                        }
                        // Add a new sensor.
                        let newIndexPath = IndexPath(row: self.sensors.count, section: 0)
                        self.sensors.append(sensor)
                        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                    }
                }
            }
        }
        
        if let sourceViewController = sender.source as? InputThresholdViewController, let threshold = sourceViewController.threshold {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                // TODO
                print(selectedIndexPath.row)
                print(threshold)
                let db = Firestore.firestore()
                let docRef = db.collection("sensor").document(sensors[selectedIndexPath.row].name)
                docRef.updateData(["threshold" : threshold]){
                    err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else{
                        //
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadInitSensor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        return sensors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "SensorTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SensorTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ForecastTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let sensor = sensors[indexPath.row]
        
        cell.name.text = sensor.model
        cell.errorRate.text = String(format:"%.2f ", sensor.errorRate) + "%"
        cell.sampledValue.text = String(format:"%.1f °C", sensor.sampledValue)
        cell.samplingRate.text = String(format:"%d QPS", sensor.samplingRate)
        cell.sensorImage.image = sensor.image
        
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
    }
    
    //Mark: private function
    private func loadInitSensor(){
        let db = Firestore.firestore()
        //var ref: DocumentReference? = nil
        db.collection("sensor").whereField("masterId", isEqualTo: self.masterId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    // Load all the sensors
                    let fetchedData = document.data()
                    let docId = document.documentID
                    let name = fetchedData["model"] as? String ?? ""
                    let errorRate = fetchedData["errorRate"] as? Double ?? 0.0
                    let samplingRate = fetchedData["samplingRate"] as? Int ?? 0
                    let sampledValue = fetchedData["sampledValue"] as? Double ?? 0.0
                    let sensorImage = UIImage(named: name)
                    guard let sensor = Sensor(errorRate: errorRate, samplingRate: samplingRate, sampledValue: sampledValue, model: name, image: sensorImage, name: docId) else {
                        fatalError("Unable to instantiate Sensor")
                    }
                    // Add a new sensor.
                    let newIndexPath = IndexPath(row: self.sensors.count, section: 0)
                    self.sensors.append(sensor)
                    self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
    }

}
