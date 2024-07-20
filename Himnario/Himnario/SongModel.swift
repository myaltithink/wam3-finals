//
//  Model.swift
//  Himnario
//
//  Created by Student 12 on 7/13/24.
//

import Foundation

import SwiftUI
import SwiftData

@Model class SongModel {

    var code: String = ""
    var title: String = ""
    var lyrics: String = ""
    var isFavorite: Bool = false
    
    init(code: String, title: String, lyrics: String, isFavorite: Bool) {
        self.code = code
        self.title = title
        self.lyrics = lyrics
        self.isFavorite = isFavorite
    }
}
