import SwiftUI

struct AddShoppingListItemView: View {
    @State var text: String = ""
    
    let addShoppingListItem: (String) -> Void
    
    var body: some View {
        List {
            HStack {
                TextField("Enter item name", text: $text)
                Button(action: { addShoppingListItem(text) }) {
                    Text("Add")
                }.disabled(text == "")
            }
            
        }
        .presentationDetents([.fraction(0.2)])
    }
}
