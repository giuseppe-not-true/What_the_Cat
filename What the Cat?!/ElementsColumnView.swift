//
//  ElementsColumnView.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 22/03/22.
//

import Foundation
import SwiftUI

struct ElementsColumn: View {
    let size: CGFloat = 60.0
    @State var isHidden = true
    @State var elementSelected = -1
    @State var isMoving = false
    @State var pos = CGPoint()
    //    @Binding var pos: CGPoint
//    @Binding var cat: Image
//    @State var negative: Bool
    @State var position = CGPoint()
    
    var body: some View {
        VStack(spacing: 25) {
            ForEach((0..<6), id: \.self) {itemSelected in
                GeometryReader { geometry in
                    Button {
                        elementSelected = itemSelected
                        
                        if !isMoving {
                            isMoving = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                
                            }
                        } else {
                            position.x = geometry.frame(in: .local).midX
                            position.y = geometry.frame(in: .local).midY
                            isMoving = false
                        }
                        
                        if isHidden {
                            isHidden = false
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                                isHidden = true
                            }
                        }
                        
                    } label: {
                        VStack(spacing: 0) {
                            ZStack {
                                Image("sword")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .scaledToFit()
                                
                                if !isHidden && itemSelected == elementSelected {
                                    Button {
                                        isMoving = false
                                    } label: {
                                        Image("sword")
                                            .resizable()
                                            .frame(width: 45, height: 45)
                                            .scaledToFit()
                                    }
                                    .position(position)
                                    .animation(.linear, value: position)
                                }
                            }
                            
                            Image("shelf")
                                .resizable()
                                .frame(width: 45, height: 15)
                                .scaledToFit()
                        }
                        .frame(width: size, height: size)
                    }
                }
            }
        }
        .padding()
    }
}
