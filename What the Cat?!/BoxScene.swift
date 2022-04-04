//
//  BoxScene.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 23/03/22.
//

import SwiftUI
import SpriteKit
import AVFoundation

class BoxScene: SKScene {
    var gameLogic = ArcadeGameLogic.shared
    var lastUpdate: TimeInterval = 0
    let formatter = DateComponentsFormatter()
    
    var isCombining = false
    var solution = ""
    var score = SKLabelNode()
    var timer = SKLabelNode()
    
    var background = SKSpriteNode(imageNamed: "wall")
    
    var cat = Cat(imageNamed: "catto-1")
    var resultCat = Cat()
    
    var box = Box(imageNamed: "box-open")
    
//    let gridL = Grid(blockSize: 60.0, rows: 6, cols: 1)!
//    let gridR = Grid(blockSize: 60.0, rows: 6, cols: 1)!
    
    let gridL = IngredientsGrid(ingredientsInit: ingredients, startFrom: 0)
    let gridR = IngredientsGrid(ingredientsInit: ingredients, startFrom: 6)
        
    var itemsSelected = [Ingredient]()
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        background.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        background.zPosition = 9
        background.size.width = UIScreen.main.bounds.width
        background.size.height = UIScreen.main.bounds.height
        
        score = SKLabelNode(text: "Score: \(gameLogic.currentScore)")
        score.position = CGPoint(x: self.frame.size.width/2 - 200, y: self.frame.size.height*0.9)
        score.zPosition = 15
        score.fontSize = 30
        score.fontName = "Minecraft"
        
        timer = SKLabelNode(text: "\(formatter.string(from: gameLogic.sessionDuration)!)")
        timer.position = CGPoint(x: self.frame.size.width/2 + 200, y: self.frame.size.height*0.9)
        timer.zPosition = 15
        timer.fontSize = 30
        timer.fontName = "Minecraft"
        
        box.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        box.zPosition = 10
        box.size.width = 240.0
        box.size.height = 240.0
        
        cat.name = "cat"
        cat.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 + 20)
        cat.zPosition = 11
        cat.size.width = 150.0
        cat.size.height = 150.0
//        let action = SKAction.setTexture(ordinaryCattos.randomElement()!, resize: true)
//        cat.run(action)
        
        resultCat.name = "cat"
        resultCat.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 + 20)
        resultCat.zPosition = 11
        resultCat.size.width = 150.0
        resultCat.size.height = 150.0
        resultCat.alpha = 0
        
        for ingredient in ingredients {
            ingredient.position = CGPoint(x: self.frame.size.width * 0.1, y: self.frame.size.height/2)
            ingredient.zPosition = 12
            ingredient.size.width = 50.0
            ingredient.size.height = 50.0
        }
        
        addChild(background)
        addChild(score)
        addChild(timer)
        addChild(box)
        addChild(cat)
        addChild(resultCat)
        
        //        for ingredient in ingredients {
        //            addChild(ingredient)
        //        }
        
        gridL.zPosition = 13
        gridL.position = CGPoint (x:frame.minX + frame.maxX*0.08, y:frame.midY)
        addChild(gridL)
        
        gridL.targetPosition.x = 300
        gridL.targetPosition.y = 50
        
//        for ingredient in 0...5 {
//            ingredients[ingredient].name = "\(ingredientsName[ingredient])"
//            ingredients[ingredient].zPosition = 14
//            ingredients[ingredient].position = gridL.gridPosition(row: ingredient, col: 0)
//            gridL.addChild(ingredients[ingredient])
//            ingredients[ingredient].initialPos = ingredients[ingredient].position
//        }
        
        gridR.zPosition = 13
        gridR.position = CGPoint (x:frame.maxX - frame.maxX*0.08, y:frame.midY)
        addChild(gridR)
        
        gridR.targetPosition.x = -300
        gridR.targetPosition.y = 50
        
