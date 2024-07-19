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
}
