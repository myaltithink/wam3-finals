//
//  SongView.swift
//  Himnario
//
//  Created by Student 12 on 7/13/24.
//

import SwiftUI
import Foundation
import SwiftData

private let emptyRegex = "^\\s*$"
private let numberRegex = "^[0-9]*$"

struct SongView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State var isEdit = false
    @State  var showPhotoOptions = false
    
    @State var hasError = false
    @State var codeAlreadyExists = false
    
    @Bindable var songViewModel: SongModel
    
    @Query var songs: [SongModel]
    
    
    var body: some View {
        NavigationStack {

            ScrollView {
                VStack {
                    
                    FormTextField(label: "Song Code", placeholder: "Enter the Song Code", value: $songViewModel.code)
                    
                    FormTextField(label: "Song Title", placeholder: "Enter the Song Title", value: $songViewModel.title)
                    
                    FormTextView(label: "Song Lyrics", value: $songViewModel.lyrics, height: 350)
                    
                }
                .padding()
                
                .alert("Invalid Field Detected", isPresented: $hasError){
                    Button("Close") {
                        hasError.toggle()
                    }
                }
                .alert("Song Code Already Exists", isPresented: $codeAlreadyExists) {
                    Button("Close"){
                        codeAlreadyExists.toggle()
                    }
                }
                
            }
            
            // Navigation bar configuration
            .navigationTitle(isEdit ? "Edit Song" : "New Song")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(red: 220/255, green: 181/255, blue: 76/255))
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        save()
                        dismiss()
                    } label: {
                        Text(isEdit ? "Update" : "Save")
                            .font(.headline)
                            .foregroundColor(Color(red: 220/255, green: 181/255, blue: 76/255))
                    }

                }
            }
        }
        
    }
    
    private func save() {
        
        print("code validation")
        print("invalid number: \(!songViewModel.code.matches(numberRegex))")
        print("code empty: \(songViewModel.code.matches(emptyRegex))")
        
        print("title validation")
        print("title empty: \(songViewModel.title.matches(emptyRegex))")
        
        print("lyrics validation")
        print("lyrics empty: \(songViewModel.lyrics.matches(emptyRegex))")
        
        
        if !songViewModel.code.matches(numberRegex) ||
            songViewModel.code.matches(emptyRegex) ||
            songViewModel.title.matches(emptyRegex) ||
            songViewModel.lyrics.matches(emptyRegex)
        {
            hasError.toggle()
            return
        }
        
        if songs.contains(where: { song in
            song.code == songViewModel.code
        }){
            codeAlreadyExists.toggle()
            return
        }
        
        if isEdit {
            modelContext.insert(songViewModel)
        }else{
            let song = SongModel(code: songViewModel.code,
                                        title: songViewModel.title,
                                        lyrics: songViewModel.lyrics, isFavorite: false)
            
            
            modelContext.insert(song)

        }
    }
}

struct FormTextField: View {
    let label: String
    var placeholder: String = ""
    
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundStyle(Color(.darkGray))
            
            TextField(placeholder, text: $value)
                .font(.system(.body, design: .rounded))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                .padding(.vertical, 10)
                
        }
    }
}

struct FormTextView: View {
    
    let label: String
    
    @Binding var value: String
    
    var height: CGFloat = 200.0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundStyle(Color(.darkGray))
            
            TextEditor(text: $value)
                .frame(maxWidth: .infinity)
                .frame(minHeight: height, maxHeight: .infinity)
                .padding(10)
                .scrollContentBackground(.hidden)
                .overlay(
                    
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)

                ).background(Color(red: 248/255, green: 246/255, blue: 234/255))
                .padding(.top, 10)
                
        }
    }
}

#Preview("FormTextField", traits: .fixedLayout(width: 300, height: 200)) {
    FormTextField(label: "Title", placeholder: "Enter song title", value: .constant(""))
}

#Preview("FormTextView", traits: .sizeThatFitsLayout) {
    FormTextView(label: "Lyrics", value: .constant(""))
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
