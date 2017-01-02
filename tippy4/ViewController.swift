//
//  ViewController.swift
//  tippy4
//
//  Created by Vaidehi Duraphe on 12/22/16.
//  Copyright © 2016 Vaidehi Duraphe. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var plus: UILabel!
    @IBOutlet weak var equal: UILabel!

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var splitBill: UILabel!
    @IBOutlet weak var splitTotal: UILabel!
  
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        defaults.synchronize()
        billField.becomeFirstResponder()
        

        tipLabel.textColor = UIColor.white
        totalLabel.textColor = UIColor.white
        plus.textColor = UIColor.white
        equal.textColor = UIColor.white
        splitLabel.textColor = UIColor.white
        splitTotal.textColor = UIColor.white
        let bText = defaults.string(forKey: "text")
        billField.text = bText
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        let tipPer = defaults.integer(forKey: "tip")
        tipControl.selectedSegmentIndex = tipPer
        let bText = defaults.string(forKey: "text")
        billField.text = bText
        self.calcTip(self)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveText(_ sender: AnyObject) {
        defaults.set(billField.text, forKey: "text")
        defaults.synchronize()
    }

    @IBAction func calcTip(_ sender: AnyObject) {
        let tipPercentages = [0.10, 0.15, 0.20]
        let bill = Double(billField.text!) ?? 0
        var tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        var total = bill + tip
        let roundY = defaults.integer(forKey: "round")
        if roundY == 1
        {
            var newTotal = 0
            newTotal = Int((ceil(total)))
            tip = tip + (Double(newTotal) - total)
            total = Double(newTotal)
        }
        let people = defaults.double(forKey: "pick")
        let split = total/people
        splitBill.text = String(format: "$%.2f", split)
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        defaults.set(billField.text, forKey: "text")
        defaults.synchronize()
    
    }

}

