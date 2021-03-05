//
//  SettingsViewController.swift
//  Dice
//
//  Created by Michael Pujol on 2/23/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController {

    var model: DiceModel!
    
    @IBOutlet var fromLabel: UILabel!
    @IBOutlet var toLabel: UILabel!
    @IBOutlet var fromValueStepperOutlet: UIStepper!
    @IBOutlet var toValueStepperOutlet: UIStepper!
    
    @IBAction func fromValueStepper(_ sender: UIStepper) {
        
        if Int(sender.value) > model.maxValue {
            sender.value = Double(self.model.maxValue)
            return
        }
        
        model.minValue = Int(sender.value)
        fromLabel.text = "\(model.minValue)"
    }
    @IBAction func toValueStepper(_ sender: UIStepper) {
        
        if Int(sender.value) < model.minValue {
            sender.value = Double(self.model.minValue)
            return
        }
        model.maxValue = Int(sender.value)
        toLabel.text = "\(model.maxValue)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fromValueStepperOutlet.value = Double(model.minValue)
        toValueStepperOutlet.value = Double(model.maxValue)
        fromLabel.text = "\(model.minValue)"
        toLabel.text = "\(model.maxValue)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Segue
    
    @IBAction func dismissSettingsVC(_ sender: UISwipeGestureRecognizer) {
        self.navigationController!.popViewController(animated: true)
    }
}
