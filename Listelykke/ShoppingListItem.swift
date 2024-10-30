
import SwiftUI


// Før iOS 17:
class ShoppingListItemObservableModelOld: ObservableObject, Identifiable {
    let id: UUID
    let created: Date
    
    @Published var text: String
    @Published var checked: Bool
    
    init(id: UUID = UUID(), created: Date, text: String, checked: Bool = false) {
        self.id = id
        self.created = created
        self.text = text
        self.checked = checked
    }
}

// Fra og med iOS 17:
@Observable class ShoppingListItem: Identifiable {
    let id: UUID
    let created: Date

    var text: String
    var checked: Bool
    
    init(id: UUID = UUID(), created: Date = .now, text: String, checked: Bool = false) {
        self.id = id
        self.created = created
        self.text = text
        self.checked = checked
    }
}

// Med @Model
import SwiftData

@Model class ShoppingListItemModel: Identifiable {
    private(set) var id: UUID
    private(set) var created: Date

    var text: String
    var checked: Bool
    
    init(id: UUID = UUID(), created: Date = .now, text: String, checked: Bool = false) {
        self.id = id
        self.created = created
        self.text = text
        self.checked = checked
    }
}
