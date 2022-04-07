//
//  MenuView.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 07/04/22.
//

import Foundation
import SwiftUI

struct MenuView: View {
    @Binding var currentGameState: GameState
    
    var body: some View {
        ZStack {
            Image("vapor-bg")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("What the Cat?!")
                    .foregroundColor(.white)
                    .font(.custom("Minecraft", size: 70))
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.clear)
                        .overlay {
                            ZStack {
                                Image("button")
                                    .resizable()
                                Text("Guess what the customers need in the time frame.")
                                    .foregroundColor(.white)
                                    .font(.custom("Minecraft", size: 30))
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                        }
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.clear)
                        .overlay {
                            ZStack {
                                Image("button")
                                    .resizable()
                                Text("Add up to three elements to the box by tapping them.")
                                    .foregroundColor(.white)
                                    .font(.custom("Minecraft", size: 30))
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                        }
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.clear)
                        .overlay {
                            ZStack {
                                Image("button")
                                    .resizable()
                                Text("Click \"Combine\" to cast the cat.")
                                    .foregroundColor(.white)
                                    .font(.custom("Minecraft", size: 30))
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                        }
                }
                
                Text("Tap to play!")
                    .foregroundColor(.white)
                    .font(.custom("Minecraft", size: 30))
            }
            .padding()
            
        }
        .onTapGesture {
            currentGameState = .playing
        }
    }
}

struct MenuView_Preview: PreviewProvider {
    static var previews: some View {
        MenuView(currentGameState: .constant(.mainScreen)).previewInterfaceOrientation(.landscapeRight)
    }
}
