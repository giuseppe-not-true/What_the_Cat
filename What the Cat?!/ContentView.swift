//
//  ContentView.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 22/03/22.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        GeometryReader { geometry in
            
            HStack {
                ElementsColumn()
                    .padding(.trailing)
                
                Spacer()
                
                VStack {
                    TopLayout()
                    
                        ZStack {
                            Image("box open")
                                .resizable()
                                .scaledToFit()

                            Image("catto")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .scaledToFit()
                                .position(x: 300, y: 50)
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
                
                Spacer()
                
                ElementsColumn()
                    .padding(.leading)
            }
            
        }
        .background(Color("WoodBrown"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewInterfaceOrientation(.landscapeRight)
    }
}
