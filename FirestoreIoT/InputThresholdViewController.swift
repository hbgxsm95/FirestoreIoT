//
//  InputThresholdViewController.swift
//  FirestoreIoT
//
//  Created by Peiqin Zhao on 3/11/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit

class InputThresholdViewController: UIViewController, UITextFieldDelegate {
    var threshold: Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        thresholdTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var thresholdTextField: UITextField!
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        thresholdTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            print("Error with segue")
            return
        }
        if let result = Double(thresholdTextField.text!){
            self.threshold = result
        } else{
            print("Invalid Input")
        }
    }
    

}
