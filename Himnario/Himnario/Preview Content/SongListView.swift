//
//  SongListView.swift
//  Himnario
//
//  Created by Student 12 on 7/19/24.
//

import SwiftUI
import SwiftData


var selectedSong: SongModel = SongModel(code: "", title: "", lyrics: "")
struct SongListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var songs: [SongModel]
    @State private var searchText = ""
    @State private var searchResult: [SongModel] = []
    @State private var isSearchActive = false
    @State private var showNewSong = false
    @State private var openEdit = false
    
    var body: some View {
        NavigationStack {
            List {
                if songs.count == 0 {
                    Text("There are currently no song")
                } else {
                    let listItems = isSearchActive ? searchResult : songs
                    ForEach(listItems.indices, id: \.self) { index in
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: ViewMode(song: listItems[index])) {
                                EmptyView()
                            }
                            .opacity(0)
                            
                            BasicTextImageRow(song: listItems[index])
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                openEdit.toggle()
                                selectedSong = listItems[index]
                            } label: {
                                Text("Edit")
                            }
                            .tint(Color.green)

                        }
                    }
                    .onDelete(perform: deleteRecord)
                    .listRowSeparator(.hidden)
                    .sheet(isPresented: $openEdit, content: {
                            SongView(isEdit: true, songViewModel: selectedSong)
                    })
                }
            }
            .listStyle(.plain)
            
            .navigationTitle("Himnario Songs")
            .navigationBarTitleDisplayMode(.automatic)
            
            .toolbar {
                Button(action: {
                    self.showNewSong = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }.tint(.primary)
            .sheet(isPresented: $showNewSong) {
                SongView(isEdit:false, songViewModel: SongModel(code: "", title: "", lyrics: ""))
            }
            .searchable(text: $searchText, isPresented: $isSearchActive, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Songs..")
            .onChange(of: searchText) { oldValue, newValue in
                let predicate = #Predicate<SongModel> { $0.title.localizedStandardContains(newValue) ||
                    $0.code.localizedStandardContains(newValue)
                }
                
                let descriptor = FetchDescriptor<SongModel>(predicate: predicate)
            
                if let result = try? modelContext.fetch(descriptor) {
                    searchResult = result
                }
            }
    }
    
    
    private func deleteRecord(indexSet: IndexSet) {
          for index in indexSet {
              let itemToDelete = songs[index]
              modelContext.delete(itemToDelete) 
              
          }
        do {
            try modelContext.save()
        } catch {
            print("Error deleting item: \(error)")
        }
    }
}


struct BasicTextImageRow: View {
    // MARK: - Binding
    
    @Bindable var song: SongModel
    
    // MARK: - State variables
    
    @State private var showOptions = false
    @State private var showEdit = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
         
            VStack(alignment: .leading) {
                Text(song.title)
                    .font(.system(.title2, design: .rounded))
                
                Text(song.code)
                    .font(.system(.body, design: .rounded))

            }
            
//            if song.isFavorite {
//                Spacer()
//                
//                Image(systemName: "heart.fill")
//                    .foregroundStyle(.yellow)
//            }
        }
        .contextMenu {
            Button(action: {
                self.showEdit.toggle()
            }) {
                HStack {
                    Text("Edit")
                    Image(systemName: "pencil")
                }
            }
            
//            Button(action: {
//                self.restaurant.isFavorite.toggle()
//            }) {
//                HStack {
//                    Text(restaurant.isFavorite ? "Remove from favorites" : "Mark as favorite")
//                    Image(systemName: "heart")
//                }
//            }
            
            Button(action: {
                self.showOptions.toggle()
            }) {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .sheet(isPresented: $showEdit) {
            
            SongView(isEdit:true, songViewModel: song)
        }
        .sheet(isPresented: $showOptions) {
            
            let defaultText = "Share ko lang \(song.title)"
            
            ActivityView(activityItems: [defaultText])
        }
    }
}
#Preview {
    SongListView()
}
