//
//  SettingsViewController.swift
//  tippy4
//
//  Created by Vaidehi Duraphe on 12/23/16.
//  Copyright © 2016 Vaidehi Duraphe. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var tipSettings: UISegmentedControl!
   
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var roundUp: UISwitch!
    
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input data into the Array:
       pickerData = ["1 person", "2 people", "3 people", "4 people", "5 people"]
        
        // Do any additional setup after loading the view.
        roundLabel.textColor = UIColor.white
        defaultLabel.textColor = UIColor.white
    }
    override func viewWillAppear(_ animated: Bool) {
        let tipPer = defaults.integer(forKey: "tip")
        
        tipSettings.selectedSegmentIndex = tipPer
        let roundY = defaults.integer(forKey: "round")
        if roundY == 1
        {
            roundUp.setOn(true, animated: true)
        }

        let people = defaults.integer(forKey: "pick")
        picker.selectRow(people-1, inComponent: 0, animated: true)
    }
    
    @IBAction func round(_ sender: AnyObject) {
        if roundUp.isOn
        {
            defaults.set(1, forKey: "round")
            defaults.synchronize()
        }
        else
        {
            defaults.set(0, forKey: "round")
            defaults.synchronize()
        }
    }
    @IBAction func selectDef(_ sender: AnyObject) {
        defaults.set(tipSettings.selectedSegmentIndex, forKey: "tip")
        defaults.synchronize()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        defaults.set(row + 1, forKey: "pick")
        defaults.synchronize()
    }
    
    
    //make white
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
        return myTitle
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
