import Foundation
import CoreTransferable
import Observation

@Observable
final class Note: Identifiable, Hashable, Codable, Transferable {
  var id = UUID()
  var title: String
  var subTitle: String
  var content: AttributedString
  var updatedDate: Date = .now
  
  init(
    title: String,
    subTitle: String,
    content: AttributedString
  ) {
    self.title = title
    self.subTitle = subTitle
    self.content = content
  }
  
  static func == (lhs: Note, rhs: Note) -> Bool {
    lhs.id == rhs.id
    && lhs.title == rhs.title
    && lhs.subTitle == rhs.subTitle
    && lhs.content == rhs.content
    && lhs.updatedDate == rhs.updatedDate
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
    hasher.combine(self.title)
    hasher.combine(self.subTitle)
    hasher.combine(self.content)
    hasher.combine(self.updatedDate)
  }
  
  static var transferRepresentation: some TransferRepresentation {
    CodableRepresentation(for: Note.self, contentType: .content)
  }
}