//        for ingredient in 6...11 {
//            ingredients[ingredient].name = "\(ingredientsName[ingredient])"
//            ingredients[ingredient].zPosition = 14
//            ingredients[ingredient].position = gridR.gridPosition(row: ingredient - 6, col: 0)
//            gridR.addChild(ingredients[ingredient])
//            ingredients[ingredient].initialPos = ingredients[ingredient].position
//        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        // Calculates how much time has passed since the last update
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        
        if timeElapsedSinceLastUpdate <= 0 {
            gameLogic.isGameOver = true
        } else {
            // Decrease the length of the game session at the game logic
            self.gameLogic.decreaseSessionTime(by: timeElapsedSinceLastUpdate)
            timer.text = "\(formatter.string(from: gameLogic.sessionDuration)!)"
            self.lastUpdate = currentTime
        }
                
        if (gridL.elementsMoved + gridR.elementsMoved > 3) {
            for ingredient in ingredients {
                if itemsSelected.contains(ingredient) {
                    ingredient.isUserInteractionEnabled = false
                } else {
                    ingredient.isUserInteractionEnabled = true
                }
            }
        } else if (gridL.elementsMoved + gridR.elementsMoved <= 3) {
            for ingredient in ingredients {
                if itemsSelected.contains(ingredient) {
                    if ingredient.moved == false {
                        if let index = itemsSelected.firstIndex(of: ingredient) {
                            itemsSelected.remove(at: index)
                        }
                    }
                } else {
                    if ingredient.moved {
                        itemsSelected.append(ingredient)
                    }
                }
                
                ingredient.isUserInteractionEnabled = false
            }
        }
        
        if self.isCombining {
            if itemsSelected.count > 0 {
                self.cat.alpha = 0
                self.resultCat.alpha = 1

                switch(itemsSelected.count) {
                case 1:
                    for cat in firstTierCats {
                        if cat.value.2.contains(itemsSelected[0].name!) {
                            self.resultCat.name = cat.key
                            self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                            
                            var isUpdatingScore = true {
                                didSet {
                                    if isUpdatingScore {
                                        updateScore(tier: 1)
                                        isUpdatingScore = false
                                    } else {
                                        
                                    }
                                }
                            }
                            break
                        }
                    }
                    break
                case 2:
                    for cat in secondTierCats {
                        if cat.value.2.contains(itemsSelected[0].name!) && cat.value.2.contains(itemsSelected[1].name!) {
                            self.resultCat.name = cat.key
                            self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                            
                            var isUpdatingScore = true {
                                didSet {
                                    if isUpdatingScore {
                                        updateScore(tier: 2)
                                        isUpdatingScore = false
                                    } else {
                                        
                                    }
                                }
                            }
                            break
                        }
                        else {
                            self.resultCat.name = "Cat-astrophe"
                            self.resultCat.texture = SKTexture(imageNamed: mistakesCats["Cat-astrophe"]!.1)
                                                    
                            var isUpdatingScore = true {
                                didSet {
                                    if isUpdatingScore {
                                        updateScore(tier: -1)
                                        isUpdatingScore = false
                                    } else {
                                        
                                    }
                                }
                            }
                        }
                    }
                    break
                case 3:
                    for cat in thirdTierCats {
                        if cat.value.2.contains(itemsSelected[0].name!) && cat.value.2.contains(itemsSelected[1].name!) && cat.value.2.contains(itemsSelected[2].name!) {
                            self.resultCat.name = cat.key
                            self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                            var isUpdatingScore = true {
                                didSet {
                                    if isUpdatingScore {
                                        updateScore(tier: 3)
                                        isUpdatingScore = false
                                    } else {
                                        
                                    }
                                }
                            }
                            break
                        } else {
                            self.resultCat.name = "Cat-astrophe"
                            self.resultCat.texture = SKTexture(imageNamed: mistakesCats["Cat-astrophe"]!.1)
                            var isUpdatingScore = true {
                                didSet {
                                    if isUpdatingScore {
                                        updateScore(tier: -1)
                                        isUpdatingScore = false
                                    } else {
                                        
                                    }
                                }
                            }
                        }
                    }
                    break
                default:
                    break
                }
                                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    for itemsSelect in self.itemsSelected {
                        let action = SKAction.move(to: itemsSelect.initialPos, duration: 0.2)
                        itemsSelect.run(action)
                        itemsSelect.moved = false
                        self.gridL.elementsMoved = 0
                        self.gridR.elementsMoved = 0
                    }
                }
            }
            
        } else {
//            let action = SKAction.setTexture(ordinaryCattos.randomElement()!, resize: true)
//            cat.run(action)
            if self.solution == self.resultCat.name {
                self.updateScore(tier: 2)
                self.resultCat.name = ""
            }
            
            self.cat.alpha = 1
            self.resultCat.alpha = 0
//            print(itemsSelected.count)

        }
    }
    
    func updateScore(tier: Int) {
        gameLogic.score(points: tier)
        score.text = "Score: \(gameLogic.currentScore)"
        self.resultCat.name = ""
    }
}
