//
//  ContentView.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 22/03/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @State var posElement = CGPoint()
//    @State var cat = Image("catto")
    let scene = BoxScene()
    @State var posCat = CGPoint()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            HStack {
                ElementsColumn(pos: $posCat, negative: false)
                    .padding(.trailing)
                    .zIndex(1)
                
                VStack {
                    TopLayout()
                        .padding([.top, .bottom])
                    
                    GeometryReader { box in
                        SpriteView(scene: scene, options: [.allowsTransparency])
                                .frame(width: 300, height: 200, alignment: .center)
                                .position(x: box.frame(in: .local).midX, y: box.frame(in: .local).midY)
                                .onAppear {
                                    posCat.y = box.frame(in: .local).midY
                                }
                            
//                                Image("box open")
//                                    .resizable()
//                                    .scaledToFit()
//
//                                cat
//                                    .resizable()
//                                    .frame(width: 100, height: 100, alignment: .center)
//                                    .scaledToFit()
//                                    .position(x: box.frame(in: .local).midX, y: box.frame(in: .local).midY - 55)
                        
                    }
                        
                    Button{
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 50, alignment: .center)
                            .overlay {
                                Text(LocalizedStringKey("Combine"))
                                    .foregroundColor(.white)
                                    .font(.custom("Minecraft", size: 30))
                            }
                    }
                }
                
                
                ElementsColumn(pos: $posCat, negative: true)
                    .padding(.leading)
                    .zIndex(1)
            }
            
        }
        .coordinateSpace(name: "scene")
        .background(Color("WoodBrown"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewInterfaceOrientation(.landscapeRight)
    }
}
