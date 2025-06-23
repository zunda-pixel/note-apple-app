import SwiftUI

struct NoteDetailView: View {
  var note: Note
  @Namespace var namespace
  
  var body: some View {
    @Bindable var note = note
    
    TextEditor(text: $note.content)
      .safeAreaInset(edge: .top) {
        Text(note.updatedDate, format: .dateTime)
      }
      .toolbar {
        ToolbarItem(placement: .navigation) {
          ShareLink(
            item: note,
            preview: SharePreview(
              note.title,
              image: Image(systemName: "star")
            )
          )
        }
        
        ToolbarItemGroup(placement: .navigation) {
          Button {
            
          } label: {
            Image(systemName: "checklist")
          }
          
          Button {
            
          } label: {
            Image(systemName: "paperclip")
          }
          
          Button {
            
          } label: {
            Image(systemName: "pencil.tip.crop.circle")
          }
          
          Button {
            
          } label: {
            Image(systemName: "siri")
          }
        }
        ToolbarItemGroup(placement: .navigation) {
          Button {
            
          } label: {
            Image(systemName: "square.and.pencil")
          }
        }
      }
  }
}

#Preview {
  NavigationStack {
    NoteDetailView(note: .init(title: "Title1", subTitle: "SubTitle1", content: "Content1"))
  }
}
