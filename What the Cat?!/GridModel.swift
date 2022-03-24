//
//  GridModel.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 23/03/22.
//

import Foundation
import SpriteKit

class Grid: SKSpriteNode {
    var rows: Int!
    var cols: Int!
    var blockSize: CGFloat!
    
    var targetPosition: CGPoint!
    var elementsMoved = 0
    
    convenience init?(blockSize: CGFloat, rows: Int, cols: Int) {
        guard let texture = Grid.gridTexture(blockSize: blockSize,rows: rows, cols:cols) else {
            return nil
        }
        self.init(texture: texture, color:SKColor.clear, size: texture.size())
        self.blockSize = blockSize
        self.rows = rows
        self.cols = cols
        self.targetPosition = CGPoint(x: 0, y: 0)
        self.isUserInteractionEnabled = true
    }

    class func gridTexture(blockSize:CGFloat,rows:Int,cols:Int) -> SKTexture? {
        // Add 1 to the height and width to ensure the borders are within the sprite
        let size = CGSize(width: CGFloat(cols)*blockSize+1.0, height: CGFloat(rows)*blockSize+1.0)
        UIGraphicsBeginImageContext(size)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let bezierPath = UIBezierPath()
        let offset:CGFloat = 0.5
        // Draw vertical lines
        for i in 0...cols {
            let x = CGFloat(i)*blockSize + offset
            bezierPath.move(to: CGPoint(x: x, y: 0))
            bezierPath.addLine(to: CGPoint(x: x, y: size.height))
        }
        // Draw horizontal lines
        for i in 0...rows {
            let y = CGFloat(i)*blockSize + offset
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: size.width, y: y))
        }
        SKColor.white.setStroke()
        bezierPath.lineWidth = 1.0
        bezierPath.stroke()
        context.addPath(bezierPath.cgPath)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return SKTexture(image: image!)
    }

    func gridPosition(row:Int, col:Int) -> CGPoint {
        let offset = blockSize / 2.0 + 0.5
        let x = CGFloat(col) * blockSize - (blockSize * CGFloat(cols)) / 2.0 + offset
        let y = CGFloat(rows - row - 1) * blockSize - (blockSize * CGFloat(rows)) / 2.0 + offset
        return CGPoint(x:x, y:y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in:self)
            let node = atPoint(position)
            
            if let tempNode = node as? Ingredient{
                if node != self {
                    if tempNode.position != targetPosition {
                        let action = SKAction.move(to: targetPosition, duration: 0.5)
                        tempNode.run(action)
                        tempNode.moved = true
                        elementsMoved += 1
                    } else if tempNode.position == targetPosition {
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
