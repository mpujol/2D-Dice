//
//  DiceModel.swift
//  Dice
//
//  Created by Michael Pujol on 2/23/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import UIKit

class DiceModel: NSObject {

    var minValue:Int
    var maxValue:Int
    
    
    func createRandomNumber() -> Int {
        return Int(arc4random_uniform(UInt32(maxValue - minValue + 1))) + minValue
    }
    
    init(minValue: Int, maxValue: Int) {
        
        self.minValue = minValue
        self.maxValue = maxValue
        
    }
    
    
}
