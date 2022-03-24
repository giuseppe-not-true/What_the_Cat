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
    @State var elementSelected = -1
    @State var initialPos = CGPoint(x: -300, y: 50)
    @Binding var pos: CGPoint
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
    }
}
