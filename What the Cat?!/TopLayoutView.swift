//
//  TopLayoutView.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 22/03/22.
//

import SwiftUI

struct TopLayout: View {
    var gameLogic: ArcadeGameLogic =  ArcadeGameLogic.shared
    @Binding var score: Int
    @Binding var questLevel: Int
    @Binding var questSolution: String
        
    @Binding var isShowingQuest: Bool
    @State var quest = ""
    
    var body: some View {
        VStack {
            if isShowingQuest {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50, alignment: .center)
                    .foregroundColor(.accentColor)
                    .overlay {
                        Text(quest)
                            .foregroundColor(.white)
                            .font(.custom("Minecraft", size: 24))
                        
                    }
                    .onAppear {
                        let index = Int.random(in: 0...2)
                        
                        switch(index) {
                        case 0:
                            let arrayOfQuests = firstLevelQuests.values.randomElement()!
                            quest = arrayOfQuests.randomElement()!
                            questLevel = 1
                            if let solutionIndex = firstLevelQuests.values.firstIndex(of: arrayOfQuests) {
                                questSolution = firstLevelQuests.keys[solutionIndex]
                            }
                            break
                        case 1:
                            let arrayOfQuests = secondLevelQuests.values.randomElement()!
                            quest = arrayOfQuests.randomElement()!
                            questLevel = 2
                            if let solutionIndex = secondLevelQuests.values.firstIndex(of: arrayOfQuests) {
                                questSolution = secondLevelQuests.keys[solutionIndex]
                            }
                            break
                        case 2:
                            let arrayOfQuests = thirdLevelQuests.values.randomElement()!
                            quest = arrayOfQuests.randomElement()!
                            questLevel = 3
                            if let solutionIndex = thirdLevelQuests.values.firstIndex(of: arrayOfQuests) {
                                questSolution = thirdLevelQuests.keys[solutionIndex]
                            }
                            break
                        default:
                            quest = "No Quest Found!"
                            break
                        }
                }
            }
        }
        .frame(width: 600, alignment: .center)
    }
}

struct TopLayout_Previews: PreviewProvider {
    static var previews: some View {
        TopLayout(score: .constant(0), questLevel: .constant(0), questSolution: .constant(""), isShowingQuest: .constant(true)).previewInterfaceOrientation(.landscapeRight).background(.black)
    }
}
