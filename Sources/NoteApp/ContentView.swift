import SwiftUI

struct ContentView: View {
  @State var text = ""
  @State var isPresentedNewNoteView = false
  @State var selectedFolderID: Folder.ID?
  @State var selectedNoteID: Note.ID?
  @State var folders: [Folder] = [
    .init(
      name: "Folder1",
      notes: [
        .init(title: "Title1", subTitle: "SubTitle1", content: "Content1"),
        .init(title: "Title2", subTitle: "SubTitle2", content: "COntent2")
      ]
    ),
    .init(name: "Folder2", notes: []),
    .init(name: "Folder3", notes: []),
    .init(name: "Folder4", notes: []),
    .init(name: "Folder5", notes: []),
    .init(name: "Folder6", notes: []),
    .init(name: "Folder7", notes: []),
    .init(name: "Folder8", notes: []),
  ]
  
  var body: some View {
    NavigationSplitView {
      List(selection: $selectedFolderID) {
        Section("iCloud") {
          ForEach(folders) { folder in
            Label {
              Text(folder.name)
            } icon: {
              Image(systemName: "folder")
                .foregroundStyle(.yellow)
            }
              .tag(folder.id)
          }
          .onDelete { folders.remove(atOffsets: $0) }
          .onMove { folders.move(fromOffsets: $0, toOffset: $1) }
        }
        
        Section("Tags") {
          ScrollView(.horizontal) {
            LazyHStack {
              
            }
          }
        }
      }
      .searchable(text: $text)
      .navigationTitle("Folders")
      .sheet(isPresented: $isPresentedNewNoteView) {
        NewNoteView()
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("New Folder", systemImage: "folder.badge.plus") {
            
          }
        }
        #if !os(macOS)
        ToolbarItem(placement: .topBarTrailing) {
          EditButton()
        }
        #endif
        
        DefaultToolbarItem(kind: .search, placement: .bottomBar)
        ToolbarSpacer(.fixed, placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
          Button("New Note", systemImage: "square.and.pencil") {
            isPresentedNewNoteView.toggle()
          }
        }
      }
    } content: {
      if let selectedFolderID, let folder = folders.first(where: { $0.id == selectedFolderID }) {
        NoteListView(folder: folder, selectedNoteID: $selectedNoteID)
      }
    } detail: {
      if let note = folders.first(where: { $0.id == selectedFolderID })?.notes.first(where: { $0.id == selectedNoteID }) {
        NoteDetailView(note: note)
      }
    }
  }
}

#Preview {
  ContentView()
}

