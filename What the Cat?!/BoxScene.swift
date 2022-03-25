//
//  BoxScene.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 23/03/22.
//

import SwiftUI
import SpriteKit

enum GameState {
    case mainScreen
    case playing
    case gameOver
}

class BoxScene: SKScene {
    var gameLogic = ArcadeGameLogic.shared
    var lastUpdate: TimeInterval = 0

    var isCombining = false
    var combination = ""
    var background = SKSpriteNode(imageNamed: "wall")
    var cat = Cat(imageNamed: "catto-1")
    var resultCat = Cat()
    var box = Box(imageNamed: "box-open")
    
    let gridL = Grid(blockSize: 60.0, rows: 6, cols: 1)!
    let gridR = Grid(blockSize: 60.0, rows: 6, cols: 1)!
    
    var ordinaryCattos = [SKTexture(imageNamed: "catto-1"), SKTexture(imageNamed: "catto-2"), SKTexture(imageNamed: "catto-3"), SKTexture(imageNamed: "catto-4"), SKTexture(imageNamed: "catto-5"), SKTexture(imageNamed: "catto-6")]
    
    var ingredients = [Ingredient(imageNamed: "ingredient-atom"), Ingredient(imageNamed: "ingredient-belt"), Ingredient(imageNamed: "ingredient-boot"), Ingredient(imageNamed: "ingredient-bow"), Ingredient(imageNamed: "ingredient-bread-jam"), Ingredient(imageNamed: "ingredient-dirt"), Ingredient(imageNamed: "ingredient-discoball"), Ingredient(imageNamed: "ingredient-fish"), Ingredient(imageNamed: "ingredient-lightbulb"), Ingredient(imageNamed: "ingredient-nekonomicon"), Ingredient(imageNamed: "ingredient-scepter"), Ingredient(imageNamed: "ingredient-sword")]

    var firstTierCats: [String: (String, String, String)] = ["Warrior Cat": ("A cat perfect for any fight.", "catto-warrior", "11"), "Hunter Cat": ("No more mice.", "catto-hunter", "3"), "Wizard Cat": ("It’s so soft it is magical.", "catto-wizard", "10"), "Cat in the Boot": ("Just a chilling ball of fluff.", "catto-boot", "2"), "Funky Cat": ("These cats are made for dancing!", "catto-funky", "6"), "Anti-gravitatory Cat": ("A living feline paradox.", "catto-jam", "4"), "Nuclear Cat": ("Look! It glows in the dark!", "catto-atom", "0"), "Eurekat": ("Such a brilliant kitty.", "catto-eureka", "8"), "Shrekat": ("Kittens are like onions", "catto-shrek", "5"), "Chubby Cat": ("Maybe too fluffy, but surely lovable.", "catto-chubby", "7"), "Evil Cat": ("Dangerous, but really cute.", "catto-evil", "9"), "Karate Cat": ("A cat trained for the strongest cuddles.", "catto-karate", "1")]
    
    var secondTierCats: [String: (String, String, String)] = ["Pope Cat": ("Holy cat!", "catto-pope", "10 8"), "Puss in Boots": ("Legendary swordmaster and cute looking kitty.", "catto-puss-in-boots", "11 2"), "Nyan Cat": ("nyan nyan nyan nyan nyan nyan nyan…", "catto-nyan", "6 4"), "Catfish": ("What did you expect?", "catto-fish", "0 7"), "Exploding Kitty": ("A kickstarterbreaking cat.", "catto-exploding", "0 5"), "Nekomancer": ("Master of dark arts and napping.", "catto-nekomancer", "10 9"), "Subfeline": ("It comes with portholes!", "catto-subfeline", "7 8"), "Uncat": ("It kinda smells, but at least it doesn't need food.", "catto-uncat", "5 9"), "Ninja Cat": ("Silent and stealthy, ready to attack!", "catto-ninja", "3 1"), "Jedi Cat": ("The powers of the force, in a little fluffy kitty.", "catto-jedi", "11 8"), "Supercat": ("It can fly and lift buildings, probably it will just take a nap.", "catto-super", "0 1")]
    
    var thirdTierCats: [String: (String, String, String)] = ["Sith Cat": ("Join the fluffy side of the force.", "catto-sith", "1189"), "Cat Norris": ("On the 7th day, God rested … Cat Norris took over.", "catto-norris", "251"), "The Cat wears Purrrada": ("The coolest and most stylish of all cats.", "catto-prada", "261"), "Cathulhu": ("A great fluff one, fear it.", "catto-cathulhu", "579"), "Dalai Cat": ("Be fluffy whenever possible. It is always possible.", "", "068")]
    
