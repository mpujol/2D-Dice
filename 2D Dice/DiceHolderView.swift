//
//  HolderView.swift
//  Dice
//
//  Created by Michael Pujol on 2/20/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import UIKit

class DiceHolderView: UIView {
    
    let ovalOutlineLayer = OvalOutlineLayer()
    let roundedRectLayer = RoundedRectLayer()
    let middlePip = MiddlePip()
    let leftPip = LeftPip()
    let rightPip = RightPip()
    let topLeftPip = TopLeftPip()
    let bottomLeftPip = BottomLeftPip()
    let topRightPip = TopRightPip()
    let bottomRightPip = BottomRightPip()
    
    var value: Int?
    
    var parentFrame: CGRect = CGRect.zero
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.value = 1
        backgroundColor = UIColor.clear
        
    }
    
    
    
    convenience init(withValue value: Int) {
        self.init()
        
        self.value = value
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func outlineOval() {
        layer.addSublayer(ovalOutlineLayer)
        ovalOutlineLayer.animateStrokeWithColor()
        
    
        Timer.scheduledTimer(timeInterval: ovalOutlineLayer.animationDuration,
                             target: self,
                             selector: #selector(DiceHolderView.addRoundedRect),
                             userInfo: nil, repeats: false)
    }
    
    @objc func addRoundedRect() {
        
        layer.addSublayer(roundedRectLayer)
        roundedRectLayer.expand()
        
        Timer.scheduledTimer(timeInterval: roundedRectLayer.animationDuration,
                             target: self,
                             selector: #selector(DiceHolderView.addNumberOfPips),
                             userInfo: nil,
                             repeats: false)
        
    }
    
    @objc func addNumberOfPips() {

        if let diceValue = self.value {

            print(diceValue)
            
            switch diceValue {
            case 1:
                layer.addSublayer(middlePip)
                middlePip.expand()
            case 2:
                layer.addSublayer(bottomLeftPip)
                bottomLeftPip.expand()
                layer.addSublayer(topRightPip)
                topRightPip.expand()
            case 3:
                layer.addSublayer(bottomLeftPip)
                bottomLeftPip.expand()
                layer.addSublayer(topRightPip)
                topRightPip.expand()
                layer.addSublayer(middlePip)
                middlePip.expand()
            case 4:
                layer.addSublayer(topLeftPip)
                topLeftPip.expand()
                layer.addSublayer(bottomLeftPip)
                bottomLeftPip.expand()
                layer.addSublayer(topRightPip)
                topRightPip.expand()
                layer.addSublayer(bottomRightPip)
                bottomRightPip.expand()
            case 5:
                layer.addSublayer(middlePip)
                middlePip.expand()
                layer.addSublayer(topLeftPip)
                topLeftPip.expand()
                layer.addSublayer(bottomLeftPip)
                bottomLeftPip.expand()
                layer.addSublayer(topRightPip)
                topRightPip.expand()
                layer.addSublayer(bottomRightPip)
                bottomRightPip.expand()
            case 6:
                layer.addSublayer(leftPip)
                leftPip.expand()
                layer.addSublayer(rightPip)
                rightPip.expand()
                layer.addSublayer(topLeftPip)
                topLeftPip.expand()
                layer.addSublayer(bottomLeftPip)
                bottomLeftPip.expand()
                layer.addSublayer(topRightPip)
                topRightPip.expand()
                layer.addSublayer(bottomRightPip)
                bottomRightPip.expand()
            default:
                break
            }
        }        
        
    }
    
}
