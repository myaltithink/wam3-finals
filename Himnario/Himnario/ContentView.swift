//
//  ContentView.swift
//  Himnario
//
//  Created by Student 13 on 7/13/24.
//

import SwiftUI

struct ContentView: View {
    @State var isActive: Bool = false
    var body: some View {
        VStack {
            if self.isActive {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }else {
                SplashScreen()
            }
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
