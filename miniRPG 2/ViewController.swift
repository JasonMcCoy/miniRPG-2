//
//  ViewController.swift
//  miniRPG 2
//
//  Created by Jason McCoy on 6/17/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game: Game?
    
    @IBOutlet weak var startBtnLbl: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var firstPlyrBtn: UIButton!
    @IBOutlet weak var firstPlyrBtnLbl: UILabel!
    
    @IBOutlet weak var secondPlyrBtn: UIButton!
    @IBOutlet weak var secondPlyrBtnLbl: UILabel!
    
    @IBOutlet weak var displayLbl: UILabel!
    
    @IBOutlet weak var firstPlyrImage: UIImageView!
    @IBOutlet weak var secondPlyrImage: UIImageView!
    
    @IBOutlet weak var firstPlyrHpLbl: UILabel!
    @IBOutlet weak var secondPlyrHpLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        restartGame()
    }

    @IBAction func onFrstBtnPrsd(_ sender: AnyObject) {
        if let currentGame = game {
            if !currentGame.started {
                if currentGame.firstPlyr == nil {
                    currentGame.firstPlyr = Grunt(name: "Player 1")
                    displayLbl.text = "Pick a character for Player 2"
                } else if currentGame.secondPlyr == nil {
                    currentGame.secondPlyr = Grunt(name: "Player 2")
                    startGame()
                }
            } else {
                if secondPlyrBtn.isEnabled {
                    secondPlyrBtn.isEnabled = false
                    Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.enableSecondPlyr), userInfo: nil, repeats: false)
                }
                
                if let firstPlyr = currentGame.firstPlyr, secondPlyr = currentGame.secondPlyr {
                    attemptAttack(firstPlyr,  enemy: secondPlyr)
                }
            }
        }
    }
    
    @IBAction func onScndBtnPrsd(_ sender: AnyObject) {
        if let currentGame = game {
            if !currentGame.started {
                if currentGame.firstPlyr == nil {
                    currentGame.firstPlyr = Spartan(name: "Player 1")
                    displayLbl.text = "Pick a character for Player 2"
                } else if currentGame.secondPlyr == nil {
                    currentGame.secondPlyr = Spartan(name: "Player 2")
                    startGame()
                }
            } else {
                if firstPlyrBtn.isEnabled {
                    firstPlyrBtn.isEnabled = false
                    Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.enableFirstPlyr), userInfo: nil, repeats: false)
                }
                
                if let firstPlyr = currentGame.firstPlyr, secondPlyr = currentGame.secondPlyr {
                    attemptAttack(secondPlyr,  enemy: firstPlyr)
                }
            }
        }
    }
    
    @IBAction func onStrtBtnPrsd(_ sender: AnyObject) {
        restartGame()
    }
    
    func attemptAttack(_ plyr: Character, enemy: Character) {
        enemy.attemptAtk(plyr.attackPwr)
        updatePlyrHp()
        if enemy.isDead() {
            displayLbl.text = "\(plyr.name) HAS WON THE BATTLE!"
            endGame()
        } else {
            displayLbl.text = "\(plyr.name) hits \(enemy.name) for \(plyr.attackPwr) HP."
        }
    }
    
    func updatePlyrHp() {
        if let firstPlyr = game?.firstPlyr, secondPlyr = game?.secondPlyr {
            firstPlyrHpLbl.text = "\(firstPlyr.hp) HP"
            secondPlyrHpLbl.text = "\(secondPlyr.hp) HP"
        }
    }
    
    func endGame() {
        game = nil
        
        firstPlyrBtn.isHidden = true
        firstPlyrBtnLbl.isHidden = true
        secondPlyrBtn.isHidden = true
        secondPlyrBtnLbl.isHidden = true
        
        startBtn.isHidden = false
        startBtnLbl.isHidden = false
    }
    
    func newCharacter(_ name: String, type: RaceType) -> Character {
        if type == .grunt {
            return Grunt(name: name)
        }
        return Spartan(name: name)
    }
    
    
    func enableFirstPlyr() {
        firstPlyrBtn.isEnabled = true
    }
    
    func enableSecondPlyr() {
        secondPlyrBtn.isEnabled = true
    }
    
    func startGame() {
        if let currentGame = game {
            if let firstPlyr = currentGame.firstPlyr {
                let isGrunt = firstPlyr is Grunt
                updateplyrImage(firstPlyrImage, isGrunt: isGrunt)
                if !isGrunt {
                    firstPlyrImage.transform = CGAffineTransform(scaleX: -1, y: 1)
                }
                
            }
            if let secondPlyr = currentGame.secondPlyr {
                let isGrunt = secondPlyr is Grunt
                updateplyrImage(secondPlyrImage, isGrunt: isGrunt)
                if isGrunt {
                    secondPlyrImage.transform = CGAffineTransform(scaleX: -1, y: 1)
                }
            }
            currentGame.start()
            updatePlyrHp()
            displayLbl.text = "FIGHT!"
            firstPlyrBtnLbl.text = "ATTACK"
            secondPlyrBtnLbl.text = "ATTACK"
        }
    }
    
    func restartGame() {
        game = Game()
        startBtnLbl.isHidden = true
        startBtn.isHidden = true
        
        displayLbl.text = "Pick a character for Player 1"
        
        firstPlyrBtnLbl.isHidden = false
        firstPlyrBtn.isHidden = false
        firstPlyrBtn.isEnabled = true
        firstPlyrBtnLbl.text = "GRUNT"
        firstPlyrHpLbl.text = "110 HP"
        updateplyrImage(firstPlyrImage, isGrunt: true)
        firstPlyrImage.transform = CGAffineTransform.identity
        
        
        secondPlyrBtnLbl.isHidden = false
        secondPlyrBtn.isHidden = false
        secondPlyrBtn.isEnabled = true
        secondPlyrBtnLbl.text = "SPARTAN"
        secondPlyrHpLbl.text = "100 HP"
        updateplyrImage(secondPlyrImage, isGrunt: false)
        secondPlyrImage.transform = CGAffineTransform.identity
        
    }
    
    func updateplyrImage(_ img: UIImageView, isGrunt: Bool) {
        if isGrunt {
            img.image = UIImage(named: "enemy")
        } else {
            img.image = UIImage(named: "playeerr")
        }
    }
    
}

