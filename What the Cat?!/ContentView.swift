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
    @State var currentGameState: GameState = .mainScreen
    @State var isGameOver = false
    
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
    @State var hasClickClear = false
    
    var body: some View {
        switch (currentGameState) {
        case .mainScreen:
            MenuView(currentGameState: $currentGameState)
        case .playing:
            GeometryReader { geometry in
                ZStack {
                    SpriteView(scene: scene, options: [.allowsTransparency])
                        .frame(alignment: .center)
                        .ignoresSafeArea()
                        .onChange(of: gameLogic.sessionDuration) { newValue in
                            if gameLogic.sessionDuration <= 0 {
                                isGameOver = true
                            } else {
                                isGameOver = false
                            }
                        }
                    
                    VStack {
                        if !isGameOver {
                            TopLayout(score: $score, questLevel: $questLevel, questSolution: $questSolution, isShowingQuest: $isShowingQuest)
                                .padding([.top, .bottom])
                                .position(x: geometry.size.width/2, y: /*geometry.frame(in: .global).minY + 80*/ geometry.size.height * 0.12)
                                .onAppear {
                                    withAnimation {
                                        isShowingQuest = true
                                    }
                                }
                        }
                        
                        if !isGameOver {
                            HStack {
                                Button {
                                    if !hasClickClear {
                                        scene.hasClickClear = true
                                        hasClickClear = true
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        scene.hasClickClear = false
                                        hasClickClear = false
                                    }
                                } label: {
                                    //                            RoundedRectangle(cornerRadius: 10)
                                    Image("button")
                                        .resizable()
                                        .overlay {
                                            Text(LocalizedStringKey("Clear"))
                                                .foregroundColor(.white)
                                                .font(.custom("Minecraft", size: 30))
                                        }
                                    
                                }
                                .frame(width: 200, height: 50, alignment: .center)
                                
                                Button{
                                    if !isCombining {
                                        withAnimation {
                                            isShowingQuest = false
                                            self.scene.isCombining = true
                                            self.scene.solution = questSolution
                                        }
                                        
                                        isCombining = true
                                        scene.isCombining = true
                                        
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                            scene.isCombining = false
                                            isCombining = false
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                                            withAnimation {
                                                isShowingQuest = true
                                            }
                                        }
                                    }
                                } label: {
                                    //                            RoundedRectangle(cornerRadius: 10)
                                    Image("button")
                                        .resizable()
                                        .overlay {
                                            Text(LocalizedStringKey("Combine"))
                                                .foregroundColor(.white)
                                                .font(.custom("Minecraft", size: 30))
                                        }
                                    
                                }
                                .frame(width: 200, height: 50, alignment: .center)
                            }
                        }
                    }
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
