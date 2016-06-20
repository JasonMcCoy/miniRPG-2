//
//  Character.swift
//  miniRPG 2
//
//  Created by Jason McCoy on 6/19/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import Foundation

class Character {
    private var _hp = 100
    var hp: Int {
        get {
            return _hp
        }
    }
    
    private var _attackPwr = 10
    var attackPwr: Int {
        return _attackPwr
    }
    
    private var _name: String
    var name: String {
        return _name
    }
    
    init(name: String, hp: Int) {
        _name = name
        _hp = hp
    }
    
    func attemptAtk(_ attackPwr: Int) {
        _hp = _hp - attackPwr
        if _hp < 0 {
            _hp = 0
        }
    }
    
    func isDead() -> Bool {
        return _hp <= 0
    }
    
}
