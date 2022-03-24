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
    var box = Box(imageNamed: "box-open")
    
    let gridL = Grid(blockSize: 50.0, rows: 6, cols: 1)!
    let gridR = Grid(blockSize: 50.0, rows: 6, cols: 1)!
    
    var ordinaryCattos = [SKTexture(imageNamed: "catto-1"), SKTexture(imageNamed: "catto-2"), SKTexture(imageNamed: "catto-3"), SKTexture(imageNamed: "catto-4"), SKTexture(imageNamed: "catto-5"), SKTexture(imageNamed: "catto-6")]
    
    var ingredients = [Ingredient(imageNamed: "ingredient-atom"), Ingredient(imageNamed: "ingredient-belt"), Ingredient(imageNamed: "ingredient-boot"), Ingredient(imageNamed: "ingredient-bow"), Ingredient(imageNamed: "ingredient-bread-jam"), Ingredient(imageNamed: "ingredient-dirt"), Ingredient(imageNamed: "ingredient-discoball"), Ingredient(imageNamed: "ingredient-fish"), Ingredient(imageNamed: "ingredient-lightbulb"), Ingredient(imageNamed: "ingredient-nekonomicon"), Ingredient(imageNamed: "ingredient-scepter"), Ingredient(imageNamed: "ingredient-sword")]
    
//    var firstTierCats: [String: (String, String, String)] = ["Warrior Cat": ("A cat perfect for any fight.", Image(""), "11+cat"), "Hunter Cat": ("No more mice.", Image(""), "3+cat"), "Wizard Cat": ("It’s so soft it is magical.", Image(""), "10+cat"), "Cat in the Boot": ("Just a chilling ball of fluff.", Image(""), "2+cat"), "Funky Cat": ("These cats are made for dancing!", Image(""), "6+cat"), "Anti-gravitatory Cat": ("A living feline paradox.", Image(""), "4+cat"), "Nuclear Cat": ("Look! It glows in the dark!", Image("catto-atom"), "0+cat"), "Eurekat": ("Such a brilliant kitty.", Image(""), "8+cat"), "Shrekat": ("Kittens are like onions", Image(""), "5+cat"), "Chubby Cat": ("Maybe too fluffy, but surely lovable.", Image(""), "7+cat"), "Evil Cat": ("Dangerous, but really cute.", Image(""), "9+cat"), "Karate Cat": ("A cat trained for the strongest cuddles.", Image(""), "1+cat")]
//
    var firstTierCats: [String: (String, String, String)] = ["Warrior Cat": ("A cat perfect for any fight.", "", "11+cat"), "Hunter Cat": ("No more mice.", "", "3+cat"), "Wizard Cat": ("It’s so soft it is magical.", "", "10+cat"), "Cat in the Boot": ("Just a chilling ball of fluff.", "", "2+cat"), "Funky Cat": ("These cats are made for dancing!", "", "6+cat"), "Anti-gravitatory Cat": ("A living feline paradox.", "", "4+cat"), "Nuclear Cat": ("Look! It glows in the dark!", "catto-atom", "0+cat"), "Eurekat": ("Such a brilliant kitty.", "", "8+cat"), "Shrekat": ("Kittens are like onions", "", "5+cat"), "Chubby Cat": ("Maybe too fluffy, but surely lovable.", "", "7+cat"), "Evil Cat": ("Dangerous, but really cute.", "", "9+cat"), "Karate Cat": ("A cat trained for the strongest cuddles.", "", "1+cat")]

    
    var secondTierCats: [String: (String, Image)] = ["Pope Cat": ("Holy cat!", Image("")), "Puss in Boots": ("Legendary swordmaster and cute looking kitty.", Image("")), "Nyan Cat": ("nyan nyan nyan nyan nyan nyan nyan…", Image("")), "Catfish": ("What did you expect?", Image("")), "Exploding Kitty": ("A kickstarterbreaking cat.", Image("")), "Nekomancer": ("Master of dark arts and napping.", Image("")), "Subfeline": ("It comes with portholes!", Image("")), "Uncat": ("It kinda smells, but at least it doesn't need food.", Image("")), "Ninja Cat": ("Silent and stealthy, ready to attack!", Image("")), "Jedi Cat": ("The powers of the force, in a little fluffy kitty.", Image("")), "Supercat": ("It can fly and lift buildings, probably it will just take a nap.", Image(""))]
    
    var thirdTierCats: [String: (String, Image)] = ["Sith Cat": ("Join the fluffy side of the force.", Image("")), "Cat Norris": ("On the 7th day, God rested … Cat Norris took over.", Image("")), "The Cat wears Purrrada": ("The coolest and most stylish of all cats.", Image("")), "Cathulhu": ("A great fluff one, fear it.", Image("")), "Dalai Cat": ("Be fluffy whenever possible. It is always possible.", Image(""))]
    
    var mistakesCats:  [String: (String, Image)] = ["Ordinary Cat": ("Just an ordinary, cute little kitty.", Image("")), "Dogezilla": ("", Image("")), "Filimi": ("", Image("")), "Cat-astrophe": ("Wh-What have you done…", Image("")), "Cat in the Box": ("", Image(""))]
    
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
            self.cat.alpha = 0
//            self.cat.removeFromParent()
            self.resultCat.alpha = 1
            
            if itemsSelected.count > 0 {
                var combination = "\((itemsSelected[0].name)!)"+"+\((self.cat.name)!)"
                
                print(combination)
                
                switch(combination) {
                case "0+cat":
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["Nuclear Cat"]!.1)
                    break
                case "1+cat":
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["1+cat"]!.1)
                    break
                case "2+cat":
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["2+cat"]!.1)
                    break
                case "3+cat":
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["3+cat"]!.1)
                    break
                case "4+cat":
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["4+cat"]!.1)
                    break
                case "5+cat":
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["5+cat"]!.1)
                    break
                case "6+cat":
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["6+cat"]!.1)
                    break
                case "7+cat":
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["7+cat"]!.1)
                    break
                case "8+cat":
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["8+cat"]!.1)
                    break
                case "9+cat":
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["9+cat"]!.1)
                    break
                case "10+cat":
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["10+cat"]!.1)
                    break
                case "11+cat":
                    self.resultCat.texture = SKTexture(imageNamed: self.firstTierCats["11+cat"]!.1)
                    break
                default:
                    break
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for itemsSelect in self.itemsSelected {
                    let action = SKAction.move(to: itemsSelect.initialPos, duration: 0.2)
                    itemsSelect.run(action)
                    if let index = self.itemsSelected.firstIndex(of: itemsSelect) {
                        itemsSelect.moved = false
                        self.itemsSelected.remove(at: index)
                    }
                }
            }
            
        } else {
//            let action = SKAction.setTexture(ordinaryCattos.randomElement()!, resize: true)
//            cat.run(action)
            self.cat.alpha = 1
            self.resultCat.alpha = 0
        }
    }
}
