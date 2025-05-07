import SwiftUI

struct SetDetailPageView: View {
    let set: LegoSet

    @State private var showingActionSheet = false

    var body: some View {
        VStack {
            Text("\(set.name)")
                .font(.title)
            Text("Set Number: \(set.set_num)")
            Text("Year: \(set.year)")
            Button("Add") {
                showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("Add to"),
                    buttons: [
                        .default(Text("Collection")) {
                            // Add to collection logic
                        },
                        .default(Text("Wishlist")) {
                            // Add to wishlist logic
                        },
                        .cancel()
                    ]
                )
            }
        }
    }
}
