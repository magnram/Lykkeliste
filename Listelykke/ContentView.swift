import SwiftUI

struct ContentView: View {
    @State private var shoppingList: [ShoppingListItem] = Utils.shoppingListExample.sorted { $0.created < $1.created }
    @State private var showAddSheet: Bool = false
    
    func addItem(text: String) {
        shoppingList.append(ShoppingListItem(text: text))
        showAddSheet = false
    }
    
    func deleteItem(_ item: ShoppingListItem) {
        shoppingList.removeAll { $0.id == item.id }
    }
    
    var body: some View {
        let uncheckedShoppingList = shoppingList.filter { $0.checked == false }
        let checkedShoppingList = shoppingList.filter { $0.checked == true }
        
        NavigationStack {
            List {
                ForEach(uncheckedShoppingList) { listItem in
                    ShoppingListItemView(listItem: listItem, deleteItem: deleteItem)
                }
                ForEach(checkedShoppingList) { listItem in
                    ShoppingListItemView(listItem: listItem, deleteItem: deleteItem)
                }
            }
            .navigationTitle("Handleliste")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showAddSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddShoppingListItemView(addShoppingListItem: addItem)
            }
        }
    }
}

#Preview {
    ContentView()
}
