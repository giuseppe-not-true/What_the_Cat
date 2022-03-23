//
//  BoxScene.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 23/03/22.
//

import SwiftUI
import SpriteKit

class Cat: SKSpriteNode {
    
}

class Box: SKSpriteNode {
    
}

class BoxScene: SKScene {
    var cat = Cat(imageNamed: "catto")
    var box = Box(imageNamed: "box open")
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: 300, height: 250)
        self.backgroundColor = .clear
        
        box.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        box.zPosition = 10
        box.size.width = 350.0
        box.size.height = 250.0
        
        cat.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        cat.zPosition = 11
        cat.position.y = self.frame.maxY - 50
        cat.size.width = 100.0
        cat.size.height = 100.0
        
        addChild(box)
        addChild(cat)
    }
}
