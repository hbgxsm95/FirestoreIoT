//
//  Copyright (c) 2016 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

class FiltersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    weak var delegate: FiltersViewControllerDelegate?
    
    static func fromStoryboard(delegate: FiltersViewControllerDelegate? = nil) ->
        (navigationController: UINavigationController, filtersController: FiltersViewController) {
            let navController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "FiltersViewController")
                as! UINavigationController
            let controller = navController.viewControllers[0] as! FiltersViewController
            controller.delegate = delegate
            return (navigationController: navController, filtersController: controller)
    }
    
    @IBOutlet var model: UITextField! {
        didSet {
            model.inputView = typePickerView
        }
    }
    @IBOutlet var sortByTextField: UITextField! {
        didSet {
            sortByTextField.inputView = sortByPickerView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Blue bar with white color
        navigationController?.navigationBar.barTintColor =
            UIColor(red: 0x3d/0xff, green: 0x5a/0xff, blue: 0xfe/0xff, alpha: 1.0)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes =
            [ kCTForegroundColorAttributeName: UIColor.white ] as [NSAttributedStringKey : Any]
    }
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        delegate?.controller(self, didSelectCategory: model.text,
                             sortBy: sortByTextField.text)
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func clearFilters() {
        model.text = ""
        sortByTextField.text = ""
    }
    
    private lazy var sortByPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    private lazy var typePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    private let sortByOptions = ["samplingRate", "errorRate", "sampledValue"]
    private let modelOptions = ["Rogue", "Wayne", "Sunny", "All"]
    
    // MARK: UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case sortByPickerView:
            return sortByOptions.count
        case typePickerView:
            return modelOptions.count
            
        case _:
            fatalError("Unhandled picker view: \(pickerView)")
        }
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent: Int) -> String? {
        switch pickerView {
        case sortByPickerView:
            return sortByOptions[row]
        case typePickerView:
            return modelOptions[row]
            
        case _:
            fatalError("Unhandled picker view: \(pickerView)")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case sortByPickerView:
            sortByTextField.text = sortByOptions[row]
        case typePickerView:
            model.text = modelOptions[row]
        case _:
            fatalError("Unhandled picker view: \(pickerView)")
        }
    }
    
}

protocol FiltersViewControllerDelegate: NSObjectProtocol {
    
    func controller(_ controller: FiltersViewController,
                    didSelectCategory type: String?, sortBy: String?)
    
}
