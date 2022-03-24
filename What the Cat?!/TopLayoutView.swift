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
    
    let formatter = DateComponentsFormatter()

//    formatter.allowedUnits = [.hour, .minute]
    
    @Binding var isShowingQuest: Bool
    @State var quest = ""
    
    @State var quests: [String: (String, String, String)] = ["Warrior Cat": ("I need a cat that can fight with me!", "I'm a soldier, but I wish I had a cat…", "If only I had a cat that could slay dragons…"), "Hunter Cat": ("I feel so alone while hunting…", "I have a problem with some mice… on the roof.", "I'm so bored… and all I have are these apples")]
    
    var body: some View {
        VStack {
            HStack() {
                Text(LocalizedStringKey("Score: \(score)"))
                    .font(.custom("Minecraft", size: 24))
                    .foregroundColor(.white)
                    .frame(alignment: .leading)
                Spacer()
                Text("\(formatter.string(from: gameLogic.sessionDuration)!)")
                    .font(.custom("Minecraft", size: 24))
                    .foregroundColor(.white)
                    .frame(alignment: .trailing)
            }
            
            if isShowingQuest {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50, alignment: .center)
                    .foregroundColor(.accentColor)
                    .overlay {
    //                    Text(LocalizedStringKey("If only I had a cat that could slay dragons…"))
    //                        .foregroundColor(.white)
    //                        .font(.custom("Minecraft", size: 24))
                        Text(quest)
                            .foregroundColor(.white)
                            .font(.custom("Minecraft", size: 24))
                        
                    }
                    .onAppear {
                        var index = Int.random(in: 0...2)
                        
                        switch(index) {
                        case 0:
                            quest = quests.values.randomElement()!.0
                            break
                        case 1:
                            quest = quests.values.randomElement()!.1
                            break
                        case 2:
                            quest = quests.values.randomElement()!.2
                            break
                        default:
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
        TopLayout(score: .constant(0), isShowingQuest: .constant(false)).previewInterfaceOrientation(.landscapeRight).background(.black)
    }
}
