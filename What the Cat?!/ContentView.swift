//
//  ContentView.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 22/03/22.
//

import SwiftUI
import SpriteKit
import AVFoundation

struct ContentView: View {
    @StateObject var gameLogic: ArcadeGameLogic =  ArcadeGameLogic.shared
    @State var score = 0
    @State var isShowingQuest = false
    @State var questLevel = 0
    @State var questSolution = ""
    @State var resultCat = ""
    
    @State var isHiding = true
    @State var isMoving = false
    
    @State var posElement = CGPoint()
    let scene = BoxScene()
    @State var posCat = CGPoint()
    @State var center = CGPoint()
    @State var isCombining = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SpriteView(scene: scene, options: [.allowsTransparency])
                    .frame(alignment: .center)
                    .ignoresSafeArea()
                    .onChange(of: scene.resultCat.name) {newValue in
                        resultCat = newValue!
                    }
                    .onChange(of: gameLogic.isGameOver) {_ in
                        
                    }
                
                VStack {
                    TopLayout(score: $score, questLevel: $questLevel, questSolution: $questSolution, isShowingQuest: $isShowingQuest)
                        .padding([.top, .bottom])
                        .position(x: geometry.size.width/2, y: geometry.frame(in: .global).minY + 60)
                        .onAppear {
                            withAnimation {
                                isShowingQuest = true
                            }
                        }
                    
                    Button{
                        if !isCombining {
                            withAnimation {
                                isShowingQuest = false
                                self.scene.isCombining = true
                                self.scene.solution = questSolution
//                                gameLogic.score(points: 2)
                                
                                
                                print(questSolution)
                                print(resultCat)
                                
//                                print(self.scene.solution)
//                                if resultCat == questSolution {
//                                    gameLogic.score(points: 2)
//                                } else if self.scene.resultCat.name == "Cat-astrophe"{
//                                    gameLogic.score(points: -1)
//                                }
                                
                                
                                self.score = gameLogic.currentScore
                            }
                            
                            isCombining = true
                            scene.isCombining = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                scene.isCombining = false
                                isCombining = false
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                withAnimation {
                                    isShowingQuest = true
                                }
                            }
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .overlay {
                                Text(LocalizedStringKey("Combine"))
                                    .foregroundColor(.white)
                                    .font(.custom("Minecraft", size: 30))
                            }
                            
                    }
                    .frame(width: 200, height: 50, alignment: .center)
                    .position(x: geometry.size.width/2, y: geometry.frame(in: .global).midY - 30)
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewInterfaceOrientation(.landscapeRight)
    }
}
