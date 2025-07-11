import SwiftUI

struct NoteDetailView: View {
  var note: Note
  @Namespace var namespace
  
  var body: some View {
    @Bindable var note = note
    
    TextEditor(text: $note.content)
      .safeAreaInset(edge: .top) {
        Text(note.updatedDate, format: .dateTime)
          .foregroundStyle(.secondary)
          .font(.callout)
      }
      .toolbar {
        #if os(macOS)
        let toolbarPlacement: ToolbarItemPlacement = .secondaryAction
        #else
        let toolbarPlacement: ToolbarItemPlacement = .bottomBar
        #endif
        ToolbarItemGroup(placement: toolbarPlacement) {
          #if os(macOS)
          Button {
            
          } label: {
            Image(systemName: "textformat")
          }
          #endif
          
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
        
        ToolbarSpacer(.flexible, placement: toolbarPlacement)
        
        #if os(macOS)
        let newNotePlacement: ToolbarItemPlacement = .navigation
        #else
        let newNotePlacement: ToolbarItemPlacement = .bottomBar
        #endif
        ToolbarItemGroup(placement: newNotePlacement) {
          Button {
            
          } label: {
            Image(systemName: "square.and.pencil")
          }
        }
        
        #if os(macOS)
        let shareToolPlacement: ToolbarItemPlacement = .primaryAction
        #else
        let shareToolPlacement: ToolbarItemPlacement = .topBarTrailing
        #endif
        
        ToolbarItemGroup(placement: shareToolPlacement) {
          ShareLink(
            item: note,
            preview: SharePreview(
              note.title,
              image: Image(systemName: "star")
            )
          )
          Button {
            
          } label: {
            Image(systemName: "ellipsis")
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
