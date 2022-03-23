//
//  TopLayoutView.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 22/03/22.
//

import SwiftUI

struct TopLayout: View {
    var body: some View {
        VStack {
            HStack() {
                Text(LocalizedStringKey("Score: "))
                    .font(.custom("Minecraft", size: 24))
                    .foregroundColor(.white)
                    .frame(alignment: .leading)
                Spacer()
                Text("1:20")
                    .font(.custom("Minecraft", size: 24))
                    .foregroundColor(.white)
                    .frame(alignment: .trailing)
            }
            
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 50, alignment: .center)
                .foregroundColor(.accentColor)
                .overlay {
                    Text(LocalizedStringKey("If only I had a cat that could slay dragons…"))
                        .foregroundColor(.white)
                        .font(.custom("Minecraft", size: 24))
                    
                }
        }
        .frame(width: 600, alignment: .center)
    }
}

struct TopLayout_Previews: PreviewProvider {
    static var previews: some View {
        TopLayout().previewInterfaceOrientation(.landscapeRight).background(.black)
    }
}
