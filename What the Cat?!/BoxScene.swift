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
    @ObservedObject var gameLogic = ArcadeGameLogic.shared
    var lastUpdate: TimeInterval = 0
    let formatter = DateComponentsFormatter()
    
    var isCombining = false
    var hasClickClear = false
    var solution = ""
    var score = SKLabelNode()
    var timer = SKLabelNode()
    var message = SKLabelNode()
    
    var background = SKSpriteNode(imageNamed: "wall")
    
    let errorSound = SKAction.playSoundFileNamed("cat-error.wav", waitForCompletion: true)
    let purrSound = SKAction.playSoundFileNamed("cat-purrfect.wav", waitForCompletion: true)
    let gameOverSound = SKAction.playSoundFileNamed("game-over.wav", waitForCompletion: true)
    let noCatSound = SKAction.playSoundFileNamed("no-cat.wav", waitForCompletion: true)
    let backgroundMusic = SKAudioNode(fileNamed: "music.wav")
    
    var gameOver = SKSpriteNode(imageNamed: "vapor-bg")
    var replayButton = SKSpriteNode(imageNamed: "button")
    var replayLabel = SKLabelNode()
    var gameOverScore = SKLabelNode()
    
    var cat = Cat(texture: ordinaryCattos.randomElement()!)
    var resultCat = Cat()
    
    var boxOpen = Box(imageNamed: "box-open")
    var boxClosed = Box(imageNamed: "box")
    
    let gridL = IngredientsGrid(ingredientsInit: ingredients, startFrom: 0)
    let gridR = IngredientsGrid(ingredientsInit: ingredients, startFrom: 6)
        
    override func didMove(to view: SKView) {
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        background.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        background.zPosition = 9
        background.size.width = UIScreen.main.bounds.width
        background.size.height = UIScreen.main.bounds.height
        
        gameOver.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        gameOver.zPosition = 29
        gameOver.alpha = 0
        gameOver.size.width = UIScreen.main.bounds.width
        gameOver.size.height = UIScreen.main.bounds.height
        
        gameOverScore.text = "Your score: \(gameLogic.currentScore)"
        gameOverScore.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 + 40)
        gameOverScore.zPosition = 30
        gameOverScore.alpha = 0
        gameOverScore.fontSize = 60
        gameOverScore.fontName = "Minecraft"
        
        replayButton.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 - 30)
        replayButton.name = "replayButton"
        replayButton.zPosition = 30
        replayButton.alpha = 0
        replayButton.size.width = 200
        replayButton.size.height = 80
        
        replayLabel.text = "Replay"
        replayLabel.name = "replayLabel"
        replayLabel.zPosition = 31
        replayLabel.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 - 40)
        replayLabel.alpha = 0
        replayLabel.fontSize = 30
        replayLabel.fontName = "Minecraft"
        
        score = SKLabelNode(text: "Score: \(gameLogic.currentScore)")
        score.position = CGPoint(x: self.frame.size.width * 0.1, y: self.frame.size.height*0.85)
        score.zPosition = 15
        score.fontSize = 30
        score.fontName = "Minecraft"
        
        timer = SKLabelNode(text: "\(formatter.string(from: gameLogic.sessionDuration)!)")
        timer.position = CGPoint(x: self.frame.size.width * 0.9, y: self.frame.size.height*0.85)
        timer.zPosition = 15
        timer.fontSize = 30
        timer.fontName = "Minecraft"
        
        message = SKLabelNode(text: "WRONG!")
        message.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.25)
        message.alpha = 0
        message.zPosition = 15
        message.fontSize = 30
        message.fontName = "Minecraft"
        
        boxOpen.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 - 10)
        boxOpen.zPosition = 10
        boxOpen.size.width = 480.0
        boxOpen.size.height = 240.0
        
        boxClosed.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 - 10)
        boxClosed.zPosition = 10
        boxClosed.alpha = 0
        boxClosed.size.width = 480.0
        boxClosed.size.height = 240.0
        
        cat.name = "cat"
        cat.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 + 20)
        cat.zPosition = 11
        cat.size.width = 150.0
        cat.size.height = 150.0
        
        resultCat.name = "resultCat"
        resultCat.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 + 20)
        resultCat.zPosition = 11
        resultCat.size.width = 150.0
        resultCat.size.height = 150.0
        resultCat.alpha = 0
        
        for ingredient in ingredients {
            if ingredient.name == "boot"{
                ingredient.size.width = 50.0
                ingredient.size.height = 50.0
            } else {
                ingredient.size.width = 60.0
                ingredient.size.height = 60.0
            }
                
        }
        
        addChild(background)
        addChild(score)
        addChild(timer)
        addChild(message)
        addChild(boxOpen)
        addChild(boxClosed)
        addChild(cat)
        addChild(resultCat)
        
        gridL.zPosition = 13
        gridL.position = CGPoint (x:frame.minX + frame.maxX*0.19, y:frame.midY - 15)
        addChild(gridL)
        
        gridL.targetPosition.x = 200
        gridL.targetPosition.y = 60
        
        gridR.zPosition = 13
        gridR.position = CGPoint (x:frame.maxX - frame.maxX*0.19, y:frame.midY - 15)
        addChild(gridR)
        
        gridR.targetPosition.x = -200
        gridR.targetPosition.y = 60
        
        for rowIndex in 0...2 {
            for colIndex in 0...1 {
                gridL.ingredients[rowIndex][colIndex].position = CGPoint(x: (colIndex * 120) - 70, y: (rowIndex * 70) - 55)
                gridL.ingredients[rowIndex][colIndex].initialPos = gridL.ingredients[rowIndex][colIndex].position
                let leftIngredientName = SKLabelNode(text: gridL.ingredients[rowIndex][colIndex].name)
                leftIngredientName.fontName = "Minecraft"
                leftIngredientName.fontSize = 20
                leftIngredientName.position = CGPoint(x: gridL.ingredients[rowIndex][colIndex].position.x, y: gridL.ingredients[rowIndex][colIndex].position.y - 42.0)
                gridL.addChild(gridL.ingredients[rowIndex][colIndex])
                gridL.addChild(leftIngredientName)
                
                gridR.ingredients[rowIndex][colIndex].position = CGPoint(x: (colIndex * 120) - 50, y: (rowIndex * 70) - 55)
                gridR.ingredients[rowIndex][colIndex].initialPos = gridR.ingredients[rowIndex][colIndex].position
                let rightIngredientName = SKLabelNode(text: gridR.ingredients[rowIndex][colIndex].name)
                rightIngredientName.fontName = "Minecraft"
                rightIngredientName.fontSize = 20
                rightIngredientName.position = CGPoint(x: gridR.ingredients[rowIndex][colIndex].position.x, y: gridR.ingredients[rowIndex][colIndex].position.y - 42.0)
                gridR.addChild(gridR.ingredients[rowIndex][colIndex])
                gridR.addChild(rightIngredientName)

            }
        }
        
        
        addChild(gameOver)
        addChild(gameOverScore)
        addChild(replayLabel)
        addChild(replayButton)
        
        self.addChild(backgroundMusic)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        // Calculates how much time has passed since the last update
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        
        if timeElapsedSinceLastUpdate <= 0 {
        } else {
            // Decrease the length of the game session at the game logic
            self.gameLogic.decreaseSessionTime(by: timeElapsedSinceLastUpdate)
            timer.text = "\(formatter.string(from: gameLogic.sessionDuration)!)"
            self.lastUpdate = currentTime
        }
        
        if (gridL.itemsSelected.count + gridR.itemsSelected.count < 3) {
            gridL.elementsMoved = gridL.itemsSelected.count
            gridR.elementsMoved = gridR.itemsSelected.count
        } else {
            gridL.elementsMoved = 3
            gridR.elementsMoved = 3
        }
        
        if gameLogic.sessionDuration <= 0 {
            gameLogic.isGameOver = true
        }
        
        if gameLogic.isGameOver {
            gameOver.alpha = 1
            gameOverScore.alpha = 1
            replayLabel.alpha = 1
            replayButton.alpha = 1
        } else {
            gameOver.alpha = 0
            gameOverScore.alpha = 0
            replayLabel.alpha = 0
            replayButton.alpha = 0
        }
        
        if hasClickClear {
            for itemsSelect in gridL.itemsSelected {
                let action = SKAction.move(to: itemsSelect.initialPos, duration: 0.2)
                itemsSelect.run(action)
                itemsSelect.moved = false
                if let index = gridL.itemsSelected.firstIndex(of: itemsSelect) {
                    gridL.itemsSelected.remove(at: index)
                }
            }
            
            for itemsSelect in gridR.itemsSelected {
                let action = SKAction.move(to: itemsSelect.initialPos, duration: 0.2)
                itemsSelect.run(action)
                itemsSelect.moved = false
                if let index = gridR.itemsSelected.firstIndex(of: itemsSelect) {
                    gridR.itemsSelected.remove(at: index)
                }
            }
        }
        
        if self.isCombining {
            if gridL.itemsSelected.count + gridR.itemsSelected.count > 0 {
                self.boxOpen.alpha = 0
                self.boxClosed.alpha = 1
                self.cat.alpha = 0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.boxOpen.alpha = 1
                    self.boxClosed.alpha = 0
                    self.resultCat.alpha = 1
                    
                    switch(self.gridL.itemsSelected.count + self.gridR.itemsSelected.count) {
                    case 1:
                        self.resultCat.tier = 1
                        self.changeCatTexture(catTier: 1)
                        break
                    case 2:
                        self.resultCat.tier = 2
                        self.changeCatTexture(catTier: 2)
                        break
                    case 3:
                        self.resultCat.tier = 3
                        self.changeCatTexture(catTier: 3)
                        break
                    default:
                        break
                    }
                    
                    self.hasClickClear = true

                    if self.solution == self.resultCat.name {
//                        self.run(self.purrSound)
                        self.message.text = "PURRRFECT!"
                        let fade = SKAction.fadeIn(withDuration: 0.2)
                        self.message.run(fade)
                        self.updateScore(tier: self.resultCat.tier!)
                        self.cat.texture = ordinaryCattos.randomElement()!
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.isCombining = false
                            let fade = SKAction.fadeOut(withDuration: 0.1)
                            self.message.run(fade)
                        }
                    } else if self.resultCat.name == "Cat-astrophe" {
//                        self.run(self.noCatSound)
                        self.message.text = "WHAT HAVE YOU DONE..."
                        let fade = SKAction.fadeIn(withDuration: 0.1)
                        self.message.run(fade)
                        self.updateScore(tier: -1)
                        self.cat.texture = ordinaryCattos.randomElement()!
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.isCombining = false
                            let fade = SKAction.fadeOut(withDuration: 0.1)
                            self.message.run(fade)
                        }
                    } else {
//                        self.run(self.errorSound)
                        let fade = SKAction.fadeIn(withDuration: 0.1)
                        self.message.run(fade)
                        self.cat.texture = ordinaryCattos.randomElement()!
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.isCombining = false
                            let fade = SKAction.fadeOut(withDuration: 0.1)
                            self.message.run(fade)
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                        self.cat.alpha = 1
                        self.resultCat.alpha = 0
                        self.message.text = "WRONG!"
                    }
                }
            }
        } else {
            
            if hasClickClear {
                self.hasClickClear = false
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in:self)
            let node = atPoint(position)
            
            if node.name == "replayLabel" || node.name == "replayButton" {
                if gameLogic.isGameOver {
                    gameLogic.isGameOver = false
//                    updateScore(tier: -gameLogic.currentScore)
//                    score.text = "Score: \(gameLogic.currentScore)"
                    gameLogic.setUpGame()
                }
            }
        }
    }
    
    func updateScore(tier: Int) {
        gameLogic.score(points: tier)
        score.text = "Score: \(gameLogic.currentScore)"
        self.resultCat.name = "resultCat"
    }
    
    func changeCatTexture(catTier: Int) {
        switch(catTier){
        case 1:
            if (gridL.itemsSelected.count == 0) {
                for cat in firstTierCats {
                    if (cat.value.2.contains(gridR.itemsSelected[0].name!)) {
                        self.resultCat.name = cat.key
                        self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                        break
                    }
                }
            } else {
                for cat in firstTierCats {
                    if (cat.value.2.contains(gridL.itemsSelected[0].name!)) {
                        self.resultCat.name = cat.key
                        self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                        break
                    }
                }
            }
            break
        case 2:
            if (gridL.itemsSelected.count == 0) {
                for cat in secondTierCats {
                    if (cat.value.2.contains(gridR.itemsSelected[0].name!) && cat.value.2.contains(gridR.itemsSelected[1].name!)) {
                        self.resultCat.name = cat.key
                        self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                        break
                    } else {
                        self.resultCat.name = "Cat-astrophe"
                        self.resultCat.texture = SKTexture(imageNamed: mistakesCats["Cat-astrophe"]!.1)
                    }
                }
            } else if (gridR.itemsSelected.count == 0) {
                for cat in secondTierCats {
                    if (cat.value.2.contains(gridL.itemsSelected[0].name!) && cat.value.2.contains(gridL.itemsSelected[1].name!)) {
                        self.resultCat.name = cat.key
                        self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                        break
                    } else {
                        self.resultCat.name = "Cat-astrophe"
                        self.resultCat.texture = SKTexture(imageNamed: mistakesCats["Cat-astrophe"]!.1)
                    }
                }
            } else {
                for cat in secondTierCats {
                    if (cat.value.2.contains(gridL.itemsSelected[0].name!) && cat.value.2.contains(gridR.itemsSelected[0].name!)) {
                        self.resultCat.name = cat.key
                        self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                        break
                    } else {
                        self.resultCat.name = "Cat-astrophe"
                        self.resultCat.texture = SKTexture(imageNamed: mistakesCats["Cat-astrophe"]!.1)
                    }
                }
            }
            break
        case 3:
            if (gridL.itemsSelected.count == 0) {
                for cat in thirdTierCats {
                    if (cat.value.2.contains(gridR.itemsSelected[0].name!) && cat.value.2.contains(gridR.itemsSelected[1].name!) && cat.value.2.contains(gridR.itemsSelected[2].name!)) {
                        self.resultCat.name = cat.key
                        self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                        break
                    } else {
                        self.resultCat.name = "Cat-astrophe"
                        self.resultCat.texture = SKTexture(imageNamed: mistakesCats["Cat-astrophe"]!.1)
                    }
                }
            } else if (gridR.itemsSelected.count == 0) {
                for cat in thirdTierCats {
                    if (cat.value.2.contains(gridL.itemsSelected[0].name!) && cat.value.2.contains(gridL.itemsSelected[1].name!) && cat.value.2.contains(gridL.itemsSelected[2].name!)) {
                        self.resultCat.name = cat.key
                        self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                        break
                    } else {
                        self.resultCat.name = "Cat-astrophe"
                        self.resultCat.texture = SKTexture(imageNamed: mistakesCats["Cat-astrophe"]!.1)
                    }
                }
            } else if (gridL.itemsSelected.count == 2 && gridR.itemsSelected.count == 1) {
                for cat in thirdTierCats {
                    if (cat.value.2.contains(gridL.itemsSelected[0].name!) && cat.value.2.contains(gridL.itemsSelected[1].name!) && cat.value.2.contains(gridR.itemsSelected[0].name!)) {
                        print(gridL.itemsSelected[0].name!)
                        self.resultCat.name = cat.key
                        self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                        break
                    } else {
                        self.resultCat.name = "Cat-astrophe"
                        self.resultCat.texture = SKTexture(imageNamed: mistakesCats["Cat-astrophe"]!.1)
                    }
                }
            } else if (gridL.itemsSelected.count == 1 && gridR.itemsSelected.count == 2) {
                for cat in thirdTierCats {
                    if (cat.value.2.contains(gridL.itemsSelected[0].name!) && cat.value.2.contains(gridR.itemsSelected[0].name!) && cat.value.2.contains(gridR.itemsSelected[1].name!)) {
                        self.resultCat.name = cat.key
                        self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                        break
                    } else {
                        self.resultCat.name = "Cat-astrophe"
                        self.resultCat.texture = SKTexture(imageNamed: mistakesCats["Cat-astrophe"]!.1)
                    }
                }
            }
            break
        default:
            break
        }
    }
}
