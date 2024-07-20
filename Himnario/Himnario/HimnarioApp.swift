//
//  HimnarioApp.swift
//  Himnario
//
//  Created by Student 13 on 7/13/24.
//

import SwiftUI
import SwiftData

@main
struct HimnarioApp: App {
    @State var isActive: Bool = false
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: SongModel.self)
    }
    
//    init() {
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle") ??
//                                                     UIColor.black, .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle") ??
//                                                UIColor.black, .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
//        navBarAppearance.backgroundColor = UIColor(Color(Color(red: 220/255, green: 181/255, blue: 76/255)))
//        navBarAppearance.backgroundEffect = .none
//        navBarAppearance.shadowColor = .clear
//        
//        UINavigationBar.appearance().standardAppearance = navBarAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//        UINavigationBar.appearance().compactAppearance = navBarAppearance
//    }
}

