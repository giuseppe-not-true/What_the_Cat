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
    var hasClickClear = false
    var solution = ""
    var score = SKLabelNode()
    var timer = SKLabelNode()
    
    var background = SKSpriteNode(imageNamed: "wall")
    
    var cat = Cat(imageNamed: "catto-1")
    var resultCat = Cat()
    
    var box = Box(imageNamed: "box-open")
    
    let gridL = IngredientsGrid(ingredientsInit: ingredients, startFrom: 0)
    let gridR = IngredientsGrid(ingredientsInit: ingredients, startFrom: 6)
    
    var itemsSelected = [Ingredient]()
    var tmpL = 0
    var tmpR = 0
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        background.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        background.zPosition = 9
        background.size.width = UIScreen.main.bounds.width
        background.size.height = UIScreen.main.bounds.height
        
        score = SKLabelNode(text: "Score: \(gameLogic.currentScore)")
        score.position = CGPoint(x: self.frame.size.width/2 - 190, y: self.frame.size.height*0.9)
        score.zPosition = 15
        score.fontSize = 30
        score.fontName = "Minecraft"
        
        timer = SKLabelNode(text: "\(formatter.string(from: gameLogic.sessionDuration)!)")
        timer.position = CGPoint(x: self.frame.size.width/2 + 220, y: self.frame.size.height*0.9)
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
            ingredient.size.width = 70.0
            ingredient.size.height = 70.0
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
        gridL.position = CGPoint (x:frame.minX + frame.maxX*0.12, y:frame.midY)
        addChild(gridL)
        
        gridL.targetPosition.x = 300
        gridL.targetPosition.y = 50
        
        gridR.zPosition = 13
        gridR.position = CGPoint (x:frame.maxX - frame.maxX*0.12, y:frame.midY)
        addChild(gridR)
        
        gridR.targetPosition.x = -300
        gridR.targetPosition.y = 50
        
        for rowIndex in 0...2 {
            for colIndex in 0...1 {
                gridL.ingredients[rowIndex][colIndex].position = CGPoint(x: (colIndex * 90) - 40, y: (rowIndex * 100) - 100)
                gridL.ingredients[rowIndex][colIndex].initialPos = gridL.ingredients[rowIndex][colIndex].position
                let leftIngredientName = SKLabelNode(text: gridL.ingredients[rowIndex][colIndex].name)
                leftIngredientName.position = CGPoint(x: gridL.ingredients[rowIndex][colIndex].position.x, y: gridL.ingredients[rowIndex][colIndex].position.y - 20.0)
                gridL.addChild(gridL.ingredients[rowIndex][colIndex])
                gridL.addChild(leftIngredientName)
                
                gridR.ingredients[rowIndex][colIndex].position = CGPoint(x: (colIndex * -90) + 40, y: (rowIndex * 100) - 100)
                gridR.ingredients[rowIndex][colIndex].initialPos = gridR.ingredients[rowIndex][colIndex].position
                let rightIngredientName = SKLabelNode(text: gridR.ingredients[rowIndex][colIndex].name)
                rightIngredientName.position = CGPoint(x: gridR.ingredients[rowIndex][colIndex].position.x, y: gridR.ingredients[rowIndex][colIndex].position.y - 20.0)
                gridR.addChild(gridR.ingredients[rowIndex][colIndex])
                gridR.addChild(rightIngredientName)

            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        // Calculates how much time has passed since the last update
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        
        if timeElapsedSinceLastUpdate <= 0 {
            gameLogic.isGameOver = true
            timer.text = "Time is over"
        } else {
            // Decrease the length of the game session at the game logic
            self.gameLogic.decreaseSessionTime(by: timeElapsedSinceLastUpdate)
            timer.text = "\(formatter.string(from: gameLogic.sessionDuration)!)"
            self.lastUpdate = currentTime
        }
        
        if ((gridL.elementsMoved + gridR.elementsMoved) == 3) {
//            tmpL = gridL.elementsMoved
//            tmpR = gridR.elementsMoved
            
            gridL.elementsMoved = 3
            gridR.elementsMoved = 3
        }
        else if ((gridL.elementsMoved + gridR.elementsMoved) < 3) {
            for rowIndex in 0...2 {
                for colIndex in 0...1 {
                    if itemsSelected.contains(gridL.ingredients[rowIndex][colIndex]) {
                        if gridL.ingredients[rowIndex][colIndex].moved == false {
                            if let index = itemsSelected.firstIndex(of: gridL.ingredients[rowIndex][colIndex]) {
                                itemsSelected.remove(at: index)
                            }
                        }
                    } else {
                        if gridL.ingredients[rowIndex][colIndex].moved {
                            itemsSelected.append(gridL.ingredients[rowIndex][colIndex])
                        }
                        
                    }
                    
                    if itemsSelected.contains(gridL.ingredients[rowIndex][colIndex]) {
                        if gridR.ingredients[rowIndex][colIndex].moved == false {
                            if let index = itemsSelected.firstIndex(of: gridR.ingredients[rowIndex][colIndex]) {
                                itemsSelected.remove(at: index)
                            }
                        }
                    } else {
                        if gridR.ingredients[rowIndex][colIndex].moved {
                            itemsSelected.append(gridR.ingredients[rowIndex][colIndex])
                        }
                    }
                    
//                    gridL.ingredients[rowIndex][colIndex].isUserInteractionEnabled = false
//                    gridR.ingredients[rowIndex][colIndex].isUserInteractionEnabled = false
                }
            }
        }
        
        if hasClickClear {
            for itemsSelect in self.itemsSelected {
                let action = SKAction.move(to: itemsSelect.initialPos, duration: 0.2)
                itemsSelect.run(action)
                itemsSelect.moved = false
                self.gridL.elementsMoved = 0
                self.gridR.elementsMoved = 0
            }
            itemsSelected.removeAll()
        }
        
        if self.isCombining {
            if itemsSelected.count > 0 {
                self.cat.alpha = 0
                self.resultCat.alpha = 1
                switch(itemsSelected.count) {
                case 1:
                    for cat in firstTierCats {
                        if (cat.value.2.contains(itemsSelected[0].name!)) {
                            self.resultCat.name = cat.key
                            self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                            
                            var isUpdatingScore = true {
                                didSet {
                                    if isUpdatingScore {
                                        updateScore(tier: 1)
                                        score.text = "Score: \(gameLogic.currentScore)"
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
                        if (cat.value.2.contains(itemsSelected[0].name!) && cat.value.2.contains(itemsSelected[1].name!)) {
                            self.resultCat.name = cat.key
                            self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                            
                            var isUpdatingScore = true {
                                didSet {
                                    if isUpdatingScore {
                                        updateScore(tier: 2)
                                        score.text = "Score: \(gameLogic.currentScore)"
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
                                        score.text = "Score: \(gameLogic.currentScore)"
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
                        if (cat.value.2.contains(itemsSelected[0].name!) && cat.value.2.contains(itemsSelected[1].name!) && cat.value.2.contains(itemsSelected[2].name!)) {
                            self.resultCat.name = cat.key
                            self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                            var isUpdatingScore = true {
                                didSet {
                                    if isUpdatingScore {
                                        updateScore(tier: 3)
                                        score.text = "Score: \(gameLogic.currentScore)"
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
                                        score.text = "Score: \(gameLogic.currentScore)"
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
                    self.itemsSelected.removeAll()
                }
            }
            
        } else {
            //            let action = SKAction.setTexture(ordinaryCattos.randomElement()!, resize: true)
            //            cat.run(action)
//            if self.solution == self.resultCat.name {
//                self.updateScore(tier: 2)
//                score.text = "Score: \(gameLogic.currentScore)"
//                self.resultCat.name = "cat"
//            }
            
            self.cat.alpha = 1
            self.resultCat.alpha = 0
            
        }
    }
    
    func updateScore(tier: Int) {
        gameLogic.score(points: tier)
        self.resultCat.name = ""
    }
}
