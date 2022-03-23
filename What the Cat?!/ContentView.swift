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
//    @State var cat = Image("catto")
    let scene = BoxScene()
    @State var posCat = CGPoint()
    @State var center = CGPoint()
    
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
        
        
//        GeometryReader { geometry in
//            
//            HStack {
//                GeometryReader { elements in
//                    VStack(spacing: 30){
//                        ForEach((0..<6), id: \.self) {itemSelected in
//                            Element(pos: $center, isMoving: $isMoving, isHiding: $isHiding)
//                                .padding(.trailing)
//                                .zIndex(1)
//                                .position(isMoving == true ? center : CGPoint(x: elements.frame(in: .local).midX-10, y: elements.frame(in: .local).midY-185))
//                                .animation(.linear, value: isMoving)
//                                .onAppear {
//                                    center.x = elements.frame(in: .local).midX
//                                    center.y = elements.frame(in: .local).midY
//                                }
//
//                        }
//                    }
//                    .padding()
//                }
//                
//                VStack {
//                    TopLayout()
//                        .padding([.top, .bottom])
//                    
//                    GeometryReader { box in
//                        SpriteView(scene: scene, options: [.allowsTransparency])
//                                .frame(width: 300, height: 200, alignment: .center)
//                                .position(x: box.frame(in: .local).midX, y: box.frame(in: .local).midY)
//                            
////                                Image("box open")
////                                    .resizable()
////                                    .scaledToFit()
////
////                                cat
////                                    .resizable()
////                                    .frame(width: 100, height: 100, alignment: .center)
////                                    .scaledToFit()
////                                    .position(x: box.frame(in: .local).midX, y: box.frame(in: .local).midY - 55)
//                        
//                    }
//                        
//                    Button{
//                    } label: {
//                        RoundedRectangle(cornerRadius: 10)
//                            .frame(width: 200, height: 50, alignment: .center)
//                            .overlay {
//                                Text(LocalizedStringKey("Combine"))
//                                    .foregroundColor(.white)
//                                    .font(.custom("Minecraft", size: 30))
//                            }
//                    }
//                }
//                
//                
//                VStack(spacing: 30){
//                    ForEach((0..<6), id: \.self) {itemSelected in                    Element(pos: $center, isMoving: $isMoving, isHiding: $isHiding)
//                            .padding(.leading)
//                            .zIndex(1)
//                            .position(center)
//                            .animation(.linear, value: center)
//                    }
//                }
//                .padding()
//            }
//            
//        }
//        .coordinateSpace(name: "scene")
//        .background(Color("WoodBrown"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewInterfaceOrientation(.landscapeRight)
    }
}
