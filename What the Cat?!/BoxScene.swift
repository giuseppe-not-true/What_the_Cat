//
//  BoxScene.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 23/03/22.
//

import SwiftUI
import SpriteKit

class BoxScene: SKScene {
    var background = SKSpriteNode(imageNamed: "wall")
    var cat = Cat(imageNamed: "catto")
    var box = Box(imageNamed: "box-open")
    var ingredients = [Ingredient(imageNamed: "ingredient-atom"), Ingredient(imageNamed: "ingredient-belt"), Ingredient(imageNamed: "ingredient-boot"), Ingredient(imageNamed: "ingredient-bow"), Ingredient(imageNamed: "ingredient-bread-jam"), Ingredient(imageNamed: "ingredient-dirt"), Ingredient(imageNamed: "ingredient-discoball"), Ingredient(imageNamed: "ingredient-fish"), Ingredient(imageNamed: "ingredient-lightbulb"), Ingredient(imageNamed: "ingredient-nekonomicon"), Ingredient(imageNamed: "ingredient-scepter"), Ingredient(imageNamed: "ingredient-sword")]
        
    override func didMove(to view: SKView) {
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        background.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        background.zPosition = 9
        background.size.width = UIScreen.main.bounds.width
        background.size.height = UIScreen.main.bounds.height
        
        box.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        box.zPosition = 10
        box.size.width = 350.0
        box.size.height = 250.0
        
        cat.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 + 45)
        cat.zPosition = 11
        cat.size.width = 100.0
        cat.size.height = 100.0
        
        for ingredient in ingredients {
            ingredient.position = CGPoint(x: self.frame.size.width * 0.1, y: self.frame.size.height/2)
            ingredient.zPosition = 12
            ingredient.size.width = 50.0
            ingredient.size.height = 50.0
        }
        
        addChild(background)
                
        addChild(box)
        addChild(cat)
        
//        for ingredient in ingredients {
//            addChild(ingredient)
//        }
        
        if let gridL = Grid(blockSize: 50.0, rows: 6, cols: 1) {
            gridL.zPosition = 13
            gridL.position = CGPoint (x:frame.minX + frame.maxX*0.08, y:frame.midY)
            addChild(gridL)
            
            gridL.boxPosition.x = 300
            gridL.boxPosition.y = 50
            
            for ingredient in 0...5 {
                ingredients[ingredient].zPosition = 14
                ingredients[ingredient].position = gridL.gridPosition(row: ingredient, col: 0)
                gridL.addChild(ingredients[ingredient])
            }
        }
        
        if let gridR = Grid(blockSize: 50.0, rows: 6, cols: 1) {
            gridR.zPosition = 13
            gridR.position = CGPoint (x:frame.maxX - frame.maxX*0.08, y:frame.midY)
            addChild(gridR)
            
            gridR.boxPosition.x = -300
            gridR.boxPosition.y = 50
            
            for ingredient in 6...11 {
                ingredients[ingredient].zPosition = 14
                ingredients[ingredient].position = gridR.gridPosition(row: ingredient - 6, col: 0)
                gridR.addChild(ingredients[ingredient])
            }
        }
    }
}
