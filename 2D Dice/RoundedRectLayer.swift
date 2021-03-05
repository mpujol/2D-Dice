//
//  RoundedRectLayer.swift
//  Dice
//
//  Created by Michael Pujol on 2/21/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import UIKit

class RoundedRectLayer: CAShapeLayer {

    //MARK: - Properties
    
    let animationDuration: CFTimeInterval = 0.5
    
    var roundedRectSmall: UIBezierPath {
        
        let rect = CGRect(x: Constants.diceSize / 2,
                          y: Constants.diceSize / 2,
                          width: 0,
                          height: 0)
        
        return UIBezierPath(roundedRect: rect, cornerRadius: Constants.diceCornerRadius)
    }
    
    var roundedRectBig: UIBezierPath {
        
        let rect = CGRect(x: 0,
                          y: 0,
                          width: Constants.diceSize,
                          height: Constants.diceSize)
        
        return UIBezierPath(roundedRect: rect, cornerRadius: Constants.diceCornerRadius)
    }
    
    //MARK: - Required methods
    
    override init() {
        super.init()
        
        fillColor = Constants.primaryColor.cgColor
        path = roundedRectSmall.cgPath
        lineWidth = 2.0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Animation Functions
    
    func expand() {
        
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        
        expandAnimation.fromValue = roundedRectSmall.cgPath
        expandAnimation.toValue = roundedRectBig.cgPath
        expandAnimation.fillMode = .forwards
        expandAnimation.duration = animationDuration
        expandAnimation.isRemovedOnCompletion = false
        
        add(expandAnimation, forKey: nil)
    }
    
}
