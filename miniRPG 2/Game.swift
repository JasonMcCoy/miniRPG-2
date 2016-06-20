//
//  Game.swift
//  miniRPG 2
//
//  Created by Jason McCoy on 6/19/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import Foundation

class Game {
    
    var firstPlyr: Character?
    var secondPlyr: Character?
    
    private var _started: Bool = false
    var started: Bool {
        return _started
    }
    
    func start() {
        _started = true
    }
    
}
