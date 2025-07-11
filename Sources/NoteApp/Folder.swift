import Foundation
import CoreTransferable
import Observation
import SwiftUI

@Observable
final class Folder: Identifiable, Hashable, Codable, Transferable {
  var id = UUID()
  var name: String
  var notes: [Note]
  var groupByDateMode: GroupByDateMode = .default
  
  init(
    name: String,
    notes: [Note]
  ) {
    self.name = name
    self.notes = notes
  }
  
  static func == (lhs: Folder, rhs: Folder) -> Bool {
    lhs.id == rhs.id
    && rhs.name == rhs.name
    && lhs.notes == rhs.notes
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(name)
    hasher.combine(notes)
  }
  
  static var transferRepresentation: some TransferRepresentation {
    CodableRepresentation(for: Folder.self, contentType: .content)
  }
}

@MainActor
extension Folder {
  static let folder1 = Folder(
    name: "Folder1",
    notes: [
      .init(title: "Title1", subTitle: "SubTitle1", content: "Content1"),
      .init(title: "Title2", subTitle: "SubTitle2", content: "Content2"),
      .init(title: "Title3", subTitle: "SubTitle3", content: "Content3"),
      .init(title: "Title4", subTitle: "SubTitle4", content: "Content4"),
      .init(title: "Title5", subTitle: "SubTitle5", content: "Content5"),
      .init(title: "Title6", subTitle: "SubTitle6", content: "Content6"),
    ]
  )
}

enum GroupByDateMode: CaseIterable, Codable {
  case `default`
  case on
  case off
  
  var label: LocalizedStringKey {
    switch self {
    case .default: "Default (On)"
    case .on: "On"
    case .off: "Off"
    }
  }
}