    var mistakesCats:  [String: (String, String)] = ["Ordinary Cat": ("Just an ordinary, cute little kitty.", "catto-1"), "Dogezilla": ("", ""), "Filimi": ("", ""), "Cat-astrophe": ("Wh-What have you done…", "catto-catastrophe"), "Cat in the Box": ("", "")]
    
    var itemsSelected = [Ingredient]()
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        background.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        background.zPosition = 9
        background.size.width = UIScreen.main.bounds.width
        background.size.height = UIScreen.main.bounds.height
        
        box.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        box.zPosition = 10
        box.size.width = 240.0
        box.size.height = 240.0
        
        cat.name = "cat"
        cat.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 + 15)
        cat.zPosition = 11
        cat.size.width = 100.0
        cat.size.height = 100.0
//        let action = SKAction.setTexture(ordinaryCattos.randomElement()!, resize: true)
//        cat.run(action)
        
        resultCat.name = "cat"
        resultCat.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 + 15)
        resultCat.zPosition = 11
        resultCat.size.width = 100.0
        resultCat.size.height = 100.0
        resultCat.alpha = 0
        
        for ingredient in ingredients {
            ingredient.position = CGPoint(x: self.frame.size.width * 0.1, y: self.frame.size.height/2)
            ingredient.zPosition = 12
            ingredient.size.width = 50.0
            ingredient.size.height = 50.0
        }
        
        addChild(background)
        
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
        
        for ingredient in 0...5 {
            ingredients[ingredient].name = "\(ingredient)"
            ingredients[ingredient].zPosition = 14
            ingredients[ingredient].position = gridL.gridPosition(row: ingredient, col: 0)
            gridL.addChild(ingredients[ingredient])
            ingredients[ingredient].initialPos = ingredients[ingredient].position
        }
        gridR.zPosition = 13
        gridR.position = CGPoint (x:frame.maxX - frame.maxX*0.08, y:frame.midY)
        addChild(gridR)
        
        gridR.targetPosition.x = -300
        gridR.targetPosition.y = 50
        
        for ingredient in 6...11 {
            ingredients[ingredient].name = "\(ingredient)"
            ingredients[ingredient].zPosition = 14
            ingredients[ingredient].position = gridR.gridPosition(row: ingredient - 6, col: 0)
            gridR.addChild(ingredients[ingredient])
            ingredients[ingredient].initialPos = ingredients[ingredient].position
        }
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
            
            self.lastUpdate = currentTime
        }
                
        if (gridL.elementsMoved + gridR.elementsMoved >= 3) {
            for ingredient in ingredients {
                if itemsSelected.contains(ingredient) {
                    ingredient.isUserInteractionEnabled = false
                } else {
                    ingredient.isUserInteractionEnabled = true
                }
            }
        } else if (gridL.elementsMoved + gridR.elementsMoved < 3) {
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
                            break
                        }
                    }
                    break
                case 2:
                    for cat in secondTierCats {
                        if cat.value.2.contains(itemsSelected[0].name!) && cat.value.2.contains(itemsSelected[1].name!) {
                            self.resultCat.name = cat.key
                            self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                            break
                        }
                        else {
                            self.resultCat.name = "Cat-astrophe"
                            self.resultCat.texture = SKTexture(imageNamed: self.mistakesCats["Cat-astrophe"]!.1)
                        }
                    }
                    break
                case 3:
                    for cat in thirdTierCats {
                        if cat.value.2.contains(itemsSelected[0].name!) && cat.value.2.contains(itemsSelected[1].name!) && cat.value.2.contains(itemsSelected[2].name!) {
                            self.resultCat.name = cat.key
                            self.resultCat.texture = SKTexture(imageNamed: cat.value.1)
                            break
                        } else {
                            self.resultCat.name = "Cat-astrophe"
                            self.resultCat.texture = SKTexture(imageNamed: self.mistakesCats["Cat-astrophe"]!.1)
                        }
                    }
                    break
                default:
                    break
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
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
            self.cat.alpha = 1
            self.resultCat.alpha = 0
//            print(itemsSelected.count)

        }
    }
}
