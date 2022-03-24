//
//  ContentView.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 22/03/22.
//

import SwiftUI
import SpriteKit


struct ContentView: View {
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
                
                VStack {
                    TopLayout()
                        .padding([.top, .bottom])
                        .position(x: geometry.size.width/2, y: geometry.frame(in: .global).minY + 60)
                    Button{
                        if !isCombining {
                            isCombining = true
                            scene.isCombining = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                scene.isCombining = false
                                isCombining = false
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
