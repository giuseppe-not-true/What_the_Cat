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
    
    let formatter = DateComponentsFormatter()

//    formatter.allowedUnits = [.hour, .minute]
    
    @Binding var isShowingQuest: Bool
    @State var quest = ""
    
    @State var firstLevelQuests: [String: [String]] = ["Warrior Cat": ["I need a cat that can fight with me!", "I'm a soldier, but I wish I had a cat…", "If only I had a cat that could slay dragons…"], "Hunter Cat": ["I feel so alone while hunting…", "I have a problem with some mice… on the roof.", "I'm so bored… and all I have are these apples"], "Wizard Cat": ["I have to study some ancient runes but I don't want to do it alone.", "Fireball!", " I need someone that could help me with my homeworks!"], "Cat in the boot": ["I only have one leg and a lot of spare shoes!", "I have a snake in my boot!", "I want something to keep my feets warm…"], "Funky Cat": ["I just want to party!", "ah-ah-ah-ah stayin alive stayin alive… ", "Let’s have some fun!"], "Anti-gravitatory Cat": ["I'm studying the paradox of physics, do you have something that can help?", "It’s so hot today, do you have a fan or something?", "If only I had something to make my boat go faster…"], "Nuclear Cat": ["I need more energy for my experiments!", "I want a shiny one!", "I want to be easy to find in the dark."], "Eurekat": ["I really need an idea…", "I have the solution on the tip of my tongue…", "?????????"], "Shrekat": ["SOMEbody once told me the world is gonna roll me...", "I love dirty kitties.", "I need a cat that likes donkeys."], "Chubby Cat": ["I love eating, I want a cat like me!", "I want a slow cat", "I just want to eat and sleep with my cat"], "Evil Cat": ["I don’t like “good boys” ", "I drink orange juice after washing my teeths.", "I hate the world! "], "Karate Cat": ["I love Street Fighting", "I need someone to train me!", "Wax on Wax off…"]]
    
    @State var secondLevelQuests: [String: [String]] = ["Pope Cat": ["I’d love to bring my cat to church!", "I need a cat to heal the wounds of my soul", "Some holy magic would help me"], "Puss in Boots": ["I want a cat that can do this “*-*” ", "I need a heroic swordsman!", "There was a fairytale about a cat…"], "Nyan Cat": ["Nyan nyan nyan nyan nyan nyan", "I had the strangest dream.. there was this magic cat with hypnotic music and a rainbow…", "Ehy, what about a flying and singing cat?"], "Catfish": ["I heard that someone has seen a cat mermaid!", "Is there any cat that can swim?", "I discovered the girl I was talking to was actually a married man, do you have any advice?"], "Exploding Kitty": ["BOOM", "Do you have a cat that can help in the mines?", "I heard about this card game that broke every record…"], "Nekomancer": ["I need someone to help me do my blood rituals", "I'm trying to summon the dark lord, any advice?", "I love sacrifices and kittens, something for me?"], "Subfeline": ["We all live in a yellow…", "I love deep diving but I'd like more light…", "If only there was a way to travel by sea and have a look at what's under the water…"], "Uncat": ["I’d love to have a cat that doesn't need food or water… or air.", "I’d love to have someone to keep me company at the cemetery.", "I loved my old cat, I don't want another one."], "Ninja Cat": ["I need a cat that is deadly silent.", "I love being one with the shadows…", "I want to be Hokage!"], "Jedi Cat": ["May the force be with you.", "What about a Space Paladin?", "I’d love a cat that can bring me things with telekinesis"], "Supercat": ["Is it a bird? is it a plane? it’s…", "I need the most heroic cat you have!", "What about a flying cat?"]]
    
    @State var thirdLevelQuests: [String: [String]] = ["Sith Cat": ["May the force be with you, but make it evil", "What about a Space AntiPaladin?", "I'd love a cat that can take things with telekinesis and throw them on the face of random people!"], "Cat Norris": ["I want the strongest cat you have!", "I'm a ranger that loves to walk in Texas", "For the eyes of the ranger are upon you!"], "The Cat wears Purrrada": ["I want the most fabulous cat you have!", "I’ve seen the scariest woman in the world! Her name was ”Miranda”", "Im going to the Fashion week, help me!"], "Cathulhu": ["ph'nglui mglw'nafh Cathulhu R'lyeh wgah'nagl fhtagn.", "I just want to destroy the world…", "I keep hearing strange voices from the deep…"], "Dalai Cat": ["I wish to reach Nirvana", "I want more clarity in my life", "I just wish for a guide"]]
    
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
        TopLayout(score: .constant(0), questLevel: .constant(0), questSolution: .constant(""), isShowingQuest: .constant(false)).previewInterfaceOrientation(.landscapeRight).background(.black)
    }
}
