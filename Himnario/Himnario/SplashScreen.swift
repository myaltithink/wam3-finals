//
//  SplashScreen.swift
//  Himnario
//
//  Created by Student 13 on 7/13/24.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack{
            VStack{
                Image("himnario loading")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                
                Text("Himnario App")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

#Preview {
    SplashScreen()
}
