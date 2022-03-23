//
//  ElementsColumnView.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 22/03/22.
//

import Foundation
import SwiftUI

struct ElementsColumn: View {
    let size: CGFloat = 50.0
    @State var isHidden = true
    @State var elementSelected = -1
    @State var isMoving = false
    @State var pos = CGPoint(x: -300, y: 40)
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach((0..<6), id: \.self) {itemSelected in
                Button {
                    elementSelected = itemSelected
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        if !isMoving {
                            isMoving = true
                        }
                    }

                    if isHidden {
                        isHidden = false
                    } else {
                        isHidden = true
                    }
                    
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: size, height: size)
                        .foregroundColor(.gray)
                        .shadow(color: itemSelected == elementSelected ? .yellow : .black, radius: 0, x: 3, y: 2)
                        .overlay {
                            ZStack {
                                Image("sword")
                                    .resizable()
                                    .scaledToFit()
                                
                                if !isHidden && itemSelected == elementSelected {
                                    Button {
                                        isMoving = false
                                    } label: {
                                        Image("sword")
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    .position(isMoving == true ? pos : .zero)
                                    .animation(.linear, value: isMoving)
                                }
                            }
                        }
                }
            }
        }
        .padding()
    }
}
