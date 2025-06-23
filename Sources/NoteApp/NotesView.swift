import SwiftUI

struct NoteListView: View {
  var folder: Folder
  @Binding var selectedNoteID: Note.ID?

  var body: some View {
    List(folder.notes, selection: $selectedNoteID) { note in
      VStack(alignment: .leading) {
        Text(note.title)
          .font(.title3)
        HStack {
          Text(note.updatedDate, format: .dateTime.year().month().day())
          Text(note.subTitle)
        }
        .foregroundStyle(.secondary)
      }
      .tag(note.id)
    }
    .navigationTitle(folder.name)
  }
}

#Preview {
  @Previewable @State var selectedNoteID: Note.ID?
  
  NavigationSplitView {
    NoteListView(folder: .folder1, selectedNoteID: $selectedNoteID)
  } detail: {
    if let note = Folder.folder1.notes.first(where: { $0.id == selectedNoteID }) {
      NoteDetailView(note: note)
    }
  }
}
