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
            
            // Calculates the dice total
            var totalValue = 0
            
            for dice in diceSubviews {
                totalValue += dice.value!
            }
            
            if !onBoardingFinished {
                
                let informationSequence = diceSubviews.count
                
                switch informationSequence {
                case 0:
                    infoLabel.text = "If you wanna go though the guide again, tap the help icon on the upper left. \n Enjoy your game!"
                    onBoardingFinished = true
                    UserDefaults.standard.set(true, forKey: "FinishedOnBoarding")
                    
                case 1:
                    infoLabel.text = "Cool! \n Roll Again"
                case 2:
                    infoLabel.text = "Again"
                case 3:
                    infoLabel.text = "Nice! \n  Roll 1 more"
                case 4:
                    infoLabel.text = " Goodjob!!! \n swipe down to clear the screen"
                default:
                    break
                }
                
            } else {
                UIView.animate(withDuration: 1.25, animations: { 
                    self.infoStack.alpha = 0
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
    }
    
    @IBOutlet var totalCountLabel: UILabel!
    @IBOutlet var countStack: UIStackView!
    @IBOutlet var infoStack: UIStackView!
    @IBOutlet var infoLabel: UILabel!
    
    //MARK: - VLC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserDefaults.standard.bool(forKey: "FinishedOnBoarding"))
        
        if UserDefaults.standard.bool(forKey: "FinishedOnBoarding") == false {
            
            onBoardingFinished = false
            
            
        } else {
            
            onBoardingFinished = true
            self.infoStack.alpha = 0
            self.infoButtonOutlet.isEnabled = true
            
        }
        
        
        
        setupDynamicAnimator()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(model.minValue)
        print(model.maxValue)
    }
    
    //MARK: - Helper Functions
    
    func addDice(location: CGRect) {
        
        let newHolderView = DiceHolderView(frame: location)
        
        newHolderView.value = model.createRandomNumber()
        
        newHolderView.parentFrame = view.frame
        
        view.addSubview(newHolderView)
        diceSubviews.append(newHolderView)
        newHolderView.outlineOval()
        self.addDynamicBehaviors(to: newHolderView)
        
        self.view.bringSubview(toFront: countStack)
        self.view.bringSubview(toFront: infoStack)
        
        
        
        //        print("There are \(view.subviews.count) subviews in the view")
        
        
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
            self.infoStack.alpha = 1
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
