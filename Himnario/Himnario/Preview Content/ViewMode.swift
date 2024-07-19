//
//  ViewMode.swift
//  Himnario
//
//  Created by Student 12 on 7/19/24.
//

import SwiftUI

struct ViewMode: View {
    @State var song: SongModel
    @Environment(\.dismiss) var dismiss
    @State var showEdit = false
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
               
                    Text(song.lyrics)
                }
            }
        }
        .navigationTitle(song.title)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                }
                
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button {
                    showEdit.toggle()
                } label: {
                    Text(Image(systemName: "square.and.pencil"))
                        .font(.headline)
                }

            }
        }.sheet(isPresented: $showEdit, content: {
            SongView(isEdit: true, songViewModel: song)
        })
    }
}

//#Preview {
//    ViewMode()
//}
