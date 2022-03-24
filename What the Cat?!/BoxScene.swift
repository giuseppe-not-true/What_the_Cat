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
    var background = SKSpriteNode(imageNamed: "wall")
    var cat = Cat(imageNamed: "catto-1")
    var resultCat = Cat()
    var result = ""
    var box = Box(imageNamed: "box-open")
    
    let gridL = Grid(blockSize: 60.0, rows: 6, cols: 1)!
    let gridR = Grid(blockSize: 60.0, rows: 6, cols: 1)!
    
    var ordinaryCattos = [SKTexture(imageNamed: "catto-1"), SKTexture(imageNamed: "catto-2"), SKTexture(imageNamed: "catto-3"), SKTexture(imageNamed: "catto-4"), SKTexture(imageNamed: "catto-5"), SKTexture(imageNamed: "catto-6")]
    
    var ingredients = [Ingredient(imageNamed: "ingredient-atom"), Ingredient(imageNamed: "ingredient-belt"), Ingredient(imageNamed: "ingredient-boot"), Ingredient(imageNamed: "ingredient-bow"), Ingredient(imageNamed: "ingredient-bread-jam"), Ingredient(imageNamed: "ingredient-dirt"), Ingredient(imageNamed: "ingredient-discoball"), Ingredient(imageNamed: "ingredient-fish"), Ingredient(imageNamed: "ingredient-lightbulb"), Ingredient(imageNamed: "ingredient-nekonomicon"), Ingredient(imageNamed: "ingredient-scepter"), Ingredient(imageNamed: "ingredient-sword")]

    var firstTierCats: [String: (String, String, String)] = ["Warrior Cat": ("A cat perfect for any fight.", "catto-warrior", "11"), "Hunter Cat": ("No more mice.", "catto-hunter", "3"), "Wizard Cat": ("It’s so soft it is magical.", "catto-wizard", "10"), "Cat in the Boot": ("Just a chilling ball of fluff.", "catto-boot", "2"), "Funky Cat": ("These cats are made for dancing!", "catto-funky", "6"), "Anti-gravitatory Cat": ("A living feline paradox.", "catto-jam", "4"), "Nuclear Cat": ("Look! It glows in the dark!", "catto-atom", "0"), "Eurekat": ("Such a brilliant kitty.", "catto-eureka", "8"), "Shrekat": ("Kittens are like onions", "catto-shrek", "5"), "Chubby Cat": ("Maybe too fluffy, but surely lovable.", "catto-chubby", "7"), "Evil Cat": ("Dangerous, but really cute.", "catto-evil", "9"), "Karate Cat": ("A cat trained for the strongest cuddles.", "catto-karate", "1")]
    
    var secondTierCats: [String: (String, String, String)] = ["Pope Cat": ("Holy cat!", "catto-pope", "108"), "Puss in Boots": ("Legendary swordmaster and cute looking kitty.", "catto-puss-in-boots", "112"), "Nyan Cat": ("nyan nyan nyan nyan nyan nyan nyan…", "catto-nyan", "64"), "Catfish": ("What did you expect?", "catto-fish", "07"), "Exploding Kitty": ("A kickstarterbreaking cat.", "catto-exploding", "05"), "Nekomancer": ("Master of dark arts and napping.", "catto-nekomancer", "109"), "Subfeline": ("It comes with portholes!", "catto-subfeline", "78"), "Uncat": ("It kinda smells, but at least it doesn't need food.", "catto-uncat", "59"), "Ninja Cat": ("Silent and stealthy, ready to attack!", "catto-ninja", "31"), "Jedi Cat": ("The powers of the force, in a little fluffy kitty.", "catto-jedi", "118"), "Supercat": ("It can fly and lift buildings, probably it will just take a nap.", "catto-super", "01")]
    
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
//        let action = SKAction.setTexture(ordinaryCattos.randomElement()!, resize: true)
//        cat.run(action)
        cat.size.width = 100.0
        cat.size.height = 100.0
        
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
                
                var combination: String

                switch(itemsSelected.count) {
                case 1:
                    combination = "\(itemsSelected[0].name!)"
                    break
                case 2:
                    combination = "\(itemsSelected[0].name!)" + "\(itemsSelected[1].name!)"
                    break
                case 3:
                    combination = "\(itemsSelected[0].name!)" + "\(itemsSelected[1].name!)" + "\(itemsSelected[2].name!)"
                    break
                default:
                    combination = ""
                    break
                }
                                
                switch(combination) {
                case "0":
                    self.resultCat.name = "Nuclear Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Nuclear Cat"]!.1)
                    break
                case "1":
                    self.resultCat.name = "Karate Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Karate Cat"]!.1)
                    break
                case "2":
                    self.resultCat.name = "Cat in the Boot"
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Cat in the Boot"]!.1)
                    break
                case "3":
                    self.resultCat.name = "Hunter Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Hunter Cat"]!.1)
                    break
                case "4":
                    self.resultCat.name = "Anti-gravitatory Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Anti-gravitatory Cat"]!.1)
                    break
                case "5":
                    self.resultCat.name = "Shrekat"
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Shrekat"]!.1)
                    break
                case "6":
                    self.resultCat.name = "Funky Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Funky Cat"]!.1)
                    break
                case "7":
                    self.resultCat.name = "Chubby Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Chubby Cat"]!.1)
                    break
                case "8":
                    self.resultCat.name = "Eurekat"
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Eurekat"]!.1)
                    break
                case "9":
                    self.resultCat.name = "Evil Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Evil Cat"]!.1)
                    break
                case "10":
                    self.resultCat.name = "Wizard Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Wizard Cat"]!.1)
                    break
                case "11":
                    self.resultCat.name = "Warrior Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Warrior Cat"]!.1)
                    break
                    
                case "108":
                    self.resultCat.name = "Pope Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.secondTierCats["Pope Cat"]!.1)
                    break
                case "112":
                    self.resultCat.name = "Puss in Boots"
                    self.resultCat.texture = SKTexture(imageNamed: self.secondTierCats["Puss in Boots"]!.1)
                    break
                case "64":
                    self.resultCat.name = "Nyan Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.secondTierCats["Nyan Cat"]!.1)
                    break
                case "07":
                    self.resultCat.name = "Catfish"
                    self.resultCat.texture = SKTexture(imageNamed: self.secondTierCats["Catfish"]!.1)
                    break
                case "05":
                    self.resultCat.name = "Exploding Kitty"
                    self.resultCat.texture = SKTexture(imageNamed: self.secondTierCats["Exploding Kitty"]!.1)
                    break
                case "109":
                    self.resultCat.name = "Nekomancer"
                    self.resultCat.texture = SKTexture(imageNamed: self.secondTierCats["Nekomancer"]!.1)
                    break
                case "78":
                    self.resultCat.name = "Subfeline"
                    self.resultCat.texture = SKTexture(imageNamed: self.secondTierCats["Subfeline"]!.1)
                    break
                case "59":
                    self.resultCat.name = "Uncat"
                    self.resultCat.texture = SKTexture(imageNamed: self.secondTierCats["Uncat"]!.1)
                    break
                case "31":
                    self.resultCat.name = "Ninja Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.secondTierCats["Ninja Cat"]!.1)
                    break
                case "118":
                    self.resultCat.name = "Jedi Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.secondTierCats["Jedi Cat"]!.1)
                    break
                case "01":
                    self.resultCat.name = "Supercat"
                    self.resultCat.texture = SKTexture(imageNamed: self.secondTierCats["Supercat"]!.1)
                    break
                    
                case "1189":
                    self.resultCat.name = "Sith Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.thirdTierCats["Sith Cat"]!.1)
                    break
                case "251":
                    self.resultCat.name = "Cat Norris"
                    self.resultCat.texture = SKTexture(imageNamed: self.thirdTierCats["Cat Norris"]!.1)
                    break
                case "261":
                    self.resultCat.name = "The Cat wears Purrrada"
                    self.resultCat.texture = SKTexture(imageNamed: self.thirdTierCats["The Cat wears Purrrada"]!.1)
                    break
                case "579":
                    self.resultCat.name = "Cathulhu"
                    self.resultCat.texture = SKTexture(imageNamed: self.thirdTierCats["Cathulhu"]!.1)
                    break
                case "068":
                    self.resultCat.name = "Dalai Cat"
                    self.resultCat.texture = SKTexture(imageNamed: self.thirdTierCats["Dalai Cat"]!.1)
                    break
                    
                default:
                    self.resultCat.name = "Cat-astrophe"
                    self.resultCat.texture = SKTexture(imageNamed: self.mistakesCats["Cat-astrophe"]!.1)
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
