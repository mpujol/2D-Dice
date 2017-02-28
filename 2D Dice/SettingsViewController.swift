//
//  SettingsViewController.swift
//  Dice
//
//  Created by Michael Pujol on 2/23/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {

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
        
        print(model.minValue)
        
    }
    @IBAction func toValueStepper(_ sender: UIStepper) {
        
        if Int(sender.value) < model.minValue {
            sender.value = Double(self.model.minValue)
            return
        }
        
        model.maxValue = Int(sender.value)
        toLabel.text = "\(model.maxValue)"
        
        print(model.maxValue)
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
        print("Swipe Recognized")
    
    }


    //MARK: - Email Methods
    
    @IBAction func sendEmailButtonTapped(_ sender: UIButton) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["mike.pujol88@gmail.com"])
        mailComposerVC.setSubject("2D-Dice Feedback")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        
        
        let sendMailErrorAlertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. please check e-mail configuration and try again", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        sendMailErrorAlertController.addAction(okAction)
        
        self.present(sendMailErrorAlertController, animated: true, completion: nil)
        
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }


}
