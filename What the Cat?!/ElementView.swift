//
//  ElementsColumnView.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 22/03/22.
//

import Foundation
import SwiftUI

struct Element: View {
    let size: CGFloat = 60.0
//    @State var isHidden = Array(repeating: true, count: 6)
    @State var elementSelected = -1
//    @State var isMoving = Array(repeating: false, count: 6)
    //    @State var initialPos = CGPoint.zero
    @State var initialPos = CGPoint(x: -300, y: 50)
    @Binding var pos: CGPoint
    //    @Binding var cat: Image
//    @State var negative: Bool
    @State var position = CGPoint()
    
    @Binding var isMoving: Bool
    @Binding var isHiding: Bool
    
    var body: some View {
        GeometryReader{ geometry in
            Button {
                isMoving.toggle()
//                isHiding.toggle()
                
            } label: {
                VStack(spacing: 0) {
                    ZStack {
                        Image("sword")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .scaledToFit()
                    }

                    Image("shelf")
                        .resizable()
                        .frame(width: 45, height: 15)
                        .scaledToFit()
                }
                .frame(width: size, height: size)
            }
            

        }
//        VStack(spacing: 30){
//            ForEach((0..<6), id: \.self) {itemSelected in
//                GeometryReader { geometry in
//                    Button {
//                        elementSelected = itemSelected
//
//                        if !isMoving[itemSelected] {
//                            isMoving[itemSelected] = true
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//                                if negative {
//                                    initialPos = CGPoint(x: -300, y: pos.y)
//                                } else {
//                                    initialPos = CGPoint(x: 300, y: pos.y)
//                                }
//                            }
//                        } else {
//                            initialPos.x = geometry.frame(in: .local).midX
//                            initialPos.y = geometry.frame(in: .local).midY
//                            isMoving[itemSelected] = false
//                        }
//
//                        if isHidden[itemSelected] {
//                            isHidden[itemSelected] = false
//                        } else {
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
//                                isHidden[itemSelected] = true
//                            }
//                        }
//
//                    } label: {
//                        VStack(spacing: 0) {
//                            ZStack {
//                                Image("sword")
//                                    .resizable()
//                                    .frame(width: 45, height: 45)
//                                    .scaledToFit()
//
//                                if !isHidden[itemSelected] && itemSelected == elementSelected {
//                                    Button {
//                                        isMoving[itemSelected] = false
//                                    } label: {
//                                        Image("sword")
//                                            .resizable()
//                                            .frame(width: 45, height: 45)
//                                            .scaledToFit()
//                                    }
//                                    .position(initialPos)
//                                    .animation(.linear, value: initialPos)
//                                }
//                            }
//
//                            Image("shelf")
//                                .resizable()
//                                .frame(width: 45, height: 15)
//                                .scaledToFit()
//                        }
//                        .frame(width: size, height: size)
//                    }
//                    .onAppear {
//                        initialPos.x = geometry.frame(in: .local).midX
//                        initialPos.y = geometry.frame(in: .local).midY
//                    }
//                }
//            }
//        }
//        .padding()
    }
}
