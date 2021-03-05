//
//  OvalOutline.swift
//  Dice
//
//  Created by Michael Pujol on 2/21/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import UIKit

class OvalOutlineLayer: CAShapeLayer {

    //MARK: - Properties
    
    let animationDuration: CFTimeInterval = 0.5
    
    var ovalOutlinePath: UIBezierPath {
        
        let sizeFactor: CGFloat = 0.25 // 0 - 1; 1 being the maximum size
        let distanceToCenterOfCircle = ( Constants.diceSize / 2)
        let ovalSize = Constants.diceSize * sizeFactor
        
        let center = CGPoint(x: distanceToCenterOfCircle, y: distanceToCenterOfCircle)
        let radius = ovalSize / 2
        
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(-(Double.pi / 2)), endAngle: (CGFloat((2 * Double.pi) - (Double.pi / 2))), clockwise: true)
    }
    
    //MARK: - Required Methods
    
    override init() {
        super.init()
        
        fillColor = UIColor.clear.cgColor
        lineWidth = 5.0
        path = ovalOutlinePath.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Animation functions
    
    func animateStrokeWithColor() {
        strokeColor = Constants.primaryColor.cgColor
    
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = 1.0
        strokeAnimation.duration = animationDuration
        strokeAnimation.fillMode = .forwards
        
        add(strokeAnimation, forKey: nil)
        
    }
    
    func fillOval() {
        fillColor = UIColor.red.cgColor
    }
    
}
