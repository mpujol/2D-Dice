//
//  RootViewController.swift
//  2D Dice
//
//  Created by Michael Pujol on 2/27/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    //MARK: Properties
    
    let defaults = UserDefaults.standard
    
    var animator: UIDynamicAnimator? = nil
    let gravity = UIGravityBehavior()
    let collision = UICollisionBehavior()
    let dynamic = UIDynamicItemBehavior()
    let push = UIPushBehavior()
    
    var onBoardingFinished: Bool = false
    
    @IBOutlet var infoButtonOutlet: UIBarButtonItem!
    
    var model = DiceModel(minValue: 1, maxValue: 6)
    
    var diceSubviews = [DiceHolderView]() {
        didSet {
            
            updateLabels()
            
        }
    }
    
    @IBOutlet var totalCountLabel: UILabel!
    @IBOutlet var countStack: UIStackView!
    @IBOutlet var infoStack: UIStackView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    
    //MARK: - VLC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDynamicAnimator()
        setupInfoView()
        if UserDefaults.standard.bool(forKey: "FinishedOnBoarding") == false {
            onBoardingFinished = false
            infoButtonOutlet.isEnabled = false
        } else {
            onBoardingFinished = true
//            self.infoStack.alpha = 0
            self.infoView.alpha = 0
            self.infoButtonOutlet.isEnabled = true
        }
    }
    
    //MARK: - Helper Functions
    
    func addDice(location: CGRect) {
        
        let newHolderView = DiceHolderView(frame: location)
        
        newHolderView.value = model.createRandomNumber()
        
        newHolderView.parentFrame = view.frame
        
        view.addSubview(newHolderView)
        view.sendSubviewToBack(newHolderView)
        diceSubviews.append(newHolderView)
        newHolderView.outlineOval()
        self.addDynamicBehaviors(to: newHolderView)
    }
    
    fileprivate func updateLabels() {
        // Calculates the dice total
        var totalValue = 0
        
        for dice in diceSubviews {
            totalValue += dice.value!
        }
        
        if !onBoardingFinished {
            let informationSequence = diceSubviews.count
            switch informationSequence {
            case 0:
                infoLabel.text = "And that's all you need to know. \n Have fun!"
                onBoardingFinished = true
                
                UserDefaults.standard.set(true, forKey: "FinishedOnBoarding")
                
            case 1:
                infoLabel.text = "Cool! \n Roll Again"
            case 2:
                infoLabel.text = "One more time!"
            case 3:
                infoLabel.text = "Nice! \n  Last one for good luck"
            case 4...10:
                infoLabel.text = "Good job!!! \n Swipe down to clear the screen"
            case 11...20:
                infoLabel.text = "Ummm... what are you doing?"
            case 21...30:
                infoLabel.text = "SWIPE DOWN!?"
            case 31...40:
                infoLabel.text = "Are you trying to break the app?"
            case 41...50:
                infoLabel.text = "Ok.. I'm pretty sure you're just fooling around"
            case 51...60:
                infoLabel.text = "It's not gonna break"
            case 61...70:
                infoLabel.text = "Look at all the fingerprints on your screen."
            case 71...80:
                infoLabel.text = "C'mon.. man!"
            case 81...99:
                infoLabel.text = "SWIPE DOWN THE TUTORIAL IS OVER"
            case 100:
                infoLabel.text = "Congrats on 100 dice on screen. -_-"
            case 110:
                infoLabel.text = "Real Talk. \n This is the last message. Swipe down."
            default:
                break
            }
        } else {
            UIView.animate(withDuration: 1.0, animations: {
                self.infoView.alpha = 0
                self.infoButtonOutlet.isEnabled = true
            })
        }
        
        //Animates the total
        Timer.scheduledTimer(withTimeInterval: 1.25, repeats: false) { (timer) in
            
            if self.diceSubviews.count > 0 {
                
                self.countStack.alpha = 1
                self.totalCountLabel.text = "\(totalValue)"
                
            }
        }
    }
    
    func setupInfoView() {
        infoView.backgroundColor = .secondarySystemBackground
        infoView.layer.cornerRadius = infoLabel.frame.height / 2
    }
    
    //MARK: - Actions
    
    @IBAction func addDiceTapped(_ sender: UITapGestureRecognizer) {
        
        addDice(location: CGRect(x: sender.location(in: view).x - Constants.diceSize / 2,
                                 y: sender.location(in: view).y - Constants.diceSize / 2,
                                 width: Constants.diceSize,
                                 height: Constants.diceSize))
        
    }
    
    @IBAction func removeDice(_ sender: AnyObject) {
        
        for dice in diceSubviews {
            
            collision.removeItem(dice)
            
            UIView.animate(withDuration: 1.0, animations: {
                self.countStack.alpha = 0
            })
            
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (timer) in
                self.removeDynamicBehaviors(to: dice)
                dice.removeFromSuperview()
                
            })
            
        }
        diceSubviews.removeAll()
        
        
    }
    
    @IBAction func startTutorial(_ sender: UIBarButtonItem) {
        
        removeDice(sender)
        infoLabel.text = "TAP anywhere to roll dice"
        
        UIView.animate(withDuration: 1.25) {
            self.infoView.alpha = 0.9
            self.infoButtonOutlet.isEnabled = false
        }
        onBoardingFinished = false
    }
    
    @IBAction func showSettings(_ sender: AnyObject) {
        performSegue(withIdentifier: "showSettings", sender: sender)
    }
    
    //MARK: - Animator functions
    
    func addDynamicBehaviors(to view: DiceHolderView) {
        
        gravity.addItem(view)
        collision.addItem(view)
        push.addItem(view)
        dynamic.addItem(view)
        
        animator?.addBehavior(gravity)
        animator?.addBehavior(collision)
        animator?.addBehavior(dynamic)
        animator?.addBehavior(push)
    }
    
    func removeDynamicBehaviors(to view: DiceHolderView) {
        
        gravity.removeItem(view)
        collision.removeItem(view)
        push.removeItem(view)
        dynamic.removeItem(view)
        
    }
    
    func setupDynamicAnimator() {
        
        // initialize animator
        animator = UIDynamicAnimator(referenceView: self.view)
        
        //Configure behavior
        push.active = true
        //        push.setAngle(CGFloat(-M_PI_2), magnitude: 1.0)
        gravity.magnitude = 0.5
        dynamic.elasticity = 1
        collision.translatesReferenceBoundsIntoBoundary = true
        
        
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "showSettings"?:
            
            let destinationVC = segue.destination as! SettingsViewController
            destinationVC.model = self.model
        case "showTutorial"?:
            break
        default:
            preconditionFailure("Segue Identifier is invalid")
        }
        
    }
}
