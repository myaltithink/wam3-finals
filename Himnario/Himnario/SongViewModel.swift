//
//  SongViewModel.swift
//  Himnario
//
//  Created by Student 12 on 7/13/24.
//

import Foundation


import SwiftUI

@Observable class SongViewModel {
    
    // Input
    var code: String = ""
    var title: String = ""
    var lyrics: String = ""
       
    init(songModel: SongModel? = nil) {
        
        if let songModel = songModel {
            self.code = songModel.code
            self.title = songModel.title
            self.lyrics = songModel.lyrics
        }
        
    }
}
