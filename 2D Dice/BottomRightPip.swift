//
//  BottomRightPip.swift
//  Dice
//
//  Created by Michael Pujol on 2/22/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import UIKit

class BottomRightPip: CAShapeLayer {
    
    //MARK: - Properties
    
    let animationDuration: CFTimeInterval = 0.3
    
    var ovalPathSmall: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: Constants.diceSize / 2,
                                           y: Constants.diceSize / 2,
                                           width: 0,
                                           height: 0))
    }
    
    var ovalPathFinal: UIBezierPath {
        
        let ovalSize = Constants.diceSize * Constants.diceSizeFactor
        let distanceToCenterOfCircle = ( (Constants.diceSize / 2) - (ovalSize / 2 ))
        let pipOffset = distanceToCenterOfCircle * Constants.dicePipOffsetFactor
        
        return UIBezierPath(ovalIn: CGRect(x: distanceToCenterOfCircle + pipOffset,
                                           y: distanceToCenterOfCircle + pipOffset,
                                           width: ovalSize,
                                           height: ovalSize))
    }
    
    
    //MARK: - Required methods
    
    override init() {
        super.init()
        
        fillColor = Constants.pipColor.cgColor
        path = ovalPathSmall.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Animation functions
    func expand() {
        
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        
        expandAnimation.fromValue = ovalPathSmall.cgPath
        expandAnimation.toValue = ovalPathFinal.cgPath
        expandAnimation.duration = animationDuration
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.isRemovedOnCompletion = false
        
        add(expandAnimation, forKey: nil)
    }
    
}
