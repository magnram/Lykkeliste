import SwiftUI

struct ShoppingListItemView: View {
    let listItem: ShoppingListItem
    
    let deleteItem: (ShoppingListItem) -> Void
    
    var iconImage: String {
        listItem.checked ? "checkmark.circle.fill" :  "circle"
    }
    var iconColor: Color {
        listItem.checked ? .orange : .secondary
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                listItem.checked.toggle()
            }
        }) {
            HStack {
                Image(systemName: iconImage)
                    .foregroundStyle(iconColor)
                    .font(.title3)
                    .padding(.trailing, 5)
                Text(listItem.text)
                    .strikethrough(listItem.checked)
            }
        }
        .contextMenu {
            Button(action: { deleteItem(listItem) }) {
                Text("Delete item")
            }
        }
        .foregroundStyle(.primary)
    }
}
