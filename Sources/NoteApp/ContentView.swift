import SwiftUI

struct ContentView: View {
  @State var text = ""
  @State var isPresentedNewNoteView = false
  @State var selectedFolderID: Folder.ID?
  @State var selectedNoteID: Note.ID?
  @State var isExpandedICloudSection = true
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
        Section("iCloud", isExpanded: $isExpandedICloudSection) {
          ForEach(folders) { folder in
            FolderCell(folder: folder)
              .tag(folder.id)
          }
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
        #if !os(macOS)
        ToolbarItem(placement: .topBarTrailing) {
          Button("New Folder", systemImage: "folder.badge.plus") {
            
          }
        }
        ToolbarItem(placement: .topBarTrailing) {
          EditButton()
        }
        
        DefaultToolbarItem(kind: .search, placement: .bottomBar)
        ToolbarSpacer(.fixed, placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
          Button("New Note", systemImage: "square.and.pencil") {
            isPresentedNewNoteView.toggle()
          }
        }
        #endif
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
    #if os(macOS)
    .tint(.yellow)
    #endif
  }
}

#Preview {
  ContentView()
}

struct FolderCell: View {
  #if !os(macOS)
  @Environment(\.editMode) var editMode
  #endif
  let folder: Folder
  
  var body: some View {
    Label {
      HStack {
        Text(folder.name)
        
        Spacer()
        
        #if !os(macOS)
        if self.editMode?.wrappedValue == .active {
          Menu {
            Button("Share Folder", systemImage: "person.crop.circle.badge.plus") {
              
            }
            Button("Add Folder", systemImage: "folder.badge.plus") {
              
            }
            Button("Move This Folder", systemImage: "folder") {
              
            }
            Button("Rename", systemImage: "pencil") {
              
            }
            @Bindable var folder = folder
            
            Picker(selection: $folder.groupByDateMode) {
              ForEach(GroupByDateMode.allCases, id: \.self) { mode in
                Text(mode.label)
                  .tag(mode)
              }
            } label: {
              Label {
                Text("Group By Date")
                Text(folder.groupByDateMode.label)
                  .foregroundStyle(.secondary)
              } icon: {
                Image(systemName: "calendar")
              }
            }
            .pickerStyle(.menu)

            Button("Delete", systemImage: "trash", role: .destructive) {
              
            }
            
            Divider()
            
            Button("Convert to Smart Folder", systemImage: "gearshape") {
              
            }
          } label: {
            Image(systemName: "ellipsis.circle")
              .foregroundStyle(.yellow)
          }
          .buttonStyle(.borderless)
        }
        #endif
      }
    } icon: {
      Image(systemName: "folder")
      #if !os(macOS)
        .foregroundStyle(.yellow)
      #endif
    }
  }
}
