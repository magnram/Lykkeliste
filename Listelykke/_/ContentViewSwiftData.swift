import SwiftUI
import SwiftData

struct ContentViewSwiftData: View {

    @State private var searchString: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                ContentViewSwiftDataListView(searchString: searchString)
                    .searchable(text: $searchString)
                    .navigationTitle("Handleliste")
            }
        }
    }
}

struct ContentViewSwiftDataListView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var showAddSheet: Bool = false
    
    @Query(sort: \ShoppingListItemModel.created) private var shoppingList: [ShoppingListItemModel]
    
    init(searchString: String) {
        _shoppingList = Query(
            filter: #Predicate { listItem in
                if searchString.isEmpty {
                    return true
                } else {
                    return listItem.text.localizedStandardContains(searchString)
                }
            },
            sort: \ShoppingListItemModel.created
        )
    }
    
    var body: some View {
        let uncheckedShoppingList = shoppingList.filter { $0.checked == false }
        let checkedShoppingList = shoppingList.filter { $0.checked == true }
        List {
            ForEach(uncheckedShoppingList) { listItem in
                ShoppingListItemModelView(listItem: listItem, deleteItem: deleteItem)
            }
            ForEach(checkedShoppingList) { listItem in
                ShoppingListItemModelView(listItem: listItem, deleteItem: deleteItem)
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddShoppingListItemView(addShoppingListItem: addItem)
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    showAddSheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func addItem(text: String) {
        modelContext.insert(ShoppingListItemModel(text: text))
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving: \(error)")
        }
        
        showAddSheet = false
    }
    
    func deleteItem(_ item: ShoppingListItemModel) {
        modelContext.delete(item)
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
}

#Preview {
    ContentViewSwiftData()
        .modelContainer(previewContainer)
}
