

import SwiftUI
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ShoppingListItemModel.self, configurations: config)

    for item in Utils.shoppingListItemsExample {
        container.mainContext.insert(item)
    }
    return container
}()
