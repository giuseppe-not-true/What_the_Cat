//
//  ArcadeGameLogic.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 24/03/22.
//

import Foundation

class ArcadeGameLogic: ObservableObject {
    
    // Single instance of the class
    static let shared: ArcadeGameLogic = ArcadeGameLogic()
    
    // Function responsible to set up the game before it starts.
    func setUpGame() {
        
        // TODO: Customize!
        
        self.currentScore = 0
        self.sessionDuration = 121
        
        self.isGameOver = false
    }
    
    // Keeps track of the current score of the player
    @Published var currentScore: Int = 0
    
    // Increases the score by a certain amount of points
    func score(points: Int) {
        
        // TODO: Customize!
        
        self.currentScore = self.currentScore + points
    }
    
    // Keep tracks of the duration of the current session in number of seconds
    @Published var sessionDuration: TimeInterval = 121
    
    func decreaseSessionTime(by timeIncrement: TimeInterval) {
        self.sessionDuration = self.sessionDuration - timeIncrement
    }
    
    func restartGame() {
        
        // TODO: Customize!
        
        self.setUpGame()
    }
    
    // Game Over Conditions
    @Published var isGameOver: Bool = false
    
    func finishTheGame() {
        if self.isGameOver == false {
            self.isGameOver = true
        }
    }
    
}

