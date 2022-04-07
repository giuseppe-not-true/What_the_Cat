//
//  GameOverScene.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 07/04/22.
//

import Foundation
import SpriteKit
import SwiftUI

class GameOverScene: SKScene {
    @ObservedObject var gameLogic = ArcadeGameLogic.shared

    var bg = SKSpriteNode(imageNamed: "vapor-bg")
    var finalScore = SKLabelNode()
//    var restartButton = SKSpriteNode(imageNamed: "replay-button")
    
    override init(size: CGSize) {
        super.init(size: size)
        
        bg.name = "background"
        bg.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2*1.1)
        bg.size.width *= 2
        bg.size.height *= 2
        bg.zPosition = 0.0
        
        addChild(bg)
        
        finalScore.text = "Your score: \(gameLogic.currentScore)"
        finalScore.fontSize = 50.0
        finalScore.color = SKColor.white
        finalScore.fontName = "Thonburi-Bold"
        finalScore.position = CGPoint(x: size.width / 2, y: size.height / 2 + 50)
        
        addChild(finalScore)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "restartButton" {
                restartGame()
            }
        }
    }
    
    func restartGame(){
        let gameScene = BoxScene(size: size)
        gameScene.scaleMode = scaleMode
        
        let reveal = SKTransition.fade(withDuration: 0.5)
        view?.presentScene(gameScene, transition: reveal)
    }
}
