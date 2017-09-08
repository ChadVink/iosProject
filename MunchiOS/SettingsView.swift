//
//  SettingsView.swift
//  MunchiOS
//
//  Created by Eli Simmonds on 9/7/17.
//  Copyright © 2017 Eli Simmonds. All rights reserved.
//

import Foundation
import UIKit

class SettingsView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var priceControl: UISegmentedControl!
    @IBOutlet weak var typePicker: UIPickerView!
    
    var pickerDataSource = ["Lunch", "Dinner", "Breakfast", "Bars", "Happy Hour"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.typePicker.delegate = self
        self.typePicker.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    @IBAction func distanceChange(_ sender: Any) {
        print(distanceSlider.value)
    }
    @IBAction func priceControlChange(_ sender: Any) {
        print(priceControl.selectedSegmentIndex)
    }
    
}
