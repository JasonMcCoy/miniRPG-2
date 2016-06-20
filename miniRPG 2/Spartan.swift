//
//  Spartan.swift
//  miniRPG 2
//
//  Created by Jason McCoy on 6/19/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import Foundation

class Spartan: Character {
    
    convenience init(name: String) {
        self.init(name: name, hp: 100)
    }
    
    override var attackPwr: Int {
        return super.attackPwr + 10
    }
    
}
