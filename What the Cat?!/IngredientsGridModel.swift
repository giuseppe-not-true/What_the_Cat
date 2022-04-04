//
//  IngredientsGridModel.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 04/04/22.
//

import Foundation
import SpriteKit

class IngredientsGrid: SKSpriteNode {
    let maxRow = 3
    let maxCol = 2
    var ingredients: [[Ingredient]] = [[]]   // Array(repeating: [Ingredient()], count: 6)
    var targetPosition: CGPoint!
    var elementsMoved = 0
    
    init(ingredientsInit: [Ingredient], startFrom: Int) {
        var counter = startFrom
        
        for rowIndex in 0...maxRow-1 {
            for colIndex in 0...maxCol-1 {
                print(counter)
//                self.ingredients[rowIndex][colIndex] = ingredientsInit[counter]
                self.ingredients[rowIndex].append(ingredientsInit[counter])
                self.ingredients[rowIndex][colIndex].name = "\(ingredientsName[counter])"
                self.ingredients[rowIndex][colIndex].zPosition = 14
//                self.ingredients[rowIndex][colIndex].position = gridL.gridPosition(row: ingredient, col: 0)
//                gridL.addChild(ingredients[ingredient])
                self.ingredients[rowIndex][colIndex].initialPos = ingredientsInit[counter].position
                counter+=1
            }
        }
        
        self.targetPosition = CGPoint(x: 0, y: 0)
        
        super.init(texture: SKTexture(imageNamed: ""), color: UIColor.red, size: CGSize(width: 100, height: 100))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in:self)
            let node = atPoint(position)
            
            if let tempNode = node as? Ingredient{
                if node != self {
                    if tempNode.position != targetPosition {
                        if elementsMoved < 3 {
                            
                            let action = SKAction.move(to: targetPosition, duration: 0.5)
                            tempNode.run(action)
                            tempNode.moved = true
                            
                            elementsMoved += 1
                        }
                    } else if tempNode.position == targetPosition {
                        if elementsMoved > 0 {
                            
                            let action = SKAction.move(to: tempNode.initialPos, duration: 0.5)
                            tempNode.run(action)
                            tempNode.moved = false
                            
                            elementsMoved -= 1
                        }
                    }
                }
            }
        }
    }
}
